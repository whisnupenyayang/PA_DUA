<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Resep;
use Illuminate\Http\Request;

class ResepController extends Controller
{
    public function index()
    {
        // Ambil semua resep dari database
        $reseps = Resep::all();
        return response()->json($reseps);
    }

    // Tambahkan fungsi lain sesuai kebutuhan
}
