<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
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

        $username = $request->username;
        $password = $request->password;

        if ($username === 'admin' && $password === 'admin01') {
            // Set session secara manual
            session([
                'user_id' => 1,
                'user_role' => 'admin',
                'username' => 'admin'
            ]);

            return redirect()->route('dashboard.admin');
        } else {
            return back()->withErrors(['Hanya admin dengan username dan password yang benar yang diizinkan masuk.']);
        }
    }

    public function logout(Request $request)
    {
        Auth::logout();

        $request->session()->invalidate();

        return redirect('/');
    }

    public function dashboard()
    {
        if (session('user_role') !== 'admin') {
            return redirect('/')->withErrors(['Anda tidak memiliki akses.']);
        }

        return view('admin.layouts.dashboard', [
            'title' => 'Dashboard'
        ]);
    }
}
