<?php

namespace App\Models;

use App\Models\Budidaya;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ImageBudidaya extends Model
{
    use HasFactory;
    protected $table = 'image_budidayas';
    protected $primaryKey = 'id_image_budidayas';

    protected $fillable = [
        'gambar',
        'budidaya_id',
    ];

    public function budidaya()
    {
        return $this->belongsTo(Budidaya::class, 'budidaya_id');
    }
}
