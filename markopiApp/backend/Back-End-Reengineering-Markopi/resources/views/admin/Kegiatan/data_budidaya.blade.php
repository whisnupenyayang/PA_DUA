@extends('admin.layouts.admin')

@section('content')
<h2>Tahapan Budidaya: {{ $namaTahapan }}</h2>

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

                        @foreach ($tahapan->jenisTahapanKegiatan as $jenis)
                            <div class="border rounded p-3 mb-2 d-flex justify-content-between align-items-start">
                                <div>
                                    <h6>{{ $jenis->judul }}</h6>
                                    <p>{{ $jenis->deskripsi }}</p>

                                    @if ($jenis->url_gambar)
                                        <img src="{{ asset('storage/' . $jenis->url_gambar) }}" alt="Gambar" style="max-width: 200px;">
                                    @endif

                                    @if ($jenis->nama_file)
                                        <p><a href="{{ asset('storage/' . $jenis->nama_file) }}" download>Download File</a></p>
                                    @endif
                                </div>
                            </div>
                        @endforeach

                    </div>
                </div>
            @endforeach
        </div>
    </section>
</div>
@endsection
