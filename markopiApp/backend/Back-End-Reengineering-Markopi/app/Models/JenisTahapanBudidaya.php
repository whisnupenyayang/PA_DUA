<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class   JenisTahapanBudidaya extends Model
{
    use HasFactory;

    protected $fillable =[
        'judul',
        'deskripsi',
        'tahapan_budidaya_id',
    ];


}
