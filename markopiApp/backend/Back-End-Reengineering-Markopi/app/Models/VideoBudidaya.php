<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class VideoBudidaya extends Model
{
    protected $table = 'video_budidayas';
    protected $primaryKey = 'id';

    protected $fillable = [
        'budidaya_id',
        'video',
    ];

    /**
     * Relasi ke tabel Budidaya
     */
    public function budidaya()
    {
        return $this->belongsTo(Budidaya::class, 'budidaya_id');
    }
}
