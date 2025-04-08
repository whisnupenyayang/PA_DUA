<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ImageArtikel extends Model
{
    use HasFactory;
    protected $table = 'image_artikels';
    protected $primaryKey = 'id_image_artikels';

    protected $fillable = [
        'gambar',
        'artikel_id',
    ];

    public function artikel()
    {
        return $this->belongsTo(Artikel::class, 'artikel_id');
    }
}
