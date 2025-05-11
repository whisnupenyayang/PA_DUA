<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class PengajuanController extends Controller
{
    public function index()
    {
        $pengajuans = [
            (object)[
                'id_pengajuans' => 1,
                'username' => 'Ahmad kasim sitorus',
                'no_telepon' => '08123456789',
                'deskripsi_pengalaman' => 'Pernah mengelola komunitas petani kopi di daerah Sumatera Utara.',
                'kabupaten' => 'Toba',
                'role' => 'Fasilitator',
                'foto_selfie' => 'alex-suprun-ZHvM3XIOHoE-unsplash.jpg', // <- HAPUS dummy/
                'foto_ktp' => 'ktp1.pdf',
                'foto_sertifikat' => 'sertifikat1.pdf',
            ],
            (object)[
                'id_pengajuans' => 2,
                'username' => 'Ahmad sharon',
                'no_telepon' => '081213139402',
                'deskripsi_pengalaman' => 'Berpengalaman dalam pelatihan budidaya kopi organik.',
                'kabupaten' => 'Samosir',
                'role' => 'Petani',
                'foto_selfie' => 'jurica-koletic-7YVZYZeITc8-unsplash.jpg', // <- HAPUS dummy/
                'foto_ktp' => 'ktp2.pdf',
                'foto_sertifikat' => 'sertifikat2.pdf',
            ],
            (object)[
                'id_pengajuans' => 3,
                'username' => 'Jennie',
                'no_telepon' => '08987654321',
                'deskripsi_pengalaman' => 'Berpengalaman dalam pelatihan budidaya kopi organik.',
                'kabupaten' => 'Samosir',
                'role' => 'Petani',
                'foto_selfie' => 'jurica-koletic-7YVZYZeITc8-unsplash.jpg', // <- HAPUS dummy/
                'foto_ktp' => 'ktp2.pdf',
                'foto_sertifikat' => 'sertifikat2.pdf',
            ],
            (object)[
                'id_pengajuans' => 4,
                'username' => 'Lisa',
                'no_telepon' => '08987654321',
                'deskripsi_pengalaman' => 'Berpengalaman dalam pelatihan budidaya kopi organik.',
                'kabupaten' => 'Samosir',
                'role' => 'Petani',
                'foto_selfie' => 'jurica-koletic-7YVZYZeITc8-unsplash.jpg', // <- HAPUS dummy/
                'foto_ktp' => 'ktp2.pdf',
                'foto_sertifikat' => 'sertifikat2.pdf',
            ],
            (object)[
                'id_pengajuans' => 5,
                'username' => 'Josua Silalahi',
                'no_telepon' => '08987654321',
                'deskripsi_pengalaman' => 'Berpengalaman dalam pelatihan budidaya kopi organik.',
                'kabupaten' => 'Samosir',
                'role' => 'Petani',
                'foto_selfie' => 'jurica-koletic-7YVZYZeITc8-unsplash.jpg', // <- HAPUS dummy/
                'foto_ktp' => 'ktp2.pdf',
                'foto_sertifikat' => 'sertifikat2.pdf',
            ],
            (object)[
                'id_pengajuans' => 6,
                'username' => 'Maria Sirait',
                'no_telepon' => '08987654321',
                'deskripsi_pengalaman' => 'Berpengalaman dalam pelatihan budidaya kopi organik.',
                'kabupaten' => 'Samosir',
                'role' => 'Petani',
                'foto_selfie' => 'jurica-koletic-7YVZYZeITc8-unsplash.jpg', // <- HAPUS dummy/
                'foto_ktp' => 'ktp2.pdf',
                'foto_sertifikat' => 'sertifikat2.pdf',
            ],
        ];


        $title = 'Pengajuan Komunitas'; // <<-- Tambahkan ini

        return view('admin.komunitas.pengajuan', compact('pengajuans', 'title'));
    }
    public function accept($id)
    {
        return redirect()->back()->with('success', 'Pengajuan ID ' . $id . ' diterima.');
    }

    public function reject($id)
    {
        return redirect()->back()->with('error', 'Pengajuan ID ' . $id . ' ditolak.');
    }
}
