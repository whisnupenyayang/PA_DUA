<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Toko;

class TokoController extends Controller
{
    public function index()
    {
        $toko = Toko::all();
        return view('admin.toko', compact('toko'));
    }

    public function create()
    {
        return view('admin.tambah_toko');
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_toko' => 'required|max:255',
            'lokasi' => 'required',
            'jam_operasional' => 'required',
            'foto_toko' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $toko = new Toko();
        $toko->nama_toko = $request->nama_toko;
        $toko->lokasi = $request->lokasi;
        $toko->jam_operasional = $request->jam_operasional;

        if ($request->hasFile('foto_toko')) {
            $imageName = time().'.'.$request->foto_toko->extension();
            $request->foto_toko->move(public_path('images'), $imageName);
            $toko->foto_toko = $imageName;
        }

        $toko->save();

        return redirect()->route('toko.index')->with('success', 'Toko berhasil ditambahkan!');
    }
}
