<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Pengepul;
use Illuminate\Http\Request;

class PengepulController extends Controller
{
    public function index() {
        $pengepuls = Pengepul::get();
        return response()->json([
            'data' => $pengepuls
        ]);
    }

    public function pengepulDetail($id){
        $pengupul = Pengepul::find($id);

        return response()->json(
            ['data' => $pengupul]
        );

    }

    public function store(Request $request){
        $request->validate(

        )
    }
}
