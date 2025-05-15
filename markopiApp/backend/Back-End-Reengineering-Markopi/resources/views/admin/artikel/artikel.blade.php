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

        .read-more-link {
            display: inline-block;
            margin-top: 8px;
            color: #007bff;
            font-weight: 600;
            text-decoration: none;
        }

        .read-more-link:hover {
            text-decoration: underline;
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
                    <a href="{{ route('artikel.show', $item->id_artikels) }}" class="read-more-link">Selengkapnya</a>
                </div>
            </div>
        @endforeach
    </div>

    <div class="btn-add">
        <a href="{{ route('artikel.create') }}">
            <span class="material-icons">add</span>
        </a>
    </div>
@endsection
