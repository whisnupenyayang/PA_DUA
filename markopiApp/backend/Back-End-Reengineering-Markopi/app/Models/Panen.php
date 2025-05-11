<?php

namespace App\Models;

use App\Models\VideoPanen; // Pastikan import model VideoPanen
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Panen extends Model
{
    use HasFactory;

    protected $table = 'panens';
    protected $primaryKey = 'id_panens';

    protected $fillable = [
        'deskripsi',
        'link',
        'credit_gambar',
        'judul',
        'kategori'
    ];

    // Relasi untuk gambar (mungkin sudah ada sebelumnya)
    public function images()
    {
        return $this->hasMany(ImagePanen::class, 'panen_id')->select([
            'id_image_panens', 
            'panen_id', 
            'gambar',
            DB::raw("CONCAT('" . asset('storage/') . "','/', gambar) as url")
        ]);
    }

    // Relasi untuk video (penambahan relasi baru)
    public function videos()
    {
        return $this->hasMany(VideoPanen::class, 'id_panens')->select([
            'id_video_panen', 
            'id_panens', 
            'video',
            DB::raw("CONCAT('" . asset('storage/') . "','/', video) as url")
        ]);
    }
}
