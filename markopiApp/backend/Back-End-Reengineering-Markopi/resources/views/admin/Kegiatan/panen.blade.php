@extends('admin.layouts.admin')

@section('content')

<!-- Filter Jenis Kopi -->
<div class="row mb-3">
    <div class="col-md-4">
        <form method="GET" action="{{ route('kegiatan.panen') }}">
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

<!-- Tombol Tambah Informasi Panen -->
<div class="row mb-3">
    <div class="col-md-12 text-right">
        <a href="{{ route('kegiatan.panen.create') }}" class="btn btn-success">
            + Tambah Informasi Panen
        </a>
    </div>
</div>

<div class="row">
    <section class="col-lg-12 connectedSortable">
        <div class="card-body">
            <!-- Mengelompokkan data berdasarkan nama tahapan -->
            @foreach ($tahapanPanen->groupBy('nama_tahapan') as $namaTahapan => $tahapans)
                <div class="card mb-3">
                    <div class="card-header" id="heading-{{ Str::slug($namaTahapan) }}">
                        <h5 class="mb-0">
                            <a href="{{ route('kegiatan.data_panen', ['nama_tahapan' => Str::slug($namaTahapan), 'jenis_kopi' => request('jenis_kopi')]) }}" class="btn btn-link">
                                {{ $namaTahapan }}
                            </a>
                        </h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Kegiatan:</strong> Panen</p>
                    </div>
                </div>
            @endforeach
        </div>
    </section>
</div>
@endsection
