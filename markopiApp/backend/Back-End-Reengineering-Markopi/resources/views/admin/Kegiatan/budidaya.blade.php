@extends('admin.layouts.admin')

@section('content')
<h2>{{ $title }}</h2>

<!-- Filter Jenis Kopi -->
<div class="row mb-3">
    <div class="col-md-4">
        <form method="GET" action="{{ route('kegiatan.budidaya') }}">
            <div class="form-group">
                <label for="jenis_kopi">Pilih Jenis Kopi</label>
                <select name="jenis_kopi" id="jenis_kopi" class="form-control">
                    <option value="">Semua</option>
                    <option value="Arabika" {{ request('jenis_kopi') == 'Arabika' ? 'selected' : '' }}>Arabika</option>
                    <option value="Robusta" {{ request('jenis_kopi') == 'Robusta' ? 'selected' : '' }}>Robusta</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary mt-2">Terapkan Filter</button>
        </form>
    </div>
</div>

<div class="row">
    <section class="col-lg-12 connectedSortable">
        <div class="card-body">
            <!-- Mengelompokkan data berdasarkan nama tahapan -->
            @foreach ($tahapanBudidaya->groupBy('nama_tahapan') as $namaTahapan => $tahapans)
            <div class="card mb-3">
                <div class="card-header" id="heading-{{ Str::slug($namaTahapan) }}">
                    <h5 class="mb-0">
                        <!-- Link untuk menuju halaman data budidaya tahapan -->
                        <a href="{{ route('kegiatan.data_budidaya', ['nama_tahapan' => Str::slug($namaTahapan), 'jenis_kopi' => request('jenis_kopi')]) }}" class="btn btn-link">
                            {{ $namaTahapan }}
                        </a>

                    </h5>
                    <div class="mb-3">
                        <a href="{{ route('kegiatan.budidaya.create') }}" class="btn btn-success">
                            + Tambah Informasi Budidaya
                        </a>
                    </div>

                </div>
                <!-- Jika perlu bisa menambahkan informasi lain, misalnya deskripsi singkat -->
                <div class="card-body">
                    <p><strong>Kegiatan:</strong> Budidaya</p>
                </div>
            </div>
            @endforeach
        </div>
    </section>
</div>
@endsection