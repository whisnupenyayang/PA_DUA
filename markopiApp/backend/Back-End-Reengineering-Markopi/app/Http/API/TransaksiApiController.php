<?php

namespace App\Http\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\PengajuanTransaksi;

class TransaksiApiController extends Controller
{
    public function createPengajuanTransaksi($id){
        $pengajuan = PengajuanTransaksi::create([
            'keterengan' => 'belum selesai',
            'id_user_pengaju' => 1,
            'id_user_penerima' => $id,
        ]);

        if ($pengajuan) {
            return response()->json('berhasil');
        } else {
            return response()->json('gagal', 500);
        }
    }

    public function updateKeterangan(Request $request, $id)
    {


        $pengajuan = PengajuanTransaksi::findOrFail($id);
        $keteranganPengajuan = $pengajuan->keterengan;
        if($keteranganPengajuan == 'dibatalkan' || $keteranganPengajuan == 'ditolak'){
            return response()->json('sudah dibatalkan atau ditolak');
        }
        $user = $request->user(); // pastikan kamu pakai auth:api atau sejenisnya
        $userid = $user->id_users;

        $keterangan = $request->keterengan;


        if($keterangan == 'setuju' || $keterangan == 'ditolak'){

            if ($userid == $pengajuan->id_user_penerima) {
                    $pengajuan->update($request->only(['keterengan']));
                    if($keterangan == 'setuju'){
                        return response()->json(['message' => 'Keterangan berhasil dan buat transaksi'], 200);
                    }
                    return response()->json(['message' => 'Keterangan berhasil diperbarui'], 200);
                }

             return response()->json(['message' => 'Akses ditolak'], 403);
            } else if($keterangan == 'dibatalkan'){

                if ($userid == $pengajuan->id_user_pengaju) {
                    $pengajuan->update($request->only(['keterengan']));
                    return response()->json(['message' => 'Keterangan berhasil dibatalkan'], 200);
                }
                return response()->json(['message' => 'Akses ditolak'], 403);

            }
        }

    // public function (){}



}
