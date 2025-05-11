@extends('admin.layouts.admin')

@section('content')
    <div class="row">
        <section class="col-lg-12 connectedSortable">
            <!-- Card for Form -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Tambah Artikel</h3>
                </div>
                <div class="card-body">
                    <!-- Form to add article -->
                    <form action="{{ route('artikel.store') }}" method="POST" enctype="multipart/form-data">
                        @csrf
                        <!-- Judul Artikel -->
                        <div class="form-group">
                            <label for="judul_artikel">Judul Artikel</label>
                            <input type="text" class="form-control @error('judul_artikel') is-invalid @enderror" 
                                   id="judul_artikel" name="judul_artikel" value="{{ old('judul_artikel') }}" required>
                            @error('judul_artikel')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>

                        <!-- Deskripsi Artikel -->
                        <div class="form-group">
                            <label for="isi_artikel">Deskripsi Artikel</label>
                            <textarea class="form-control @error('isi_artikel') is-invalid @enderror" id="isi_artikel" name="isi_artikel" rows="5" required>{{ old('isi_artikel') }}</textarea>
                            @error('isi_artikel')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>

                        <!-- Gambar Artikel -->
                        <div class="form-group">
                            <label for="gambar">Gambar Artikel</label>
                            <input type="file" class="form-control @error('gambar') is-invalid @enderror" 
                                   id="gambar" name="gambar[]" multiple accept="image/*">
                            @error('gambar')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>

                        <!-- Tombol Submit -->
                        <button type="submit" class="btn btn-primary">Simpan Artikel</button>
                    </form>
                </div>
            </div>
        </section>
    </div>
@endsection
