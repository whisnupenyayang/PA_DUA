<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class IklanController extends Controller
{
    public function index()
    {
        $iklans = [
            (object)[
                'id' => 1,
                'judul' => 'Iklan Toba Jaya',
                'deskripsi' => 'Jl. Lintong Nihuta No.10, Toba',
                'harga' => 60000,
                'kontak' => 'Green Bean',
                'gambar_produk' => 'jurica-koletic-7YVZYZeITc8-unsplash.jpg',
            ],
            (object)[
                'id' => 2,
                'judul' => 'Iklan Toba Jaya',
                'deskripsi' => 'Jl. Lintong Nihuta No.10, Toba',
                'harga' => 60000,
                'kontak' => 'Green Bean',
                'gambar_produk' => 'jurica-koletic-7YVZYZeITc8-unsplash.jpg',
            ],
            (object)[
                'id' => 3,
                'judul' => 'Iklan Toba Jaya',
                'deskripsi' => 'Jl. Lintong Nihuta No.10, Toba',
                'harga' => 60000,
                'kontak' => 'Green Bean',
                'gambar_produk' =>'jurica-koletic-7YVZYZeITc8-unsplash.jpg',
            ],
        ];


        $title = 'Data Iklan';

        return view('admin.iklan.iklan', compact('iklans', 'title'));
    }
}
