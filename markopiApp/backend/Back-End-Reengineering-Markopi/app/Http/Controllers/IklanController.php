<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Iklan;

class IklanController extends Controller
{
    public function index()
    {
        $title = 'Data Iklan';
        $iklans = Iklan::all();

        return view('admin.iklan.iklan', compact('iklans', 'title'));
    }

    public function show($id)
    {
        $iklan = Iklan::findOrFail($id);
        $title = 'Detail Iklan';

        return view('admin.iklan.detail', compact('iklan', 'title'));
    }

    public function update(Request $request, $id)
    {
        $iklan = Iklan::findOrFail($id);

        $data = $request->only(['judul', 'deskripsi', 'harga', 'kontak']);
        $iklan->update(array_filter($data)); // hanya update yang dikirim

        return redirect()->route('iklan.show', $iklan->id)->with('success', 'Berhasil diperbarui.');
    }

    public function create()
    {
        $title = 'Tambah Iklan';

        return view('admin.iklan.tambah', compact('title'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'judul' => 'required|string|max:255',
            'deskripsi' => 'required|string',
            'harga' => 'required|numeric',
            'kontak' => 'required|string|max:100',
            'gambar_produk' => 'required|image|mimes:jpg,jpeg,png|max:2048'
        ]);

        // Simpan file gambar ke folder public/foto
        $gambar = $request->file('gambar_produk');
        $namaFile = time() . '_' . $gambar->getClientOriginalName();
        $gambar->move(public_path('foto'), $namaFile);

        Iklan::create([
            'judul' => $request->judul,
            'deskripsi' => $request->deskripsi,
            'harga' => $request->harga,
            'kontak' => $request->kontak,
            'gambar_produk' => $namaFile
        ]);

        return redirect()->route('iklan.index')->with('success', 'Iklan berhasil ditambahkan.');
    }
}
