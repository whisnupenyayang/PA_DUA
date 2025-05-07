<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TahapanKegiatan extends Model
{
    use HasFactory;

    protected $fillable = [
     'nama_tahapan',
     'kegiatan',
     'jenis_kopi',
    ];
}
