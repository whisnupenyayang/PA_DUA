<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Iklan extends Model
{
    use HasFactory;

    protected $table = 'iklan';

    protected $primaryKey = 'id_iklan';

    public $timestamps = false; 

    protected $fillable = [
        'judul_iklan',
        'deskripsi_iklan',
        'gambar',
        'link',
    ];
}

