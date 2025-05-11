@extends('admin.layouts.admin')

@section('content')
    <div class="row">
        <section class="col-lg-12 connectedSortable">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        Pilih Kategori Budidaya untuk {{ ucfirst($jenisKopi) }} Kopi
                    </h3>
                </div>

                <div class="card-body">
                    <div class="row">
                        @foreach ($kategori as $kat)
                            <div class="col-sm-6 col-md-4 col-lg-3">
                                <!-- Membungkus card dengan tag <a> -->
                                <a href="{{ route('budidaya.kategoriDetail', ['kategori' => $kat, 'jenis_kopi' => $jenisKopi]) }}" class="d-block">
                                    <div class="card mb-3">
                                        <div class="card-body">
                                            <h5 class="card-title text-center">{{ ucfirst($kat) }}</h5>
                                        </div>      
                                    </div>
                                </a>
                            </div>
                        @endforeach
                    </div>
                </div>
            </div>
        </section>
    </div>
@endsection
