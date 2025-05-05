@extends('admin.layouts.admin')

@section('no-navbar') 
    ->
@endsection

@section('content')
<div class="container mt-4">
    <!-- Tombol Kembali -->
    <a href="{{ route('admin.iklan') }}" class="btn btn-secondary mb-3">
        ← Kembali
    </a>
    
    <h2>Tambah Iklan Baru</h2>
    <form action="{{ route('iklan.store') }}" method="POST" enctype="multipart/form-data">
        @csrf

        <!-- Judul -->
        <div class="mb-3">
            <label for="judul" class="form-label">Judul</label>
            <input type="text" class="form-control @error('judul') is-invalid @enderror" id="judul" name="judul" value="{{ old('judul') }}" required>
            @error('judul')
                <div class="invalid-feedback">{{ $message }}</div>
            @enderror
        </div>

        <!-- Deskripsi -->
        <div class="mb-3">
            <label for="deskripsi" class="form-label">Deskripsi</label>
            <textarea class="form-control @error('deskripsi') is-invalid @enderror" id="deskripsi" name="deskripsi" rows="3" required>{{ old('deskripsi') }}</textarea>
            @error('deskripsi')
                <div class="invalid-feedback">{{ $message }}</div>
            @enderror
        </div>

        <!-- Harga -->
        <div class="mb-3">
            <label for="harga" class="form-label">Harga</label>
            <input type="number" class="form-control @error('harga') is-invalid @enderror" id="harga" name="harga" value="{{ old('harga') }}" required>
            @error('harga')
                <div class="invalid-feedback">{{ $message }}</div>
            @enderror
        </div>

        <!-- Kontak -->
        <div class="mb-3">
            <label for="kontak" class="form-label">Kontak</label>
            <input type="text" class="form-control @error('kontak') is-invalid @enderror" id="kontak" name="kontak" value="{{ old('kontak') }}" required>
            @error('kontak')
                <div class="invalid-feedback">{{ $message }}</div>
            @enderror
        </div>

        <!-- Gambar Produk -->
        <div class="mb-3">
            <label for="gambar_produk" class="form-label">Gambar Produk</label>
            <input type="file" class="form-control @error('gambar_produk') is-invalid @enderror" id="gambar_produk" name="gambar_produk" accept="image/*" required>
            @error('gambar_produk')
                <div class="invalid-feedback">{{ $message }}</div>
            @enderror
        </div>

        <!-- Submit Button -->
        <button type="submit" class="btn btn-primary">Tambah Iklan</button>
    </form>
</div>
@endsection
