<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Iklan;
use Illuminate\Http\Request;

class IklanController extends Controller
{
    public function index()
    {
        // Ambil semua Iklan dari database
        $Iklans = Iklan::all();
        return response()->json($Iklans);
    }

    // Tambahkan fungsi lain sesuai kebutuhan
}
