@extends('admin.layouts.admin')

@section('content')
    <div class="row justify-content-center">
        <section class="col-lg-10">
            <div class="card">
                <div class="card-header text-center">
                    <h3 class="card-title">Pilih Jenis Kopi</h3>
                </div>
                <div class="card-body">
                    <div class="row justify-content-center">
                        <!-- Card Arabika -->
                        <div class="col-md-6">
                            <div class="card shadow-sm mb-4">
                                <div class="card-header text-center bg-success text-white">
                                    <h5 class="mb-0">Arabika</h5>
                                </div>
                                <a href="{{ route('kategori.index') }}?jenis_kopi=arabika">
                                    <img src="{{ asset('Icon/arabika.jpg') }}" class="card-img-top" alt="Arabika" style="height: 250px; object-fit: cover;">
                                </a>
                            </div>
                        </div>

                        <!-- Card Robusta -->
                        <div class="col-md-6">
                            <div class="card shadow-sm mb-4">
                                <div class="card-header text-center bg-warning text-dark">
                                    <h5 class="mb-0">Robusta</h5>
                                </div>
                                <a href="{{ route('kategori.index') }}?jenis_kopi=robusta">
                                    <img src="{{ asset('Icon/robusta.jpg') }}" class="card-img-top" alt="Robusta" style="height: 250px; object-fit: cover;">
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
@endsection
