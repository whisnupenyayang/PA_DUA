<?php

namespace App\Http\Controllers;

use App\Models\Pengepul;
use Illuminate\Http\Request;

class PengepulController extends Controller
{
    // Menampilkan semua pengepul
    public function index()
    {
        $title = 'Data Pengepul'; // Menetapkan nilai untuk $title
        $pengepuls = Pengepul::all();

        return view('admin.pengepul.pengepul', compact('pengepuls', 'title'));
    }

    // Menampilkan detail pengepul berdasarkan ID
    public function show($id)
    {
        $pengepul = Pengepul::find($id);

        if (!$pengepul) {
            return redirect()->route('admin.pengepul')->with('error', 'Pengepul not found');
        }

        $title = 'Detail Pengepul'; // Menetapkan nilai untuk $title
        return view('admin.pengepul.detail', compact('pengepul', 'title'));
    }

    


    // Menangani permintaan update data inline melalui AJAX
    public function updateField(Request $request)
{
    $pengepul = Pengepul::find($request->id);

    if (!$pengepul) {
        return response()->json(['success' => false, 'message' => 'Data tidak ditemukan']);
    }

    $field = $request->field;
    $value = $request->value;

    if (in_array($field, ['alamat', 'jenis_kopi', 'jenis_produk', 'harga'])) {
        $pengepul->$field = $value;
        $pengepul->save();
        return response()->json(['success' => true]);
    }

    return response()->json(['success' => false, 'message' => 'Field tidak valid']);
}

}
