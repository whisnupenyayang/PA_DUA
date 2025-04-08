<?php

namespace App\Models;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Artikel extends Model
{
    use HasFactory;
    protected $table = 'artikels';
    protected $primaryKey = 'id_artikels';

    protected $fillable = [
        'judul_artikel',
        'isi_artikel',
        'user_id',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function images()
    {
        return $this->hasMany(ImageArtikel::class, 'artikel_id')->select([
            'id_image_artikels',
            'artikel_id',
            'gambar',
            DB::raw("CONCAT('" . asset('storage/') . "','/', gambar) as url")
        ]);
    }
}
