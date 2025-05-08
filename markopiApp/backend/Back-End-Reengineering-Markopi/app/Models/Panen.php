<?php

namespace App\Models;

use App\Models\ImageBudidaya;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Panen extends Model
{
    use HasFactory;
    protected $table = 'panens';
    protected $primaryKey = 'id_panens';

    protected $fillable = [
        // 'tahapan',
        'deskripsi',
        'link',
        'sumber_artikel',
        'credit_gambar',
        'kategori'
    ];

    public function images()
    {
        return $this->hasMany(ImagePanen::class, 'panen_id')->select([
            'id_image_panens', 
            'panen_id', 
            'gambar',
            DB::raw("CONCAT('" . asset('storage/') . "','/', gambar) as url")]);
    }
}
