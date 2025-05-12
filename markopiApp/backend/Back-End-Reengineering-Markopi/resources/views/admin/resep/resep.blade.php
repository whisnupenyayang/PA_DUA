<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar resep</title>
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
            padding-left: 25px;
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

        .add-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 15px;
            background-color: #1e2e49;
            color: white;
            border-radius: 16px;
            text-decoration: none;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: all 0.3s;
            font-family: 'Segoe UI', sans-serif;
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
                flex-direction: row;
                align-items: center;
                padding: 20px;
            }

            .card img {
                width: 40%;
                height: 80px;
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
        @media (min-width: 1320px) {
            .container {
                padding: 60px calc((100% - 1200px) / 2);
            }

            .container {
                width: 100%;
                max-width: 1700px;
                padding: 60px;
                margin: 0 auto;
                box-sizing: border-box;
            }

            h1 {
                font-size: 3em;
            }

            .card {
                display: flex;
                flex-direction: row;
                align-items: center;
                font-size: 20px;
            }

            .card img {
                width: 20%;
                height: 20%;
                object-fit: cover;
                margin-right: 20px;
            }

            .card-content {
                text-align: left;
            }

            .add-btn {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 10px 15px;
                background-color: #1e2e49;
                color: white;
                border-radius: 16px;
                text-decoration: none;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
                transition: all 0.3s;
                font-family: 'Segoe UI', sans-serif;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <h1>Daftar Resep</h1>

        @if (session('success'))
            <p>{{ session('success') }}</p>
        @endif

        @foreach ($resep as $t)
            <div class="card">
                <img src="{{ asset('images/' . $t->gambar_resep) }}" alt="Foto resep">
                <div class="card-content">
                    <h3>{{ $t->nama_resep }}</h3>
                    <p>Komposisi dan Cara</p>
                    <a href="{{ route('resep.detail', $t->id) }}" class="read-more">Selengkapnya</a>
                </div>
            </div>
        @endforeach
        <div style="display: flex; justify-content: flex-end; gap: 10px; margin-bottom: 20px;">
            <a href="{{ route('resep.create') }}" class="add-btn">
                <span class="material-icons">add</span>
            </a>
        </div>
    </div>
</body>

</html>
