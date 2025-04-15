<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Pengepul;
use Illuminate\Http\Request;

class PengepulController extends Controller
{
    public function index() {
        $pengepuls = Pengepul::get();
        return response()->json([
            'data' => $pengepuls
        ]);
    }

    public function pengepulDetail($id){
        $pengupul = Pengepul::find($id);

        return response()->json(
            ['data' => $pengupul]
        );

    }

    public function store(Request $request){
        $request->validate([
            'nama_toko' => 'required',
            'jenis_kopi' => 'required',
            'harga' => 'required',
            'nomor_telepon' => 'required',
            'alamat' => 'required',
        ]
        );

        $peengepul = Pengepul::create([
            'nama_toko' => $request->nama_toko,
            'jenis_kopi' => $request->jenis_kopi,
            'harga' => $request->harga,
            'nomor_telepon' => $request->nomor_telepon,
            'alamat' => $request->alamat
        ]
        );


        return response()->json( [
            'massage' => 'sukses'
        ]

        );
    }
}
