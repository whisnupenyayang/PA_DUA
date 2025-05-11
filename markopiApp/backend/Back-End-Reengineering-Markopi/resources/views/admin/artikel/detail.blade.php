@extends('admin.layouts.admin')

@section('content')
    <div class="row">
        <section class="col-lg-12 connectedSortable">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Detail Artikel</h3>
                </div>
                <div class="card-body">
                    <!-- Menampilkan Judul Artikel -->
                    <h4>{{ $artikel->judul_artikel }}</h4>
                    <hr>

                    <!-- Menampilkan Deskripsi Artikel -->
                    <p>{!! nl2br(e($artikel->isi_artikel)) !!}</p>
                    <hr>

                    <!-- Menampilkan Gambar Artikel -->
                    <div class="row">
                        @foreach ($artikel->images as $image)
                            <div class="col-md-4">
                                <img src="{{ asset('storage/' . $image->gambar) }}" class="img-fluid" alt="Gambar Artikel">
                            </div>
                        @endforeach
                    </div>

                    <hr>
                    <!-- Tombol Kembali ke Daftar Artikel -->
                    <a href="{{ route('admin.artikel') }}" class="btn btn-secondary">Kembali ke Daftar Artikel</a>

                    <!-- Tombol Edit Artikel -->
                    <a href="{{ route('artikel.edit', $artikel->id_artikels) }}" class="btn btn-warning float-right">Edit Artikel</a>

                    <!-- Tombol Hapus Artikel -->
                    <form action="{{ route('artikel.destroy', $artikel->id_artikels) }}" method="POST" class="d-inline float-right">
                        @csrf
                        @method('DELETE')
                        <button type="submit" class="btn btn-danger">Hapus Artikel</button>
                    </form>
                </div>
            </div>
        </section>
    </div>
@endsection
