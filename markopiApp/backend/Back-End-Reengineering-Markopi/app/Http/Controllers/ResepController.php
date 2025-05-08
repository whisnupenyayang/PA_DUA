<?php

namespace App\Http\Controllers;

use App\Models\Resep;
use Illuminate\Http\Request;

class ResepController extends Controller
{
    // Method for displaying all stores
    public function index()
    {
        $resep = Resep::all();
        return view('admin.resep.resep', compact('resep'));
    }

    // Method to show form for creating new store
    public function create()
    {

        return view('admin.resep.tambah_resep');
    }


    // Method for storing a new store
    public function store(Request $request)
    {
        // Validate the incoming request data
        $validatedData = $request->validate([
            'nama_resep' => 'required|string|max:100', // Max length for nama_resep
            'deskripsi_resep' => 'required|string',    // Deskripsi is required
            'gambar_resep' => 'nullable|image|max:255', // Allow file upload for gambar_resep, optional
        ]);

        // Create a new instance of the Resep model
        $resep = new Resep;
        $resep->nama_resep = $request->nama_resep;
        $resep->deskripsi_resep = $request->deskripsi_resep;

        // Handle file upload for gambar_resep
        if ($request->hasFile('gambar_resep')) {
            $file = $request->file('gambar_resep');
            $filename = time() . '.' . $file->getClientOriginalExtension();  // Generate a unique filename
            $file->move(public_path('images'), $filename);  // Move the file to the public/images directory
            $resep->gambar_resep = $filename;
        }

        // Save the recipe data to the database
        $resep->save();

        // Redirect back with success message
        return redirect()->route('admin.resep')->with('success', 'Resep berhasil ditambahkan');
    }


    // Method to show the details of a store
    public function detailResep($id)
    {
        $resep = Resep::findOrFail($id);  // Fetch the store by id
        return view('admin.resep.detail_resep', compact('resep'));  // Pass the store to the view
    }

    public function destroy($id)
    {
        $resep = Resep::findOrFail($id);
        $resep->delete();

        return redirect()->route('admin.resep')->with('success', 'Resep berhasil dihapus');
    }

    // Menampilkan halaman edit
    public function edit($id)
    {
        $resep = Resep::findOrFail($id);
        return view('resep.edit', compact('resep')); // Pastikan view 'resep.edit' ada
    }


    // Menangani pembaruan data resep
    public function update(Request $request, $id)
{
    $resep = Resep::findOrFail($id);

    // Update nama dan deskripsi jika ada
    if ($request->has('name')) {
        $resep->nama_resep = $request->name;
    }

    if ($request->has('desc')) {
        $resep->deskripsi_resep = $request->desc;
    }

    // Proses gambar jika ada
    if ($request->hasFile('image')) {
        // Menyimpan gambar di folder public/images
        $image = $request->file('image');
        $filename = time() . '.' . $image->getClientOriginalExtension();  // Generate a unique filename
        $image->move(public_path('images'), $filename);  // Simpan di folder public/images

        // Simpan path gambar di database
        $resep->gambar_resep = $filename;
    }

    $resep->save();

    // Mengembalikan URL gambar yang baru agar bisa ditampilkan di frontend
    return response()->json([
        'success' => true,
        'imageUrl' => asset('images/' . $resep->gambar_resep)  // Mengembalikan URL gambar yang dapat diakses
    ]);
}

    



}
