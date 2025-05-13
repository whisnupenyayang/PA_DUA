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
        return view('admin.dashboard.index', [
            'title' => 'Dashboard'
        ]);
    }

    // List artikel untuk admin
    public function artikel_admin()
    {
        $artikels = Artikel::with('images')->get(); // Mengambil artikel beserta gambar terkait
        return view('admin.artikel.artikel', compact('artikels'), [
            'title' => 'Artikel'
        ]);
    }

    // Tampilkan form tambah artikel
    public function create()
    {
        return view('admin.artikel.create', [
            'title' => 'Buat Artikel Baru'
        ]);
    }

    // Proses penyimpanan artikel
    public function store(Request $request)
    {
        try {
            // Validasi input
            $request->validate([
                'judul_artikel' => 'required|string|max:255',
                'isi_artikel' => 'required|string',
                'gambar.*' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048'
            ]);

            // Simpan data artikel
            $artikel = Artikel::create([
                'judul_artikel' => $request->judul_artikel,
                'isi_artikel' => $request->isi_artikel,
                'user_id' => Auth::check() ? Auth::id() : null, // User dapat null jika tidak ada yang login
            ]);

            // Simpan gambar jika ada
            if ($request->hasFile('gambar')) {
                foreach ($request->file('gambar') as $file) {
                    $filename = time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();
                    $file->move(public_path('images'), $filename); // Menyimpan gambar ke folder public/images

                    // Simpan path gambar ke relasi
                    $artikel->images()->create([
                        'gambar' => 'images/' . $filename // Simpan path gambar relatif
                    ]);
                }
            }

            return redirect()->route('artikel.admin')->with('success', 'Artikel berhasil ditambahkan!');
        } catch (Exception $e) {
            return redirect()->back()->with('error', $e->getMessage())->withInput();
        }
    }


    // Tampilkan detail artikel
    public function show($id)
    {
        $artikel = Artikel::with('images')->findOrFail($id);
        return view('admin.artikel.show', compact('artikel'), [
            'title' => 'Detail Artikel'
        ]);
    }

    // Tampilkan form edit artikel
    public function edit($id)
    {
        $artikel = Artikel::findOrFail($id);
        return view('admin.artikel.edit', compact('artikel'), [
            'title' => 'Edit Artikel'
        ]);
    }

    // Proses update artikel
    public function update(Request $request, $id)
    {
        try {
            $request->validate([
                'judul_artikel' => 'required',
                'isi_artikel' => 'required',
            ]);

            $artikel = Artikel::findOrFail($id);
            $artikel->judul_artikel = $request->judul_artikel;
            $artikel->isi_artikel = $request->isi_artikel;

            // Proses gambar jika ada
            if ($request->hasFile('gambar')) {
                // Menghapus gambar yang lama
                $this->deleteImages($artikel);

                $newImages = [];
                foreach ($request->file('gambar') as $newImage) {
                    $newImagePath = $newImage->store('artikelimage', 'public');
                    $newImages[] = ['gambar' => $newImagePath];
                }

                // Menyimpan gambar baru
                $artikel->images()->createMany($newImages);
            }

            $artikel->save();

            return redirect()->route('artikel.admin')->with('success', 'Data Artikel berhasil diperbarui');
        } catch (Exception $e) {
            return redirect()->back()->with('error', $e->getMessage());
        }
    }

    // Hapus artikel
    public function destroy($id)
    {
        try {
            $artikel = Artikel::findOrFail($id);

            // Hapus gambar terkait artikel
            $this->deleteImages($artikel);

            // Hapus artikel
            $artikel->delete();

            return redirect()->route('artikel.admin')->with('success', 'Artikel berhasil dihapus');
        } catch (Exception $e) {
            return redirect()->back()->with('error', $e->getMessage());
        }
    }

    // Hapus semua gambar terkait artikel
    protected function deleteImages(Artikel $artikel)
    {
        // Hapus gambar dari storage dan relasi database
        foreach ($artikel->images as $image) {
            Storage::disk('public')->delete($image->gambar);
            $image->delete();
        }
    }
}
