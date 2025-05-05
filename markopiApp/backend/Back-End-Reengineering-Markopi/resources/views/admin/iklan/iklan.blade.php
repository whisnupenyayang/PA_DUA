@extends('admin.layouts.admin')

@section('content')
<style>
    .card-body {
        display: flex;
        flex-direction: column;
        padding: 15px;
    }

    .card img {
        max-width: 100%;
        height: auto;
        border-radius: 5px;
        object-fit: cover;
    }

    .card {
        margin-bottom: 20px;
        border-radius: 5px;
        overflow: hidden;
    }

    .card .row {
        display: flex;
        flex-direction: row;
        align-items: stretch;
    }

    .card-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .card-text {
        font-size: 15px;
        line-height: 1.6;
    }

    .text-link {
        font-size: 14px;
        color: #007bff;
        text-decoration: none;
        display: inline-block;
        margin-top: 10px;
    }

    .text-link:hover {
        text-decoration: underline;
    }

    .btn-tambah {
        margin-top: 30px;
        text-align: center;
    }

    .btn-tambah a {
        padding: 10px 20px;
        background-color: #28a745;
        color: white;
        border-radius: 4px;
        text-decoration: none;
        font-weight: 500;
        transition: background-color 0.3s;
    }

    .btn-tambah a:hover {
        background-color: #218838;
    }

    @media (max-width: 768px) {
        .card-body {
            padding: 10px;
        }

        .card .row {
            flex-direction: row !important;
        }

        .col-md-3 {
            max-width: 40%;
            padding-right: 10px;
        }

        .col-md-9 {
            max-width: 60%;
        }

        .card-title {
            font-size: 16px;
        }

        .card-text {
            font-size: 14px;
        }

        .text-link {
            width: 100%;
            text-align: left;
        }

        .btn-tambah {
            margin-top: 20px;
        }

        .btn-tambah a {
            width: 100%;
            display: block;
        }
    }
</style>

<div class="row">
    <section class="col-lg-12 connectedSortable">
        <div class="card-body">
            @foreach ($iklans as $iklan)
                <div class="card w-100">
                    <div class="row g-0">
                        <div class="col-md-3">
                            <img src="{{ asset('foto/' . $iklan->gambar_produk) }}" alt="Foto Produk" class="profile-img">
                        </div>
                        <div class="col-md-9">
                            <div class="card-body">
                                <h5 class="card-title">{{ $iklan->judul }}</h5>
                                <p class="card-text">
                                    <strong>Deskripsi:</strong> {{ $iklan->deskripsi }}<br>
                                    <strong>Harga:</strong> Rp{{ number_format($iklan->harga, 0, ',', '.') }}<br>
                                    <strong>Kontak:</strong> {{ $iklan->kontak }}
                                </p>
                                <a href="{{ route('iklan.show', $iklan->id) }}" class="text-link">Selengkapnya →</a>
                            </div>
                        </div>
                    </div>
                </div>
            @endforeach

            @if (count($iklans) === 0)
                <div class="text-center text-muted">Belum ada data iklan.</div>
            @endif

            <div class="btn-tambah">
                <a href="{{ route('iklan.create') }}">+ Tambah Iklan</a>
            </div>
        </div>
    </section>
</div>
@endsection
