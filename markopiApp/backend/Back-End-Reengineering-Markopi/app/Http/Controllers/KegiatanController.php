<?php
// app/Http/Controllers/KegiatanController.php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\TahapanKegiatan;
use App\Models\JenisTahapanKegiatan;

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


    public function createBudidaya()
    {
        $existingTahapan = TahapanKegiatan::where('kegiatan', 'budidaya')->pluck('nama_tahapan')->unique();

        return view('admin.kegiatan.create_budidaya', [
            'title' => 'Buat Informasi Budidaya Kopi',
            'existingTahapan' => $existingTahapan,
        ]);
    }

    public function storeBudidaya(Request $request)
    {
        $request->validate([
            'jenis_kopi' => 'required|string|max:255',
            'judul' => 'required|string|max:255',
            'deskripsi' => 'required|string',
            'nama_tahapan_existing' => 'nullable|string',
            'nama_tahapan_baru' => 'nullable|string'
        ]);

        $namaTahapan = $request->nama_tahapan_baru ?: $request->nama_tahapan_existing;

        if (!$namaTahapan) {
            return back()->withErrors(['nama_tahapan' => 'Pilih atau masukkan nama tahapan.']);
        }

        $tahapan = TahapanKegiatan::firstOrCreate([
            'nama_tahapan' => $namaTahapan,
            'kegiatan' => 'budidaya',
            'jenis_kopi' => $request->jenis_kopi
        ]);

        $tahapan->jenisTahapanKegiatan()->create([
            'judul' => $request->judul,
            'deskripsi' => $request->deskripsi
        ]);

        return redirect()->route('kegiatan.budidaya')->with('success', 'Informasi budidaya berhasil ditambahkan.');
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

    public function createPanen()
{
    $existingTahapan = TahapanKegiatan::where('kegiatan', 'panen')->pluck('nama_tahapan')->unique();

    return view('admin.kegiatan.create_panen', [
        'title' => 'Buat Informasi Panen Kopi',
        'existingTahapan' => $existingTahapan,
    ]);
}

public function storePanen(Request $request)
{
    $request->validate([
        'jenis_kopi' => 'required|string',
        'judul' => 'required|string',
        'deskripsi' => 'required|string',
    ]);

    $namaTahapan = $request->nama_tahapan_baru ?: $request->nama_tahapan_existing;

    if (!$namaTahapan) {
        return redirect()->back()->with('error', 'Silakan pilih atau isi nama tahapan.');
    }

    // Cek apakah tahapan sudah ada
    $tahapan = TahapanKegiatan::firstOrCreate(
        [
            'nama_tahapan' => $namaTahapan,
            'kegiatan' => 'panen',
        ]
    );

    JenisTahapanKegiatan::create([
        'tahapan_kegiatan_id' => $tahapan->id,
        'jenis_kopi' => $request->jenis_kopi,
        'judul' => $request->judul,
        'deskripsi' => $request->deskripsi,
    ]);

    return redirect()->route('kegiatan.panen')->with('success', 'Informasi panen berhasil ditambahkan.');
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

    public function createPascapanen()
    {
        $existingTahapan = TahapanKegiatan::where('kegiatan', 'pascapanen')->pluck('nama_tahapan')->unique();

        return view('admin.kegiatan.create_pascapanen', [
            'title' => 'Buat Informasi Pasca Panen Kopi',
            'existingTahapan' => $existingTahapan,
        ]);
    }

    // Simpan data pascapanen
    public function storePascapanen(Request $request)
    {
        $request->validate([
            'jenis_kopi' => 'required|string',
            'judul' => 'required|string|max:255',
            'deskripsi' => 'required|string',
        ]);

        // Tentukan nama tahapan
        if ($request->nama_tahapan_baru) {
            $namaTahapan = $request->nama_tahapan_baru;

            // Simpan tahapan baru jika belum ada
            TahapanKegiatan::firstOrCreate([
                'nama_tahapan' => $namaTahapan,
                'kegiatan' => 'pasca_panen',
            ]);
        } else {
            $namaTahapan = $request->nama_tahapan_existing;
        }

        // Simpan data kegiatan pascapanen (sesuaikan model dan kolomnya)
        TahapanKegiatan::create([
            'jenis_kopi' => $request->jenis_kopi,
            'nama_tahapan' => $namaTahapan,
            'judul' => $request->judul,
            'deskripsi' => $request->deskripsi,
            'kegiatan' => 'pasca_panen',
        ]);

        return redirect()->route('kegiatan.pascapanen')->with('success', 'Informasi Pasca Panen berhasil disimpan.');
    }

    public function create()
    {
        return view('admin.kegiatan.create_budidaya'); // Halaman form tambah tahapan
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
