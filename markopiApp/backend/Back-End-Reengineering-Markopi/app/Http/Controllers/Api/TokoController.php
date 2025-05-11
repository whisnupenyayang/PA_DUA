<?php

namespace App\Http\Controllers\Api;

use App\Models\Toko;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\URL;

class TokoController extends Controller
{
    public function index()
    {
        $tokos = Toko::all()->map(function ($toko) {
            $toko->foto_toko = $toko->foto_toko
                ? URL::to('/images/' . $toko->foto_toko)
                : null;
            return $toko;
        });

        return response()->json($tokos);
    }
    public function show($id)
    {
        $toko = Toko::find($id);
        if ($toko) {
            $toko->foto_toko = $toko->foto_toko
                ? URL::to('/images/' . $toko->foto_toko)
                : null;
            return response()->json($toko);
        } else {
            return response()->json(['message' => 'Toko tidak ditemukan'], 404);
        }
    }
}
