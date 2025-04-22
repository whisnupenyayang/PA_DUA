<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class IklanController extends Controller
{
    public function index()
    {
        return view('admin.iklan.iklan', [
            'title' => 'Daftar Iklan'
        ]);
    }
}
