<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tambah Toko</title>
</head>
<body>
    <h1>Tambah Toko Baru</h1>

    <form action="{{ route('toko.store') }}" method="POST" enctype="multipart/form-data">
        @csrf

        <label for="nama_toko">Nama Toko:</label>
        <input type="text" name="nama_toko" id="nama_toko" required><br><br>

        <label for="lokasi">Lokasi:</label>
        <input type="text" name="lokasi" id="lokasi" required><br><br>

        <label for="jam_operasional">Jam Operasional:</label>
        <input type="text" name="jam_operasional" id="jam_operasional" required><br><br>

        <label for="foto_toko">Foto Toko:</label>
        <input type="file" name="foto_toko" id="foto_toko"><br><br>

        <button type="submit">Simpan</button>
    </form>
</body>
</html>
