<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar Toko</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        /* Base styles for Mobile */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .container {
            max-width: 100%;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            text-align: center;
            font-size: 1.6em;
            margin-bottom: 20px;
        }

        .card {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .card img {
            width: 100%;
            height: auto;
            object-fit: cover;
            border-radius: 8px;
        }

        .card-content {
            flex-grow: 1;
            padding-left: 10px;
            text-align: center;
        }

        .card-content h3 {
            margin: 0;
            font-size: 1.2em;
            color: #333;
        }

        .card-content p {
            margin: 5px 0;
            color: #777;
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

        .card-content .read-more {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

        .card-content .read-more:hover {
            text-decoration: underline;
        }

        /* Mobile Adjustments */
        @media (max-width: 767px) {
            h1 {
                font-size: 1.4em;
            }

            .card {
                flex-direction: column;
                align-items: center;
                padding: 15px;
            }

            .card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 8px;
            }

            .card-content {
                text-align: center;
            }

            .btn-add {
                font-size: 25px;
                width: 45px;
                height: 45px;
            }
        }

        /* Desktop Adjustments */
        @media (min-width: 768px) {
            .container {
                max-width: 800px;
                padding: 40px;
            }

            h1 {
                font-size: 2em;
            }

            .card {
                display: flex;
                flex-direction: row;
                align-items: center;
            }

            .card img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                margin-right: 20px;
            }

            .card-content {
                text-align: left;
            }

            .btn-add {
                font-size: 30px;
                width: 50px;
                height: 50px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Daftar Toko</h1>

        @if(session('success'))
            <p>{{ session('success') }}</p>
        @endif

        @foreach ($toko as $t)
            <div class="card">
                <img src="{{ asset('images/' . $t->foto_toko) }}" alt="Foto Toko">
                <div class="card-content">
                    <h3>{{ $t->nama_toko }}</h3>
                    <p><strong>Lokasi:</strong> <a href="https://maps.app.goo.gl/{{ $t->lokasi }}" target="_blank">{{ $t->lokasi }}</a></p>
                    <p><strong>Jam Operasional:</strong> {{ $t->jam_operasional }}</p>
                    <a href="{{ route('toko.detail', $t->toko_id) }}" class="read-more">Selengkapnya</a>
                </div>
            </div>
        @endforeach
    </div>

    <div class="btn-add">
        <a href="{{ route('toko.create') }}">
            <span class="material-icons">add</span>
        </a>
    </div>
</body>
</html>
