<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class VideoPanen extends Model
{
    use HasFactory;

    protected $table = 'video_panens';
    protected $primaryKey = 'id_video_panen';

    protected $fillable = [
        'id_panens',
        'video',
    ];

    // Relasi dengan Panen
    public function panen()
    {
        return $this->belongsTo(Panen::class, 'id_panens');
    }
}
