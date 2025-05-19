<?php

use App\Http\API\TransaksiApiController;
use Illuminate\Http\Request;
use App\Http\API\AuthController;
use App\Http\API\ForumController;
use App\Http\API\PanenController;
use App\Http\API\ArtikelController;
use App\Http\API\PengajuanController;
use Illuminate\Support\Facades\Route;
use App\Http\API\PascaPanenController;
use App\Http\API\BudidayaAPIController;
use App\Http\API\ReplyKomentarController;
use App\Http\API\ResetPasswordController;
use App\Http\API\ForgotPasswordController;
use App\Http\Api\IklanApiController;
use App\Http\Api\LaporanApiController;
use App\Http\API\PengepulApiController;
use App\Http\Api\ResepApiController;
use App\Http\API\TokoApiController;
use App\Http\API\LaporanController;
use App\Http\Controllers\BudidayaController;
use App\Models\Pengepul;
use GuzzleHttp\Middleware;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/




//=============================Budiday, Panen, dan pasca Panen ==============================================
Route::get('/kegiatan/{kegiatan}/{jenisKopi}', [BudidayaAPIController::class, 'getKegiatan']);

Route::get('/jenistahapankegiatan/{id}', [BudidayaAPIController::class, 'getJenisTahapanKegiatan']);

Route::get('/jenistahapankegiatan/detail/{id}', [BudidayaAPIController::class,'getJenisTahapanKegiatanDetail']);
Route::post('/jenistahapkegiatandetail', [BudidayaAPIController::class, 'storeJenisTahapanKegiatanDetail']);




Route::get('/budidaya/jenistahapanbudidaya/detail/{id}', [BudidayaAPIController::class, 'getJenisTahapBudidayaById']);
Route::post('/budidaya/storejenistahapanbudidaya', [BudidayaApiController::class, 'storeJenisTahapanBudidaya']);
Route::post('/upload', [BudidayaApiController::class, 'storeTahapanBudidaya']);

//BUDIDAYA
// Route::get('/budidaya', [BudidayaAPIController::class, 'index']);




//======================KEDAI================================
Route::get('/minuman', [BudidayaAPIController::class, 'getMinumanData']);

//PENGAJUAN
Route::get('/pengajuan', [PengajuanController::class, 'getPengajuanData']);
Route::get('/pengajuanById/{id}', [PengajuanController::class, 'getPengajuanDataByUserId']);
Route::get('/pengajuan_status/{id}', [PengajuanController::class, 'getPengajuanStatusData']);
Route::post('/pengajuantambah', [PengajuanController::class, 'tambahData']);

//KOMUNITAS
Route::get('/komunitas', [BudidayaAPIController::class, 'getKomunitasData']);




// ============================== Autentikasi ====================
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('password/forgot',[ForgotPasswordController::class,'forgotPassword']);
Route::post('password/reset',[ResetPasswordController::class,'resetPassword']);
// Route::middleware('auth:sanctum')->group(function () {
Route::get('/logout', [AuthController::class, 'logout'])->middleware(['auth:sanctum']);


Route::get('getUserById/{id}', [AuthController::class, 'getUserById']);
Route::get('getAllUser', [AuthController::class, 'getAllUser']);
Route::put('userUpdate/{id}', [AuthController::class, 'updateUserProfile']);




Route::get('artikel', [ArtikelController::class, 'index']);
Route::get('artikel/{id}', [ArtikelController::class, 'show']);
Route::post('artikel', [ArtikelController::class, 'store']);
Route::post('artikel/{id}', [ArtikelController::class, 'update']);
Route::delete('artikel/{id}', [ArtikelController::class, 'destroy']);

Route::get('artikelByUser/{user_id}', [ArtikelController::class, 'articlesByUser']);


//=========================== Forum Routes ===========================

// Menampilkan lima forum terbaru
Route::get('/forum', [ForumController::class, 'getLimaForum']);

// Menampilkan detail forum berdasarkan ID
Route::get('forum/{id}', [ForumController::class, 'show']);

// Menampilkan forum berdasarkan user_id
Route::get('user/forum/{user_id}', [ForumController::class, 'getForumByUserId']);

// Menambahkan forum baru
Route::post('/forum', [ForumController::class, 'store'])->middleware('auth:sanctum');

// Menghapus forum berdasarkan ID
Route::delete('forum/{id}', [ForumController::class, 'destroy']);

// Menambahkan komentar pada forum
Route::post('forum_comment/{forum_id}', [ForumController::class, 'storeComment'])->middleware('auth:sanctum');

// Mengambil komentar pada forum berdasarkan forum_id
Route::get('forumKomen/{forum_id}', [ForumController::class, 'getCommentForum']);

// Mengupdate komentar forum berdasarkan ID
Route::put('forum_comment_update/{id}', [ForumController::class, 'updateComment']);

// Menghapus komentar forum berdasarkan ID
Route::delete('forum_comment_delete/{id}', [ForumController::class, 'deleteComment']);

// Menambahkan like pada forum
Route::post('forum/{forum_id}/like', [ForumController::class, 'likeForum'])->middleware('auth:sanctum');

// Menambahkan dislike pada forum
Route::post('forum/{forum_id}/dislike', [ForumController::class, 'dislikeForum'])->middleware('auth:sanctum');

// Mengambil jumlah like pada forum
Route::get('forum/{forum_id}/likes', [ForumController::class, 'getForumLikes']);

// Mengambil jumlah dislike pada forum
Route::get('forum/{forum_id}/dislikes', [ForumController::class, 'getForumDislikes']);

// ============================ Reply Routes ===========================

// Mengambil balasan berdasarkan komentar_id dan user_id
Route::get('/komentar/{komentar_id}/user/{user_id}/replies', [ReplyKomentarController::class, 'getRepliesByUserId']);

// Menambahkan balasan pada komentar
Route::post('/replies', [ReplyKomentarController::class, 'reply'])->middleware('auth:sanctum');

// Mengambil semua balasan komentar berdasarkan komentar_id
Route::get('replies/{komentar_id}', [ReplyKomentarController::class, 'get_replies']);

// Mengambil semua balasan
Route::get('getAllReplies', [ReplyKomentarController::class, 'getAllReplies']);

// Mengupdate balasan komentar oleh user_id
Route::put('komentar/{komentar_id}/user/{user_id}/replies/{id}', [ReplyKomentarController::class, 'updateReplyByUserId']);

// Menghapus balasan komentar oleh user_id
Route::delete('komentar/{komentar_id}/user/{user_id}/replies/{id}', [ReplyKomentarController::class, 'deleteReplyByUserId']);


// ----------------------------------------------------PENGEPUL----------------------------------------------------

Route::get('/pengepul',[PengepulApiController::class, 'getPengepul']);
Route::post('/pengepul',[PengepulApiController::class, 'storePengepul'])->middleware(['auth:sanctum']);
Route::put('/pengepul/{id}', [PengepulApiController::class, 'updatePengepul'])->middleware(['auth:sanctum']);
Route::get('/pengepulByuser',[PengepulApiController::class, 'getPengepulByUser'])->middleware(['auth:sanctum']);

Route::get('/pengepul/detail/{id}',[PengepulApiController::class, 'getPengepulDetail']);

Route::get('/hargaratarata/{jenis_kopi}/{tahun}', [PengepulApiController::class, 'getHargaRataRata']);

//=======================================PengajuanTransaksi============================
Route::post('/buatpengajuan',[TransaksiApiController::class, 'createPengajuanTransaksi'])->middleware(['auth:sanctum']);

Route::put('/updateKeterangan/{id}',[TransaksiApiController::class, 'updateKeterangan'])->middleware(['auth:sanctum']);


Route::get('/pengajuanbelikopi', [TransaksiApiController::class, 'mengajukanBeliKopi'])->middleware(['auth:sanctum']);


// petani jual
Route::get('/pengajuanjualkopi', [TransaksiApiController::class, 'mengajukanJualKopi'])->middleware(['auth:sanctum']);


// pengepul belikopi
Route::get('/penerimaPengajuanJualKopi', [TransaksiApiController::class, 'menerimaPengajuanJualKopi'])->middleware(['auth:sanctum']);


Route::get('/penerimaPengajuanbelikopi', [TransaksiApiController::class, 'menerimaPengajuanBeliKoPi'])->middleware(['auth:sanctum']);

Route::get('/pengajuan/detail/{id}', [TransaksiApiController::class, 'pengajuanDetail'])->middleware(['auth:sanctum']);

Route::get('/pengajuandalamdata', [TransaksiApiController::class, 'getPengajuanbyData'])->middleware(['auth:sanctum']);



//toko
Route::get('/tokos', [TokoApiController::class, 'index']);  // Mengambil semua toko
Route::get('/tokos/{id}', [TokoApiController::class, 'show']);  // Mengambil toko berdasarkan ID

//resep
Route::get('/reseps', [ResepApiController::class, 'index']);

//iklan
Route::get('/iklans', [IklanApiController::class, 'index']);
Route::get('/iklans/{id}', [IklanApiController::class, 'show']);

// laporan
Route::middleware('auth:sanctum')->get('/laporans', [LaporanApiController::class, 'index']); // Menampilkan semua laporan
Route::middleware('auth:sanctum')->get('/laporans/{id}', [LaporanApiController::class, 'show']); // Menampilkan laporan berdasarkan ID
Route::middleware('auth:sanctum')->post('/laporans', [LaporanApiController::class, 'store']); // Menyimpan laporan baru
Route::middleware('auth:sanctum')->delete('/laporans/{id}', [LaporanApiController::class, 'destroy']); // Menghapus laporan berdasarkan ID
    