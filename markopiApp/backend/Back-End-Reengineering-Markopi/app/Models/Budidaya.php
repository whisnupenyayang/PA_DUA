<?php

namespace App\Models;

use App\Models\ImageBudidaya;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Budidaya extends Model
{
    use HasFactory;

    protected $table = 'budidayas';
    protected $primaryKey = 'id_budidayas';

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
        return $this->hasMany(ImageBudidaya::class, 'budidaya_id')->select([
            'id_image_budidayas',
            'budidaya_id',
            'gambar',
            DB::raw("CONCAT('" . asset('storage/') . "','/', gambar) as url")
        ]);
    }
}
