<?php

namespace App\Models;

use App\Models\Pasca;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ImagePasca extends Model
{
    use HasFactory;
    protected $table = 'image_pascas';
    protected $primaryKey = 'id_image_pascas';

    protected $fillable = [
        'gambar',
        'pasca_id'
    ];

    public function pasca()
    {
        return $this->belongsTo(Pasca::class,  'pasca_id');
    }
}
