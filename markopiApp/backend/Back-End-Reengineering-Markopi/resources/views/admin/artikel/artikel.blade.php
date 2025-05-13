@extends('admin.layouts.admin')

@section('content')
    <style>
        body {
            background-color: #f4f4f4;
        }

        .container-artikel {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            text-align: center;
            font-size: 2em;
            margin-bottom: 20px;
        }

        .card-artikel {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .card-artikel img {
            width: 300px;
            height: 200px;
            object-fit: cover;
            border: 2px solid red; /* Adjust border if necessary */
        }

        .card-artikel-content {
            flex-grow: 1;
            padding: 10px;
            text-align: center;
        }

        .card-artikel-content h3 {
            margin: 0;
            font-size: 1.2em;
            color: #333;
        }

        .card-artikel-content .read-more {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

        .card-artikel-content .read-more:hover {
            text-decoration: underline;
        }

        .card-actions {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
        }

        .btn-add {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: black;
            color: white;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 30px;
            position: fixed;
            bottom: 20px;
            right: 20px;
        }

        .btn-add:hover {
            background-color: #333;
        }

        .btn-add a {
            color: white;
            text-decoration: none;
        }

        @media (min-width: 768px) {
            .card-artikel {
                flex-direction: row;
                align-items: center;
            }

            .card-artikel img {
                width: 120px;
                height: 120px;
                margin-right: 20px;
            }

            .card-artikel-content {
                text-align: left;
            }
        }
    </style>

    <div class="container-artikel">
        <h1>Daftar Artikel</h1>

        @foreach ($artikels as $item)
            <div class="card-artikel">
                {{-- Display Image --}}
                @if ($item->images->count() > 0)
                    <img src="{{ asset('images/' . $item->images->first()->gambar) }}" alt="Gambar Artikel">
                @else
                    <p>Tidak ada gambar</p>
                @endif

                <div class="card-artikel-content">
                    <h3>{{ $item->judul_artikel }}</h3>
                    <a href="{{ route('artikel.show', $item->id_artikels) }}" class="read-more">Baca Selengkapnya</a>

                    <div class="card-actions">
                        <a href="{{ route('artikel.edit', $item->id_artikels) }}" class="btn btn-success btn-sm">
                            <i class="fas fa-edit"></i>
                        </a>

                        <form id="delete-form-{{ $item->id_artikels }}" action="{{ route('artikel.destroy', $item->id_artikels) }}" method="POST" class="d-inline delete-about-form">
                            @csrf
                            @method('DELETE')
                            <button type="button" onclick="confirmDelete({{ $item->id_artikels }}, event)" class="btn btn-danger btn-sm delete-about">
                                <i class="fa fa-trash"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        @endforeach
    </div>

    <div class="btn-add">
        <a href="{{ route('artikel.create') }}">
            <span class="material-icons">add</span>
        </a>
    </div>

    {{-- Modal Konfirmasi Hapus --}}
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Konfirmasi Hapus</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">Apakah Anda yakin ingin menghapus artikel ini secara permanen?</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Batal</button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Ya, Hapus</button>
                </div>
            </div>
        </div>
    </div>

    {{-- SweetAlert --}}
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function confirmDelete(id, event) {
            event.preventDefault();
            $('#confirmDeleteModal').modal('show');
            $('#confirmDeleteBtn').off().click(function () {
                document.getElementById('delete-form-' + id).submit();
            });
        }

        @if (session('success'))
            Swal.fire('Sukses!', '{{ session('success') }}', 'success');
        @endif

        @if (session('error'))
            Swal.fire('Gagal!', '{{ session('error') }}', 'error');
        @endif
    </script>
@endsection
