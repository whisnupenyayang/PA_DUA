<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class PengepulController extends Controller
{
    public function index()
    {
        $pengepuls = [
            (object)[
                'id' => 1,
                'nama' => 'Pengepul Toba Jaya',
                'alamat' => 'Jl. Lintong Nihuta No.10, Toba',
                'jenis_kopi' => 'Arabika',
                'jenis_produk' => 'Green Bean',
                'harga_perkilo' => 60000,
                'Foto_pengepul' =>'jurica-koletic-7YVZYZeITc8-unsplash.jpg', 
            ],
            (object)[
                'id' => 2,
                'nama' => 'Kopi Mantap Mandiri',
                'alamat' => 'Balige, Toba',
                'jenis_kopi' => 'Robusta',
                'jenis_produk' => 'Roasted Bean',
                'harga_perkilo' => 55000,
                'Foto_pengepul' =>'jurica-koletic-7YVZYZeITc8-unsplash.jpg', 
            ],
            (object)[
                'id' => 3,
                'nama' => 'Sumatera Kopi Raya',
                'alamat' => 'Sianjur Mula-mula, Samosir',
                'jenis_kopi' => 'Arabika',
                'jenis_produk' => 'Bubuk',
                'harga_perkilo' => 75000,
                'Foto_pengepul' =>'jurica-koletic-7YVZYZeITc8-unsplash.jpg', 
            ],
        ];

        $title = 'Data Pengepul Kopi';

        return view('admin.pengepul.pengepul', compact('pengepuls', 'title'));
    }
    public function detail($id)
    {
        $pengepuls = [
            1 => (object)[
                'id' => 1,
                'nama' => 'Pengepul Toba Jaya',
                'alamat' => 'Jl. Lintong Nihuta No.10, Toba',
                'jenis_kopi' => 'Arabika',
                'jenis_produk' => 'Green Bean',
                'harga_perkilo' => 60000,
                'foto' => 'pengepul1.jpg',
            ],
            2 => (object)[
                'id' => 2,
                'nama' => 'Kopi Mantap Mandiri',
                'alamat' => 'Balige, Toba',
                'jenis_kopi' => 'Robusta',
                'jenis_produk' => 'Roasted Bean',
                'harga_perkilo' => 55000,
                'foto' => 'pengepul1.jpg',
            ],
            3 => (object)[
                'id' => 3,
                'nama' => 'Sumatera Kopi Raya',
                'alamat' => 'Sianjur Mula-mula, Samosir',
                'jenis_kopi' => 'Arabika',
                'jenis_produk' => 'Bubuk',
                'harga_perkilo' => 75000,
                'foto' => 'pengepul1.jpg',
            ],
        ];

        $pengepul = $pengepuls[$id] ?? null;

        if (!$pengepul) {
            abort(404);
        }

        $title = 'Detail Pengepul';

        return view('admin.pengepul.detail', compact('pengepul', 'title'));
    }
}
