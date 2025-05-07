<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JenisTahapanKegiatan extends Model
{
    use HasFactory;


    protected $fillable = [
        'judul',
        'deskripsi',
        'nama_file',
        'url_gambar',
        'tahapan_kegiatan_id'
    ];
}
