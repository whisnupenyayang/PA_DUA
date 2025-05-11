@extends('admin.layouts.admin')

@section('content')
    <div class="row">
        <section class="col-lg-12 connectedSortable">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        Detail Budidaya: {{ $budidaya->judul }}
                    </h3>
                </div>

                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8">
                            <!-- Menampilkan Deskripsi -->
                            <h4>Deskripsi:</h4>
                            <p>{{ $budidaya->deskripsi }}</p>

                            <!-- Menampilkan Link -->
                            <h4>Link:</h4>
                            <a href="{{ $budidaya->link }}" target="_blank">{{ $budidaya->link }}</a>

                            <!-- Menampilkan Gambar -->
                            <h4>Gambar:</h4>
                            @if ($budidaya->images->isEmpty())
                                <p>Tidak ada gambar yang tersedia.</p>
                            @else
                                <img src="{{ asset('storage/' . $budidaya->images->first()->gambar) }}" class="img-fluid" alt="Gambar Budidaya">
                            @endif

                            <!-- Menampilkan Video -->
                            <h4>Video:</h4>
                            @if ($budidaya->videos->isEmpty())
                                <p>Tidak ada video yang tersedia.</p>
                            @else
                                @foreach ($budidaya->videos as $video)
                                    <video width="320" height="240" controls>
                                        <source src="{{ asset('storage/' . $video->video) }}" type="video/mp4">
                                        Your browser does not support the video tag.
                                    </video>
                                @endforeach
                            @endif
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
@endsection
