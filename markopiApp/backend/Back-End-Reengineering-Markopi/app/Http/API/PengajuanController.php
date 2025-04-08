<?php

namespace App\Http\API;

use App\Models\User;
use App\Models\Pengajuan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class PengajuanController extends Controller
{
    public function tambahData(Request $request)
    {
        try {
            Log::info('Memulai proses tambah data');

            $request->validate([
                'deskripsi_pengalaman' => 'required|string',
                'foto_ktp' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                'foto_selfie' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                'foto_sertifikat' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                'user_id' => 'required|exists:users,id_users',
            ]);

            Log::info('Validasi berhasil');

            $user = DB::table('users')->where('id_users', $request->user_id)->first();
            Log::info('User ID dari request: ' . $request->user_id);
            Log::info('User dari DB facade: ' . json_encode($user));

            if (!$user) {
                return response()->json(['message' => 'User tidak ada', 'status' => 'error'], 404);
            }

            $fotoKtpPath = null;
            if ($request->hasFile('foto_ktp')) {
                $uploadedFile = $request->file('foto_ktp');
                if ($uploadedFile->isValid()) {
                    $fotoKtpPath = $uploadedFile->store('pengajuanimage', 'public');
                } else {
                    return response()->json(['message' => 'Gagal mengunggah foto KTP', 'status' => 'error', 'error' => 'Invalid file'], 400);
                }
            }

            $fotoSelfiePath = null;
            if ($request->hasFile('foto_selfie')) {
                $uploadedFile = $request->file('foto_selfie');
                if ($uploadedFile->isValid()) {
                    $fotoSelfiePath = $uploadedFile->store('pengajuanimage', 'public');
                } else {
                    return response()->json(['message' => 'Gagal mengunggah foto selfie', 'status' => 'error', 'error' => 'Invalid file'], 400);
                }
            }

            $fotoSertifikatPath = null;
            if ($request->hasFile('foto_sertifikat')) {
                $uploadedFile = $request->file('foto_sertifikat');
                if ($uploadedFile->isValid()) {
                    $fotoSertifikatPath = $uploadedFile->store('pengajuanimage', 'public');
                } else {
                    return response()->json(['message' => 'Gagal mengunggah foto sertifikat', 'status' => 'error', 'error' => 'Invalid file'], 400);
                }
            }

            $pengajuan = Pengajuan::create([
                'foto_ktp' => $fotoKtpPath,
                'foto_selfie' => $fotoSelfiePath,
                'deskripsi_pengalaman' => $request->deskripsi_pengalaman,
                'foto_sertifikat' => $fotoSertifikatPath,
                'user_id' => $request->user_id,
            ]);

            if ($pengajuan) {
                $fotoKtpUrl = $fotoKtpPath ? asset('storage/' . $fotoKtpPath) : null;
                $fotoSelfieUrl = $fotoSelfiePath ? asset('storage/' . $fotoSelfiePath) : null;
                $fotoSertifikatUrl = $fotoSertifikatPath ? asset('storage/' . $fotoSertifikatPath) : null;

                return response()->json([
                    'message' => 'Data berhasil diajukan',
                    'status' => 'success',
                    'foto_ktp_url' => $fotoKtpUrl,
                    'foto_selfie_url' => $fotoSelfieUrl,
                    'foto_sertifikat_url' => $fotoSertifikatUrl,
                ], 200);
            } else {
                return response()->json(['message' => 'Gagal menambahkan data', 'status' => 'error', 'error' => 'Failed to save data to the database'], 500);
            }
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal menambahkan data', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }


    public function getPengajuanData()
    {
        $pengajuanData = Pengajuan::get();

        // Transform data to include image URLs
        $transformedData = $pengajuanData->map(function ($item) {
            return [
                'id_pengajuans' => $item->id_pengajuans,
                'foto_ktp_url' => $item->foto_ktp ? asset('storage/' . $item->foto_ktp) : null,
                'foto_selfie_url' => $item->foto_selfie ? asset('storage/' . $item->foto_selfie) : null,
                'foto_sertifikat_url' => $item->foto_sertifikat ? asset('storage/' . $item->foto_sertifikat) : null,
                'deskripsi_pengalaman' => $item->deskripsi_pengalaman,
                'status' => $item->status,
                'user_id' => $item->getPengajuanDataByUserId_id,
            ];
        });

        return response()->json($transformedData);
    }

    public function getPengajuanDataByUserId($id)
    {
        $pengajuanData = DB::table('pengajuans')->where('user_id', $id)->get();

        if ($pengajuanData->isEmpty()) {
            return response()->json(['message' => 'User ini belum melakukan pengajuan Fasilitator'], 404);
        }

        $transformedData = $pengajuanData->map(function ($item) {
            return [
                'id_pengajuans' => $item->id_pengajuans,
                'foto_ktp_url' => $item->foto_ktp ? asset('storage/' . $item->foto_ktp) : null,
                'foto_selfie_url' => $item->foto_selfie ? asset('storage/' . $item->foto_selfie) : null,
                'foto_sertifikat_url' => $item->foto_sertifikat ? asset('storage/' . $item->foto_sertifikat) : null,
                'deskripsi_pengalaman' => $item->deskripsi_pengalaman,
                'status' => $item->status,
            ];
        });

        return response()->json($transformedData);
    }

    public function getPengajuanStatusData($id)
    {
        $pengajuanStatusData = Pengajuan::select('status', 'id_pengajuans', 'petani_id')->where('petani_id', $id)->get();
        return response()->json($pengajuanStatusData);
    }
}
