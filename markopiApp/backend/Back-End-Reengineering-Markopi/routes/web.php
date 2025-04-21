<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\PanenController;
use App\Http\Controllers\ArtikelController;
use App\Http\Controllers\MinumanController;
use App\Http\Controllers\BudidayaController;
use App\Http\Controllers\PengajuanController;
use App\Http\Controllers\PascaPanenController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

// Auth Routes
Route::get('/', [AuthController::class, 'login'])->name('login');
Route::post('/login', [AuthController::class, 'proseslogin']);
Route::post('/logout', [AuthController::class, 'logout']);

// Fasilitator Routes
Route::middleware(['auth', 'role:fasilitator'])->prefix('fasilitator')->group(function () {
    Route::get('/dashboard', [ArtikelController::class, 'dashboard'])->name('dashboard.fasilitator');

    Route::prefix('artikel')->group(function () {
        Route::get('/', [ArtikelController::class, 'artikel'])->name('artikel.fasilitator');
        Route::get('/create', [ArtikelController::class, 'create'])->name('artikel.form');
        Route::post('/create', [ArtikelController::class, 'store'])->name('artikel.create');
        Route::get('/detail/{id}', [ArtikelController::class, 'show'])->name('artikel.show');
        Route::get('/{id}', [ArtikelController::class, 'edit'])->name('artikel.edit');
        Route::put('/{id}', [ArtikelController::class, 'update'])->name('artikel.update');
        Route::delete('/{id}', [ArtikelController::class, 'destroy'])->name('artikel.destroy');
    });
});

// Admin Routes
Route::middleware(['auth', 'role:admin'])->prefix('admin')->group(function () {
    Route::get('/dashboard', [AuthController::class, 'dashboard'])->name('dashboard.admin');
});

Route::middleware(['auth', 'role:admin'])->group(function () {
    Route::get('/dashboard', function () {
        return view('layouts.dashboard', ['title' => 'Dashboard']);
    })->name('dashboard');

    // Budidaya
    Route::resource('budidaya', BudidayaController::class)->names(['index' => 'budidaya.index']);
    Route::post('budidaya/remove-image', [BudidayaController::class, 'removeImage'])->name('budidaya.removeImage');

    // Panen
    Route::resource('panen', PanenController::class)->names(['index' => 'panen.index']);

    // Pasca Panen
    Route::resource('pasca', PascaPanenController::class)->names(['index' => 'pasca.index']);

    // Minuman
    Route::resource('minuman', MinumanController::class)->names(['index' => 'minuman.index']);

    // Penjualan
    Route::get('penjualan', [BudidayaController::class, 'penjualan_index'])->name('penjualan.index');

    // Pengajuan
    Route::get('/pengajuan', [PengajuanController::class, 'index'])->name('pengajuan.index');
    Route::post('/pengajuan/accept/{id}', [PengajuanController::class, 'accept'])->name('pengajuan.accept');
    Route::post('/pengajuan/reject/{id}', [PengajuanController::class, 'reject'])->name('pengajuan.reject');

    // Manajemen User
    Route::get('data_user', [PengajuanController::class, 'get_data_user'])->name('getDataUser');
    Route::put('/user/{id}/deactivate', [PengajuanController::class, 'deactivate'])->name('user.deactivate');
    Route::delete('/user/{id}', [PengajuanController::class, 'delete'])->name('user.destroy');
    Route::put('/user/{id}/activate', [PengajuanController::class, 'activate'])->name('user.activate');
    Route::get('/user/{id}/edit', [PengajuanController::class, 'edit'])->name('user.edit');

    // Optional Show Routes (jika ingin digunakan kembali)
    // Route::get('/budidaya/{id}', [BudidayaController::class, 'show'])->name('budidaya.show');
    // Route::get('/panen/{id}', [PanenController::class, 'show'])->name('panen.show');
    // Route::get('/pasca/{id}', [PascaPanenController::class, 'show'])->name('pasca.show');
});
