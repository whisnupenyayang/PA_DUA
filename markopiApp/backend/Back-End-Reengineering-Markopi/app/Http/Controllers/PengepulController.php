<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PengepulController extends Controller
{
    public function index()
    {
        return view('admin.pengepul.pengepul', [
            'title' => 'Daftar Pengepul'
        ]);
    }
}
