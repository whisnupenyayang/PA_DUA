<?php

namespace App\Http\API;


use App\Http\Controllers\Controller;
use App\Models\Pengepul;
use App\Models\RataRataHergaKopi;
use Illuminate\Auth\Events\Validated;
use Illuminate\Http\Request;


class PengepulApiController extends Controller
{
    public function getPengepul(){
        $pengepul = Pengepul::all();

        return response()->json($pengepul);
    }

    public function storePengepul(Request $request){
        $request->validate([
            'nama_toko'=>'required',
            'jenis_kopi'=>'required',
            'harga'=> 'required',
            'nomor_telepon'=> 'required',
            'alamat'=> 'required',
        ]);

        $pengepul = Pengepul::create([
            'nama_toko' => $request->nama_toko,
            'jenis_kopi' => $request->jenis_kopi,
            'harga' => $request->harga,
            'nomor_telepon' => $request->nomor_telepon,
            'alamat' => $request->alamat,

        ]);

        if($pengepul){
            $pengepuls = Pengepul::where('jenis_kopi',$pengepul->jenis_kopi)->select('harga')->get();
            $count = 0;
            $jumlahHarga = 0;
            foreach($pengepuls as $p){
                $jumlahHarga += $p->harga;
                $count++;
            }
            $ratarata = $jumlahHarga / $count;


            $ratarataHargaKopi = RataRataHergaKopi::create([
                'jenis_kopi' =>$pengepul->jenis_Kopi,
                'rata_rata_harga'=>$ratarata
            ]);

        }
    }
}
