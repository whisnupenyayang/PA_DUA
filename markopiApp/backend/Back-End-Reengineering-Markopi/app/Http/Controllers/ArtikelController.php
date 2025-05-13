<?php

namespace App\Http\Controllers;

use Exception;
use App\Models\Artikel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class ArtikelController extends Controller
{
    public function dashboard()
    {
        return view('fasilitator.dashboard.index', [
            'title' => 'Dashboard'
        ]);
    }

    //artikel admin
    public function artikel_admin()
    {
        $artikels = Artikel::get(); // Atau sesuai kebutuhan
        return view('admin.artikel.artikel', compact('artikels'), [
            'title' => 'Artikel'
        ]);
    }
    


    public function artikel()
    {
        $artikels = Artikel::get();
        return view('fasilitator.artikel.index', compact('artikels'), [
            'title' => 'Artikel'
        ]);
    }

    public function show($id)
    {
        $artikel = Artikel::findOrFail($id);
        return view('fasilitator.artikel.show', compact('artikel'), [
            'title' => 'Detail Artikel'
        ]);
    }

    public function create()
    {
        return view('fasilitator.artikel.create', [
            'title' => 'Buat Artikel Baru'
        ]);
    }

    public function store(Request $request)
    {
        try {
            $id = Auth::user()->id_users;
            $request->validate([
                'judul_artikel' => 'required',
                'isi_artikel' => 'required',
                'gambar.*' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:5120'
            ]);

            $artikel = Artikel::create([
                'judul_artikel' => $request->judul_artikel,
                'isi_artikel' => $request->isi_artikel,
                'user_id' => $id,
            ]);

            if ($artikel) {
                foreach ($request->file('gambar') as $gambar) {
                    $gambarPath = $gambar->store('artikelimage', 'public');
                    $artikel->images()->create([
                        'gambar' => $gambarPath,
                    ]);
                }
                return redirect()->route('artikel.fasilitator')->with('success', 'Informasi Artikel berhasil ditambahkan');
            } else {
                $errorMessage = $artikel->status() . ': ' . $artikel->body();
                throw new Exception('Failed to add product. ' . $errorMessage);
            }
        } catch (Exception $e) {
            return redirect()->back()->with('error', $e->getMessage())->withInput();
        }
    }

    public function edit($id)
    {
        $artikel = Artikel::findOrFail($id);
        return view('fasilitator.artikel.edit', compact('artikel'), [
            'title' => 'Edit Artikel'
        ]);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'judul_artikel' => 'required',
            'isi_artikel' => 'required',
        ]);

        try {
            $artikel = Artikel::findOrFail($id);
            $artikel->judul_artikel = $request->judul_artikel;
            $artikel->isi_artikel = $request->isi_artikel;

            if ($request->hasFile('gambar')) {
                $newImages = [];

                foreach ($request->file('gambar') as $newImage) {
                    $newImagePath = $newImage->store('artikelimage', 'public');
                    $newImages[] = ['gambar' => $newImagePath];
                }

                $this->deleteImages($artikel);

                $artikel->images()->delete();
                $artikel->images()->createMany($newImages);
            }

            $artikel->save();

            if ($artikel) {
                return redirect()->route('artikel.fasilitator')->with('success', 'Data Informasi Artikel Berhasil di Ubah');
            } else {
                throw new Exception('Gagal mengupdate data');
            }
        } catch (Exception $e) {
            return redirect()->back()->with('error', $e->getMessage());
        }
    }

    public function destroy($id)
    {
        try {
            $artikel = Artikel::findOrFail($id);
            $this->deleteImages($artikel);
            $artikel->delete();
            if ($artikel) {
                return redirect()->route('artikel.fasilitator')->with('success', 'Data Informasi Artikel Berhasil dihapus');
            } else {
                throw new Exception('Failed to delete.');
            }
        } catch (Exception $e) {
            return redirect()->back()->with('error', $e->getMessage());
        }
    }

    protected function deleteImages(Artikel $artikel)
    {
        foreach ($artikel->images as $image) {
            Storage::disk('public')->delete($image->gambar);

            $image->delete();
        }
    }
}
