<?php
// app/Http/Controllers/KegiatanController.php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\TahapanKegiatan;

class KegiatanController extends Controller
{
    public function budidaya(Request $request)
    {
        // Mengambil input dari request untuk jenis kopi
        $jenisKopi = $request->input('jenis_kopi');

        // Mengambil data tahapan kegiatan dengan filter berdasarkan jenis kopi dan kegiatan 'budidaya'
        $tahapanBudidaya = TahapanKegiatan::when($jenisKopi, function ($query) use ($jenisKopi) {
            return $query->where('jenis_kopi', $jenisKopi);
        })->where('kegiatan', 'budidaya') // Filter berdasarkan kegiatan 'budidaya'
            ->get();

        // Mengembalikan view dengan data yang sudah difilter
        return view('admin.kegiatan.budidaya', [
            'title' => 'Kegiatan Budidaya Kopi',
            'tahapanBudidaya' => $tahapanBudidaya,
        ]);
    }

    public function dataBudidaya($namaTahapan, Request $request)
{
    $jenisKopi = $request->input('jenis_kopi');

    $tahapanBudidaya = TahapanKegiatan::with('jenisTahapanKegiatan')
        ->where('kegiatan', 'budidaya')
        ->where('nama_tahapan', str_replace('-', ' ', $namaTahapan))
        ->when($jenisKopi, function ($query) use ($jenisKopi) {
            return $query->where('jenis_kopi', $jenisKopi);
        })
        ->get();

    return view('admin.kegiatan.data_budidaya', [
        'title' => 'Data Budidaya Kopi',
        'namaTahapan' => $namaTahapan,
        'jenisKopi' => $jenisKopi,
        'tahapanBudidaya' => $tahapanBudidaya,
    ]);
}



    // Menampilkan kegiatan panen
    public function panen(Request $request)
    {
        $jenisKopi = $request->input('jenis_kopi');

        // Filter berdasarkan kegiatan 'panen' dan jenis kopi (jika ada)
        $tahapanPanen = TahapanKegiatan::when($jenisKopi, function ($query) use ($jenisKopi) {
            return $query->where('jenis_kopi', $jenisKopi);
        })->where('kegiatan', 'panen') // Filter berdasarkan kegiatan 'panen'
            ->get();

        return view('admin.kegiatan.panen', [
            'title' => 'Kegiatan Panen Kopi',
            'tahapanPanen' => $tahapanPanen,
        ]);
    }

    public function dataPanen(Request $request, $nama_tahapan)
    {
        $jenisKopi = $request->query('jenis_kopi');

        $tahapanBudidaya = TahapanKegiatan::whereRaw('LOWER(nama_tahapan) = ?', [str_replace('-', ' ', strtolower($nama_tahapan))])
            ->when($jenisKopi, function ($query) use ($jenisKopi) {
                return $query->where('jenis_kopi', $jenisKopi);
            })
            ->get();

        return view('admin.kegiatan.data_budidaya', [
            'tahapanBudidaya' => $tahapanBudidaya,
            'namaTahapan' => ucwords(str_replace('-', ' ', $nama_tahapan)),
            'jenisKopi' => $jenisKopi,
            'title' => 'Data Budidaya'
        ]);
    }

    public function pascapanen(Request $request)
    {
        $jenisKopi = $request->input('jenis_kopi');

        // Filter berdasarkan kegiatan 'pascapanen' dan jenis kopi (jika ada)
        $tahapanPascapanen = TahapanKegiatan::when($jenisKopi, function ($query) use ($jenisKopi) {
            return $query->where('jenis_kopi', $jenisKopi);
        })->where('kegiatan', 'pasca_panen') // Filter berdasarkan kegiatan 'pascapanen'
            ->get();

        return view('admin.kegiatan.pascapanen', [
            'title' => 'Kegiatan Pasca Panen Kopi',
            'tahapanPascapanen' => $tahapanPascapanen,
        ]);
    }

    public function datapascapanen(Request $request, $nama_tahapan)
    {
        $jenisKopi = $request->query('jenis_kopi');

        $tahapanBudidaya = TahapanKegiatan::whereRaw('LOWER(nama_tahapan) = ?', [str_replace('-', ' ', strtolower($nama_tahapan))])
            ->when($jenisKopi, function ($query) use ($jenisKopi) {
                return $query->where('jenis_kopi', $jenisKopi);
            })
            ->get();

        return view('admin.kegiatan.data_budidaya', [
            'tahapanBudidaya' => $tahapanBudidaya,
            'namaTahapan' => ucwords(str_replace('-', ' ', $nama_tahapan)),
            'jenisKopi' => $jenisKopi,
            'title' => 'Data Budidaya'
        ]);
    }


    public function create()
    {
        return view('admin.create_tahapan'); // Halaman form tambah tahapan
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_tahapan' => 'required|string|max:255',
            'kegiatan' => 'required|string',
            'jenis_kopi' => 'required|string|max:255',
        ]);

        TahapanKegiatan::create([
            'nama_tahapan' => $request->nama_tahapan,
            'kegiatan' => $request->kegiatan,
            'jenis_kopi' => $request->jenis_kopi,
        ]);

        return redirect()->route('kegiatan.index'); // Redirect kembali ke halaman index kegiatan
    }
}
