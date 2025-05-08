<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Toko extends Model
{
    use HasFactory;

    // Nama tabel eksplisit (opsional jika nama file sudah sesuai konvensi Laravel)
    protected $table = 'toko';

    // Primary key khusus
    protected $primaryKey = 'toko_id';

    // Field yang bisa diisi (mass assignment)
    protected $fillable = [
        'nama_toko',
        'lokasi',
        'jam_operasional',
        'foto_toko',
    ];

    // Optional: jika Anda tidak ingin menggunakan Laravel's timestamp default 'created_at', 'updated_at'
    // public $timestamps = false;
}
