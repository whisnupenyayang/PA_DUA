<?php

namespace App\Http\Controllers\Api;

use App\Models\Toko;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class TokoController extends Controller
{
    public function index()
    {
        $tokos = Toko::all();  // Mengambil semua data toko
        return response()->json($tokos);  // Mengembalikan data dalam format JSON
    }

    public function show($id)
    {
        $toko = Toko::find($id);  // Mencari toko berdasarkan ID
        if ($toko) {
            return response()->json($toko);  // Mengembalikan data toko dalam format JSON
        } else {
            return response()->json(['message' => 'Toko tidak ditemukan'], 404);  // Jika toko tidak ditemukan
        }
    }
}
