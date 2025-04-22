@extends('admin.layouts.admin')

@section('content')
    <div class="row">
        <!-- Left col -->
        <section class="col-lg-12 connectedSortable">
            <!-- Custom tabs (Charts with tabs)-->
            <div class="card">
                <div class="card-header">
                    <a href="#">
                        <button type="button" class="btn btn-primary">
                            <h3 class="card-title">
                                <i class="">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                        viewBox="0 0 24 24">
                                        <path fill="currentColor"
                                            d="M16 8h3h-3ZM5 8h8.45H13h.35H5Zm.4-2h13.2l-.85-1H6.25L5.4 6Zm4.6 6.75l2-1l2 1V8h-4v4.75ZM14.55 21H5q-.825 0-1.413-.588T3 19V6.525q0-.35.113-.675t.337-.6L4.7 3.725q.275-.35.687-.538T6.25 3h11.5q.45 0 .863.188t.687.537l1.25 1.525q.225.275.338.6t.112.675v4.9q-.475-.175-.975-.275T19 11.05V8h-3v3.825q-.875.5-1.525 1.238t-1.025 1.662L12 14l-4 2V8H5v11h8.35q.2.575.5 1.075t.7.925ZM18 21v-3h-3v-2h3v-3h2v3h3v2h-3v3h-2Z" />
                                    </svg>
                                </i>
                            </h3>
                        </button>
                    </a>

                    <div class="row mt-3">
                        <!-- Data Dummy Iklan 1 -->
                        <div class="col-sm-6">
                            <div class="card">
                                <img src="{{ asset('storage/iklan/contoh.jpg') }}" class="card-img-top" alt="Iklan 1">
                                <div class="card-body">
                                    <h5 class="card-title">Iklan 1</h5>
                                    <p class="card-text">Deskripsi iklan pertama, sangat menarik dan informatif.</p>
                                    <a href="https://contoh-link.com" class="btn btn-primary" target="_blank">Kunjungi</a>
                                    {{-- Tombol aksi --}}
                                    <div class="float-right">
                                        <a href="#" class="btn btn-success btn-sm"><i class="fas fa-edit"></i></a>
                                        <form id="delete-form-0" action="#" method="POST" class="d-inline">
                                            @csrf
                                            @method('DELETE')
                                            <button type="button" onclick="confirmDelete(0, event)" class="btn btn-danger btn-sm">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Data Dummy Iklan 2 -->
                        <div class="col-sm-6">
                            <div class="card">
                                <img src="{{ asset('storage/iklan/contoh.jpg') }}" class="card-img-top" alt="Iklan 2">
                                <div class="card-body">
                                    <h5 class="card-title">Iklan 2</h5>
                                    <p class="card-text">Deskripsi iklan kedua, penuh dengan informasi penting.</p>
                                    <a href="https://contoh-link.com" class="btn btn-primary" target="_blank">Kunjungi</a>
                                    {{-- Tombol aksi --}}
                                    <div class="float-right">
                                        <a href="#" class="btn btn-success btn-sm"><i class="fas fa-edit"></i></a>
                                        <form id="delete-form-1" action="#" method="POST" class="d-inline">
                                            @csrf
                                            @method('DELETE')
                                            <button type="button" onclick="confirmDelete(1, event)" class="btn btn-danger btn-sm">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Data Dummy Iklan 3 -->
                        <div class="col-sm-6">
                            <div class="card">
                                <img src="{{ asset('storage/iklan/contoh.jpg') }}" class="card-img-top" alt="Iklan 3">
                                <div class="card-body">
                                    <h5 class="card-title">Iklan 3</h5>
                                    <p class="card-text">Deskripsi iklan ketiga yang tidak kalah menariknya.</p>
                                    <a href="https://contoh-link.com" class="btn btn-primary" target="_blank">Kunjungi</a>
                                    {{-- Tombol aksi --}}
                                    <div class="float-right">
                                        <a href="#" class="btn btn-success btn-sm"><i class="fas fa-edit"></i></a>
                                        <form id="delete-form-2" action="#" method="POST" class="d-inline">
                                            @csrf
                                            @method('DELETE')
                                            <button type="button" onclick="confirmDelete(2, event)" class="btn btn-danger btn-sm">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!-- /.card-header -->
            </div>
            <!-- /.card -->
        </section>
        <!-- /.Left col -->
    </div>

    {{-- Modal konfirmasi hapus --}}
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Konfirmasi Hapus</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Apakah Anda yakin? Data akan dihapus permanen!
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                        data-bs-dismiss="modal">Batal</button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Ya, Hapus</button>
                </div>
            </div>
        </div>
    </div>

    {{-- Script konfirmasi hapus --}}
    <script>
        function confirmDelete(id, event) {
            event.preventDefault();
            $('#confirmDeleteModal').modal('show');

            $('#confirmDeleteBtn').click(function () {
                document.getElementById('delete-form-' + id).submit();
            });
        }
    </script>
@endsection
