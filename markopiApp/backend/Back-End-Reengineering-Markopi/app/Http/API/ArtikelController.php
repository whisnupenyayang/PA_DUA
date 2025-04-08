<?php

namespace App\Http\API;

use App\Models\User;
use App\Models\Artikel;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\ArtikelResourc;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class ArtikelController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $artikels = Artikel::with('images')->get();
        // return response()->json($artikels);
        return ArtikelResourc::collection($artikels);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        try {
            $request->validate([
                'judul_artikel' => 'required|string',
                'isi_artikel' => 'required|string',
                'gambar' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                'user_id' => 'required',
            ]);

            $artikel = Artikel::create([
                'judul_artikel' => $request->judul_artikel,
                'isi_artikel' => $request->isi_artikel,
                'user_id' => $request->user_id,
            ]);

            if ($artikel) {
                $gambar = null;
                if ($request->hasFile('gambar')) {
                    $uploadedFile = $request->file('gambar');
                    if ($uploadedFile->isValid()) {
                        $gambarPath = $uploadedFile->store('artikelimage', 'public');
                        // Simpan gambar ke tabel image_artikels
                        $artikel->images()->create(['gambar' => $gambarPath]);
                    } else {
                        return response()->json(['message' => 'Gagal mengunggah Gambar', 'status' => 'error', 'error' => 'Invalid file'], 400);
                    }
                }

                // Generate URL for the image
                $gambarUrl = $gambarPath ? asset('storage/' . $gambarPath) : null;

                // Data added successfully, include image URL in the response
                return response()->json([
                    'message' => 'Artikel berhasil ditambahkan',
                    'status' => 'success',
                    'gambar' => $gambarUrl,
                ], 200);
            } else {
                // Failed to add data
                return response()->json(['message' => 'Gagal menambahkan data', 'status' => 'error', 'error' => 'Failed to save data to the database'], 500);
            }
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal menambahkan data', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {
            $artikel = Artikel::with('images')->find($id);

            if (!$artikel) {
                return response()->json(['message' => 'Artikel not found', 'status' => 'error'], 404);
            }

            return response()->json(['data' => $artikel, 'status' => 'success'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to fetch artikel', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {
            $validator = Validator::make($request->all(), [
                'judul_artikel' => 'required|string',
                'isi_artikel' => 'required|string',
                'gambar' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            ]);

            // Jika validasi gagal
            if ($validator->fails()) {
                return response()->json($validator->errors(), 422);
            }

            $artikel = Artikel::find($id);

            if (!$artikel) {
                return response()->json(['message' => 'Artikel not found', 'status' => 'error'], 404);
            }

            // $artikel->judul_artikel = $request->judul_artikel;
            // $artikel->isi_artikel = $request->isi_artikel;

            if ($request->hasFile('gambar')) {
                $uploadedFile = $request->file('gambar');
                if ($uploadedFile->isValid()) {
                    $gambarPath = $uploadedFile->store('artikelimage', 'public');

                    if ($artikel->images()->exists()) {
                        $artikel->images()->first()->delete();
                    }
                }
                $artikel->images()->create(['gambar' => $gambarPath]);
            } else {
                return response()->json(['message' => 'Gagal mengunggah Gambar', 'status' => 'error', 'error' => 'Invalid file'], 400);
            }

            // Save updated artikel
            $artikel->update([
                'judul_artikel' => $request->judul_artikel,
                'isi_artikel' => $request->isi_artikel,
            ]);

            return response()->json(['message' => 'Artikel berhasil diperbarui', 'status' => 'success'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to update artikel', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {
            $artikel = Artikel::find($id);

            if (!$artikel) {
                return response()->json(['message' => 'Artikel not found', 'status' => 'error'], 404);
            }

            $artikel->images->each(function ($image) {
                Storage::disk('public')->delete($image->gambar);
            });

            // Delete associated images
            $artikel->images()->delete();

            // Delete the artikel itself
            $artikel->delete();

            return response()->json(['message' => 'Artikel berhasil dihapus', 'status' => 'success'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to delete artikel', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    public function articlesByUser($user_id)
    {
        try {
            // Get authenticated user
            $artikels = Artikel::with('images')->where('user_id', $user_id)->get();

            if (!$artikels) {
                return response()->json(['message' => 'User not found', 'status' => 'error'], 404);
            }

            return response()->json($artikels, 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to fetch articles by user', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }
}
