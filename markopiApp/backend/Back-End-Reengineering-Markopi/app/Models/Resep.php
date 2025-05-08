<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Resep extends Model
{
    use HasFactory;

    protected $table = 'Resep';

    protected $primaryKey = 'resep_id';

    protected $fillable = [
        'nama_resep',
        'deskripsi_resep',
        'gambar_resep',
    ];
}
