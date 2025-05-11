<?php
namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class ArtikelController extends Controller
{
    public function artikel_admin()
    {
        $artikels = [
            [
                'id_artikels' => 1,
                'judul_artikel' => 'Cara Menanam Kopi yang Baik',
            ],
            [
                'id_artikels' => 2,
                'judul_artikel' => 'Perawatan Tanaman Kopi Arabika',
            ],
            [
                'id_artikels' => 3,
                'judul_artikel' => 'Panen dan Pascapanen Kopi',
            ],
        ];

        $title = 'Data Artikel';

        return view('admin.artikel.artikel', compact('artikels', 'title'));
    }
}
