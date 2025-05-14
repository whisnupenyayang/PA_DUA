@extends('admin.layouts.admin')

@section('content')
<h2>{{ $title }} - Tahapan Budidaya: {{ $namaTahapan }}</h2>

<!-- Menampilkan jenis kopi yang dipilih -->
@if ($jenisKopi)
    <p><strong>Jenis Kopi yang Dipilih:</strong> {{ $jenisKopi }}</p>
@endif

<div class="row">
    <section class="col-lg-12 connectedSortable">
        <div class="card-body">
            @foreach ($tahapanBudidaya as $tahapan)
                <div class="card mb-3">
                    <div class="card-header">
                        <h5 class="mb-0">{{ $tahapan->nama_tahapan }}</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Kegiatan:</strong> {{ $tahapan->kegiatan }}</p>
                        <p><strong>Jenis Kopi:</strong> {{ $tahapan->jenis_kopi }}</p>
                    </div>
                </div>
            @endforeach
        </div>
    </section>
</div>
@endsection
    