    @extends('admin.layouts.admin')

    @section('content')
    <h2>{{ $title }}</h2>

    <form action="{{ route('kegiatan.budidaya.store') }}" method="POST">
        @csrf

        <div class="form-group">
            <label for="jenis_kopi">Jenis Kopi</label>
            <select name="jenis_kopi" class="form-control" required>
                <option value="Arabika">Arabika</option>
                <option value="Robusta">Robusta</option>
            </select>
        </div>

        <div class="form-group">
            <label for="nama_tahapan">Pilih Tahapan yang Ada</label>
            <select name="nama_tahapan_existing" class="form-control">
                <option value="">-- Pilih Jika Ingin Menggunakan Tahapan yang Sudah Ada --</option>
                @foreach ($existingTahapan as $tahapan)
                    <option value="{{ $tahapan }}">{{ $tahapan }}</option>
                @endforeach
            </select>
        </div>

        <div class="form-group">
            <label for="nama_tahapan_baru">Atau Buat Tahapan Baru</label>
            <input type="text" name="nama_tahapan_baru" class="form-control" placeholder="Contoh: Pemilihan Lahan">
        </div>

        <div class="form-group">
            <label for="judul">Judul Informasi</label>
            <input type="text" name="judul" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="deskripsi">Deskripsi</label>
            <textarea name="deskripsi" class="form-control" rows="5" required></textarea>
        </div>

        <button type="submit" class="btn btn-success">Simpan Informasi</button>
        <a href="{{ route('kegiatan.budidaya') }}" class="btn btn-secondary">Kembali</a>
    </form>
    @endsection
