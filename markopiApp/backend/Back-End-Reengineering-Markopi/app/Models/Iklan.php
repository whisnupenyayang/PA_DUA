<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Iklan extends Model
{
    use HasFactory;

    protected $table = 'iklans'; // Sesuaikan jika nanti nama tabelnya beda

    protected $fillable = [
        'judul',
        'deskripsi',
        'gambar',
        'link',
        'kategori',
    ];
}
