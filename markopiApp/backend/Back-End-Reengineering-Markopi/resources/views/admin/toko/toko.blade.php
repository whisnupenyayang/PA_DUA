<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Daftar Toko</title>
</head>
<body>
    <h1>Daftar Toko</h1>

    @if(session('success'))
        <p>{{ session('success') }}</p>
    @endif

    <a href="{{ route('toko.create') }}">Tambah Toko Baru</a>

    <table border="1">
        <thead>
            <tr>
                <th>Nama Toko</th>
                <th>Lokasi</th>
                <th>Jam Operasional</th>
                <th>Foto Toko</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($toko as $t)
                <tr>
                    <td>{{ $t->nama_toko }}</td>
                    <td>{{ $t->lokasi }}</td>
                    <td>{{ $t->jam_operasional }}</td>
                    <td>
                        @if($t->foto_toko)
                            <img src="{{ asset('images/' . $t->foto_toko) }}" width="100" alt="Foto Toko">
                        @else
                            Tidak Ada Gambar
                        @endif
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
</body>
</html>
