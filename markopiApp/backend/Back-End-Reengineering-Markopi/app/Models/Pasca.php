<?php

namespace App\Models;

use App\Models\ImagePasca;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Pasca extends Model
{
    use HasFactory;
    protected $table = 'pascas';
    protected $primaryKey = 'id_pascas';

    protected $fillable = [
        'tahapan',
        'deskripsi',
        'link',
        'sumber_artikel',
        'credit_gambar',
        'kategori'
    ];

    public function images()
    {
        return $this->hasMany(ImagePasca::class,  'pasca_id')->select([
            'id_image_pascas', 
            'pasca_id', 
            'gambar',
            DB::raw("CONCAT('" . asset('storage/') . "','/', gambar) as url")]);
    }
}
