@extends('admin.layouts.admin')

@section('title', $artikel->judul_artikel)

@section('content')
<div class="container mt-4">
    <h2>{{ $artikel->judul_artikel }}</h2>
   <p><strong>Penulis:</strong> {{ $artikel->user->name ?? 'Anonim' }}</p>


    <hr>
    <div class="mb-4">
        {!! nl2br(e($artikel->isi_artikel)) !!}
    </div>

    @if ($artikel->images && $artikel->images->count())
        <hr>
        <h5>Gambar Terkait:</h5>
        <div class="row">
            @foreach ($artikel->images as $image)
                <div class="col-md-3 col-sm-4 col-6 mb-3">
                    <img src="{{ asset('storage/' . $image->gambar) }}" class="img-fluid rounded border" alt="gambar artikel">
                </div>
            @endforeach
        </div>
    @endif

    <a href="{{ route('artikel.admin') }}" class="btn btn-secondary mt-3">Kembali</a>
</div>
@endsection
