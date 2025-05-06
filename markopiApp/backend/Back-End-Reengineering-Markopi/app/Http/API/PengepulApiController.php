<?php

namespace App\Http\API;


use App\Http\Controllers\Controller;
use App\Models\Pengepul;
use App\Models\RataRataHergaKopi;
use Carbon\Carbon;
use Illuminate\Validation\ValidationException;
use Illuminate\Auth\Events\Validated;

use Illuminate\Http\Request;

use function PHPUnit\Framework\isNull;

class PengepulApiController extends Controller
{
    public function getPengepul(){
        $pengepul = Pengepul::all();

        return response()->json($pengepul);
    }

    public function storePengepul(Request $request)
{
    try {
        $request->validate([
            'nama_toko' => 'required',
            'jenis_kopi' => 'required',
            'harga' => 'required|numeric',
            'nomor_telepon' => 'required',
            'alamat' => 'required',
            'nama_gambar' => 'nullable|image|mimes:jpeg,png,jpg'
        ]);

        $namaFile = null;
        $path = null;

        if ($request->hasFile('nama_gambar')) {
            $file = $request->file('nama_gambar');
            $namaFile = $file->getClientOriginalName();
            $path = $file->store('pengepul', 'public');
        }

        $pengepul = Pengepul::create([
            'nama_toko' => $request->nama_toko,
            'jenis_kopi' => $request->jenis_kopi,
            'harga' => $request->harga,
            'nomor_telepon' => $request->nomor_telepon,
            'alamat' => $request->alamat,
            'nama_gambar' => $namaFile,
            'url_gambar' => $path ? 'storage/' . $path : null,
        ]);

        if ($pengepul) {
            $bulanSekarang = Carbon::now()->format('m');
            $tahunSekarang = Carbon::now()->format('Y');

            $pengepuls = Pengepul::where('jenis_kopi', $request->jenis_kopi)
                ->whereMonth('updated_at', $bulanSekarang)
                ->whereYear('updated_at', $tahunSekarang)
                ->select('harga')
                ->get();

            $jumlahHarga = $pengepuls->sum('harga');
            $count = $pengepuls->count();

            if ($count > 0) {
                $ratarata = $jumlahHarga / $count;

                $hargaKopiBulanTahun = RataRataHergaKopi::where('jenis_kopi', $request->jenis_kopi)
                    ->where('bulan', $bulanSekarang)
                    ->where('tahun', $tahunSekarang)
                    ->first();

                if (is_null($hargaKopiBulanTahun)) {
                    RataRataHergaKopi::create([
                        'jenis_kopi' => $request->jenis_kopi,
                        'rata_rata_harga' => $ratarata,
                        'bulan' => $bulanSekarang,
                        'tahun' => $tahunSekarang,
                    ]);
                } else {
                    $hargaKopiBulanTahun->update([
                        'rata_rata_harga' => $ratarata,
                    ]);
                }
            }

            return response()->json(['message' => 'sukses'], 201);
        }

        return response()->json(['message' => 'Gagal menyimpan pengepul'], 500);
    } catch (\Exception $e) {
        return response()->json([
            'message' => 'Terjadi kesalahan',
            'error' => $e->getMessage()
        ], 500);
    }
}


    public function updatePengepul(Request $request, $id){

        try {
            $request->validate([
                'nama_toko'     => 'required',
                'jenis_kopi'    => 'required',
                'harga'         => 'required|numeric',
                'nomor_telepon' => 'required',
                'alamat'        => 'required',
            ]);

            $pengepul = Pengepul::findOrFail($id);
            $pengepul->update($request->only([
                'nama_toko',
                'jenis_kopi',
                'harga',
                'nomor_telepon',
                'alamat',
            ]));


            if($pengepul){
                $bulanSekarang = Carbon::now()->format('m'); // angka bulan: "05"
                $tahunSekarang = Carbon::now()->format('Y');

                $pengepuls = Pengepul::where('jenis_kopi', $request->jenis_kopi)
                ->whereMonth('updated_at', $bulanSekarang)
                ->whereYear('updated_at', $tahunSekarang)
                ->select('harga')
                ->get();

                $count = 0;
                $jumlahHarga = 0;

                foreach ($pengepuls as $p) {
                    $jumlahHarga += $p->harga;
                    $count++;
                }
                $ratarata = $jumlahHarga / $count;

                $hargaKopiBulanTahun = RataRataHergaKopi::where('jenis_kopi', $request->jenis_kopi)
                ->where('bulan', $bulanSekarang)
                ->where('tahun', $tahunSekarang)
                ->first();
                if (is_null($hargaKopiBulanTahun)) {
                // Buat entri baru
                RataRataHergaKopi::create([
                    'jenis_kopi' => $request->jenis_kopi,
                    'rata_rata_harga' => $ratarata,
                    'bulan' => $bulanSekarang,
                    'tahun' => $tahunSekarang,
                ]);
            } else {
                $hargaKopiBulanTahun->update([
                    'rata_rata_harga' => $ratarata,
                    ]);
                }
            }
            return response()->json('sukses');
        } catch (ValidationException $e) {
            return response()->json([
                'message' => 'Validasi gagal.',
                'errors' => $e->errors()
            ], 422);
        }
    }




    // ==========================Summary harga kopi ==========================
    public function getHargaRataRata($jenis_kopi, $tahun){

        $hargaRataRata = RataRataHergaKopi::where('jenis_kopi', $jenis_kopi)->where('tahun', $tahun)->orderBy('bulan', 'asc')->get();
        return response()->json(['data' => $hargaRataRata]);

    }
}
