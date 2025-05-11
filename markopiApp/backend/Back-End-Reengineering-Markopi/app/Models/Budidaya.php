<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Support\Facades\DB;

class Budidaya extends Model
{
    use HasFactory;

    protected $table = 'budidayas';
    protected $primaryKey = 'id_budidayas';

    protected $fillable = [
        'judul',
        'deskripsi',
        'link',
        'kategori',
        'jenis_kopi',
        'video',
    ];

    public function images()
    {
        return $this->hasMany(ImageBudidaya::class, 'budidaya_id')->select([
            'id_image_budidayas',
            'budidaya_id',
            'gambar',
            DB::raw("CONCAT('" . asset('storage/') . "', '/', gambar) as url")
        ]);
    }

    public function videos()
    {
        return $this->hasMany(VideoBudidaya::class, 'budidaya_id')->select([
            'id',
            'budidaya_id',
            'video',
            DB::raw("CONCAT('" . asset('storage/') . "', '/', video) as url")
        ]);
    }
}
