<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TahapanBudidaya extends Model
{
    use HasFactory;
    protected $fillable = [
        'nama_tahapan',
        'jenis_kopi',

    ];

    public function jenisTahapanBudidaya(){
        return $this->hasMany(JenisTahapanBudidaya::class)->select([
            'id',
            'judul',
        ]);
    }
}
