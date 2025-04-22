<?php

namespace App\Http\API;

use App\Models\Minuman;
use App\Models\Budidaya;
use App\Models\Pengajuan;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Models\JenisTahapanBudidaya;
use App\Models\TahapanBudidaya;
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

    public function getJenisTahapanBudidaya($jeniskopi,$id){
        $jenisTB = JenisTahapanBudidaya::where('tahapan_budidaya_id', $id);

        return response()->json($jenisTB);
    }


    public function getPemilihanLahanData()
    {
        // dd('hais');

        $budidayaData = Budidaya::with('images')->where('kategori', 'Pemilihan Lahan')->get();
        return response()->json($budidayaData);
    }

    public function getKesesuaianLahanData()
    {
        $budidayaData = Budidaya::with('images')->where('kategori', 'Kesesuaian Lahan')->get();
        return response()->json($budidayaData);
    }

    public function getPersiapanLahanData()
    {
        $budidayaData = Budidaya::with('images')->where('kategori', 'Persiapan Lahan')->get();
        return response()->json($budidayaData);
    }

    public function getPenanamanPenaungData()
    {
        $budidayaData = Budidaya::with('images')->where('kategori', 'Penanaman Penaung')->get();
        return response()->json($budidayaData);
    }

    public function getBahanTanamUnggulData()
    {
        $budidayaData = Budidaya::with('images')->where('kategori', 'Bahan Tanam Unggul')->get();
        return response()->json($budidayaData);
    }

    public function getPembibitanData()
    {
        $budidayaData = Budidaya::with('images')->where('kategori', 'Pembibitan')->get();
        return response()->json($budidayaData);
    }

    public function getPenanamanData()
    {
        $budidayaData = Budidaya::with('images')->where('kategori', 'Penanaman')->get();
        return response()->json($budidayaData);
    }

    public function getPemupukanData()
    {
        $budidayaData = Budidaya::with('images')->where('kategori', 'Pemupukan')->get();
        return response()->json($budidayaData);
    }

    public function getPemangkasanData()
    {
        $budidayaData = Budidaya::with('images')->where('kategori', 'Pemangkasan')->get();
        return response()->json($budidayaData);
    }

    public function getPengelolaanPenaungData()
    {
        $budidayaData = Budidaya::with('images')->where('kategori', 'Pengelolaan Penaung')->get();
        return response()->json($budidayaData);
    }

    public function getPengendalianHamaData()
    {
        $budidayaData = Budidaya::with('images')->where('kategori', 'LIKE', '%Hama%')->get();
        return response()->json($budidayaData);
    }

    public function select_tahapan()
    {
        $tahapan = DB::table('budidayas')
            ->select('tahapan')
            ->get();
        return response()->json($tahapan);
    }

    public function getMinumanData()
    {
        $minumanData = Minuman::with('images')->get();
        return response()->json($minumanData);
    }

    public function getKomunitasData()
    {
        $komunitas = Pengajuan::select('pengajuans.foto_selfie', 'pengajuans.deskripsi_pengalaman', 'pengajuans.no_telp', 'pengajuans.kabupaten', 'users.username')
            ->join('users', 'pengajuans.petani_id', '=', 'users.id_users')
            ->where('pengajuans.status', '1')
            ->get();
        // Transformasi URL foto_selfie
        $komunitas = $komunitas->map(function ($item) {
            $item['foto_selfie'] = url("storage/" . $item['foto_selfie']);
            return $item;
        });

        return response()->json($komunitas);
    }
}
