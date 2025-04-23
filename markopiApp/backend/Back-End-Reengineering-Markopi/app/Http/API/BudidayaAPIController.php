<?php

namespace App\Http\API;

use App\Models\Minuman;
use App\Models\Budidaya;
use App\Models\Pengajuan;
use App\Models\JenisTahapanBudidaya;
use App\Models\TahapanBudidaya;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Http;

class BudidayaAPIController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        // $budidayas = DB::table('budidayas')
        //     ->join('image_budidayas', 'budidayas.id', '=', 'image_budidayas.budidaya_id')
        //     ->select('budidayas.*', 'image_budidayas.gambar')
        //     ->get();
        $budidayas = Budidaya::with('images')->get();
        return response()->json($budidayas);
    }

    public function getTahapanBudidaya($jenisKopi){
        $tahapanbudidaya = TahapanBudidaya::where('jenis_kopi', $jenisKopi)->get();
        return response()->json($tahapanbudidaya);

    }

    public function getJenisTahapanBudidaya($id){
        $jenisTB = JenisTahapanBudidaya::where('tahapan_budidaya_id', $id)->select('id', 'judul','tahapan_budidaya_id','created_at', 'updated_at' )->get();



        return response()->json($jenisTB);
    }

    public function getJenisTahapBudidayaById($id){
        $jenisTBById = JenisTahapanBudidaya::find($id);

        return response()->json($jenisTBById);
    }


}
