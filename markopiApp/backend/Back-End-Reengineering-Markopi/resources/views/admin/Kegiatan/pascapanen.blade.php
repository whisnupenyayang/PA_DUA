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
            @forelse ($tahapanPascapanen as $tahapan)
            <div class="card w-100">
                <div class="row g-0">
                    <div class="col-md-3">
                        <img src="{{ asset('img/kopi.jpg') }}" alt="Ilustrasi Kopi" class="profile-img">
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <h5 class="card-title">{{ $tahapan->nama_tahapan }}</h5>
                            <p class="card-text">
                                <strong>Jenis Kopi:</strong> {{ $tahapan->jenis_kopi }}<br>
                                <strong>Kegiatan:</strong> {{ $tahapan->kegiatan }}
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            @empty
            <div class="text-center text-muted">Belum ada data kegiatan pasca panen.</div>
            @endforelse
        </div>
    </section>
</div>
@endsection
