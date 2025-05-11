@extends('admin.layouts.admin')

@section('content')
<style>
/* Styling for the container */
.container {
    max-width: 500px;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Header style */
h2 {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
}

/* Styling for back button */
.back-btn {
    display: inline-block;
    font-size: 16px;
    color: #007bff;
    text-decoration: none;
    margin-bottom: 20px;
}

.back-btn:hover {
    text-decoration: underline;
}

/* Image styling */
.card-img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 8px;
    margin-bottom: 20px;
}

/* Section styles */
.section {
    margin-bottom: 20px;
}

.section label {
    display: block;
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 8px;
}

.section input, .section select {
    width: 100%;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ddd;
    font-size: 16px;
    margin-top: 6px;
}

/* Edit and delete icons */
.icon {
    font-size: 18px;
    color: #007bff;
    cursor: pointer;
}

.icon:hover {
    color: #0056b3;
}

/* Container for edit and delete actions */
.actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.actions .edit,
.actions .delete {
    font-size: 24px;
    cursor: pointer;
}

.actions .delete {
    color: red;
}

.actions .edit {
    color: green;
}
</style>

<div class="container">
    <!-- Back Button -->
    <a href="{{ url()->previous() }}" class="back-btn">&larr; Kembali</a>

    <h2>Detail</h2>

    <div class="card-img">
        <!-- Assuming you are using a dynamic image path -->
        <img src="{{ asset('foto/' . $pengepul->Foto_pengepul) }}" alt="Foto Pengepul" class="img-fluid rounded-start">
    </div>

    <div class="section">
        <label for="nama_usaha">Nama Usaha</label>
        <input type="text" id="nama_usaha" value="{{ $pengepul->nama }}" readonly>
        <span class="icon edit">&#9998;</span> <!-- Edit icon -->
    </div>

    <div class="section">
        <label for="lokasi">Lokasi</label>
        <input type="text" id="lokasi" value="{{ $pengepul->alamat }}" readonly>
        <span class="icon edit">&#9998;</span> <!-- Edit icon -->
    </div>

    <div class="section">
        <label for="jenis_kopi">Jenis Kopi</label>
        <select id="jenis_kopi" disabled>
            <option value="Robusta" {{ $pengepul->jenis_kopi == 'Robusta' ? 'selected' : '' }}>Robusta</option>
            <option value="Arabica" {{ $pengepul->jenis_kopi == 'Arabica' ? 'selected' : '' }}>Arabica</option>
        </select>
        <span class="icon edit">&#9998;</span> <!-- Edit icon -->
    </div>

    <div class="section">
        <label for="jenis_produk">Jenis Produk</label>
        <select id="jenis_produk" disabled>
            <option value="Mentah" {{ $pengepul->jenis_produk == 'Mentah' ? 'selected' : '' }}>Mentah</option>
            <option value="Olahan" {{ $pengepul->jenis_produk == 'Olahan' ? 'selected' : '' }}>Olahan</option>
        </select>
        <span class="icon edit">&#9998;</span> <!-- Edit icon -->
    </div>

    <div class="section">
        <label for="harga">Harga per Kilo</label>
        <input type="text" id="harga" value="Rp{{ number_format($pengepul->harga, 0, ',', '.') }}" readonly>
        <span class="icon edit">&#9998;</span> <!-- Edit icon -->
    </div>

    <div class="actions">
        <!-- Delete icon -->
        <span class="delete">&#128465;</span> <!-- Trash icon -->
    </div>
</div>
@endsection
