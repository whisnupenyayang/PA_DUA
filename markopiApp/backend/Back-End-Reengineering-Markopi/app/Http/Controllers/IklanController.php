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

        $data = $request->only(['judul_iklan', 'deskripsi_iklan', 'link']);
        $iklan->update(array_filter($data)); // hanya update field yang dikirim

        return redirect()->route('iklan.show', $iklan->id_iklan)->with('success', 'Berhasil diperbarui.');
    }

    public function create()
    {
        $title = 'Tambah Iklan';

        return view('admin.iklan.tambah', compact('title'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'judul_iklan' => 'required|string|max:255',
            'deskripsi_iklan' => 'required|string',
            'link' => 'required|string|max:100',
            'gambar' => 'required|image|mimes:jpg,jpeg,png|max:2048'
        ]);

        $file = $request->file('gambar');
        $namaFile = time() . '_' . $file->getClientOriginalName();
        $file->move(public_path('foto'), $namaFile);

        Iklan::create([
            'judul_iklan' => $request->judul_iklan,
            'deskripsi_iklan' => $request->deskripsi_iklan,
            'link' => $request->link,
            'gambar' => $namaFile
        ]);

        return redirect()->route('iklan.index')->with('success', 'Iklan berhasil ditambahkan.');
    }
}
