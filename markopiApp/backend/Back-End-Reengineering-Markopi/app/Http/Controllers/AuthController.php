<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login()
    {
        return view('login');
    }

    public function proseslogin(Request $request)
    {
        $request->validate([
            'username' => 'required',
            'password' => 'required'
        ]);

        $input = $request->all();

        // Cek pengguna berdasarkan username
        $user = User::where('username', $request->username)->first();

        Log::info('Attempting to login', ['username' => $input['username'], 'user_found' => $user ? true : false]);

        if ($user->status === null) {
            if ($user && auth()->attempt(['username' => $input['username'], 'password' => $input['password']])) {
                Log::info('User authenticated', ['user_id' => auth()->user()->id_users, 'role' => auth()->user()->role]);
                session(['user_id' => $user->id_users, 'user_role' => $user->role]);
                return redirect()->route($user->role == 'admin' ? 'dashboard.admin' : 'dashboard.fasilitator');
            } else {
                return back()->withErrors(['Periksa Kembali Username dan Password Anda']);
            }
        } else {
            return back()->withErrors(['Akun Anda tidak aktif!!!']);
        }
    }

    public function logout(Request $request)
    {
        Auth::logout();

        $request->session()->invalidate();

        // $request->session()->regenerateToken();

        return redirect('/');
    }

    public function dashboard()
    {
        return view('admin.layouts.dashboard', [
            'title' => 'Dashboard'
        ]);
    }
}
