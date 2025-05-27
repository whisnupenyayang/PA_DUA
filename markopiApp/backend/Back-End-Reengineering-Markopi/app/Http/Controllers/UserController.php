<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index()
    {
        $getDataUser = User::orderBy('role', 'asc')->get();
        return view('admin.users.index', compact('getDataUser'), [
            'title' => 'Informasi Data Users'
        ]);
    }

    public function store(Request $request)
    {

        try {
            $validated = $request->validate([
                'username' => 'required|string|max:50|unique:users,username',
                'nama_lengkap' => 'required|string|max:255',
                'tanggal_lahir' => 'required|date',
                'jenis_kelamin' => 'required|string|max:10',
                'no_telp' => 'required|string|max:20',
                'kabupaten' => 'required|string|max:100',
                'provinsi' => 'required|string|max:100',
                'role' => 'required|string|max:50',
                'email' => 'required|email|unique:users,email',
                'password' => 'required|string|min:6',
            ]);

            // dd($validated['role']);

            $validated['password'] = \Illuminate\Support\Facades\Hash::make($validated['password']);
            $data = User::create($validated);

            return redirect()->route('users.index')->with('success', 'User berhasil ditambahkan.');
        } catch (\Exception $e) {
            return back()->withErrors(['error' => 'Terjadi kesalahan saat menambahkan user: ' . $e->getMessage()]);
        }
    }
}
