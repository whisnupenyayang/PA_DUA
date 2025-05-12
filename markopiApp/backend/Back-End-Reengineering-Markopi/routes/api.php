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
use App\Http\API\PengepulApiController;
use App\Http\Controllers\BudidayaController;
use App\Models\Pengepul;
use App\Http\Controllers\Api\TokoController;
use App\Http\Controllers\Api\ResepController;
use App\Http\Controllers\Api\IklanController;
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
//     Route::post('/logout', [AuthController::class, 'logout']);
// });

Route::get('getUserById/{id}', [AuthController::class, 'getUserById']);
Route::get('getAllUser', [AuthController::class, 'getAllUser']);
Route::put('userUpdate/{id}', [AuthController::class, 'updateUserProfile']);




Route::get('artikel', [ArtikelController::class, 'index']);
Route::get('artikel/{id}', [ArtikelController::class, 'show']);
Route::post('artikel', [ArtikelController::class, 'store']);
Route::post('artikel/{id}', [ArtikelController::class, 'update']);
Route::delete('artikel/{id}', [ArtikelController::class, 'destroy']);

Route::get('artikelByUser/{user_id}', [ArtikelController::class, 'articlesByUser']);


//=============================================Forum====================================================================
// Route::get('forum', [ForumController::class, 'index']);
Route::get('/forum',[ForumController::class,'getLimaForum']);
// Route::get('/forum',[ForumController::class,'getLimaForum'])->middleware(['auth:sanctum']);
Route::get('forum/{id}', [ForumController::class, 'show']);
Route::get('user/forum/{user_id}', [ForumController::class, 'getForumByUserId']);
Route::post('/forum', [ForumController::class, 'storeForum']);
// Route::post('forum/{id}', [ForumController::class, 'update']);
Route::delete('forum/{id}', [ForumController::class, 'destroy']);
Route::get('forumKomen/{forum_id}', [ForumController::class, 'get_comment_forum']);

// ======================testing===================
// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });
Route::post('/user/{forum_id}', [ForumController::class, 'test'])->middleware('auth:sanctum');
//======================

Route::post('/forum_comment/{forum_id}', [ForumController::class, 'comment_forum'])->middleware('auth:sanctum');

Route::put('forum_comment_update/{id}', [ForumController::class, 'update_comment_forum']);
Route::delete('forum_comment_delete/{id}', [ForumController::class, 'delete_comment_forum']);
Route::post('forum_comment/{forum_id}', [ForumController::class, 'comment_forum']);

Route::post('forum/{forum_id}/like/{user_id}', [ForumController::class, 'likeForum']);
Route::post('forum/{forum_id}/dislike/{user_id}', [ForumController::class, 'dislikeForum']);

Route::get('forum/{forum_id}/likes', [ForumController::class, 'getForumLikes']);
Route::get('forum/{forum_id}/dislikes', [ForumController::class, 'getForumDislikes']);
Route::get('/komentar/{komentar_id}/user/{user_id}/replies', [ReplyKomentarController::class, 'getRepliesByUserId']);
Route::post('/replies', [ReplyKomentarController::class, 'reply']);
Route::get('replies/{komentar_id}', [ReplyKomentarController::class, 'get_replies']);
Route::get('getAllReplies', [ReplyKomentarController::class, 'getAllReplies']);
Route::put('komentar/{komentar_id}/user/{user_id}/replies/{id}', [ReplyKomentarController::class, 'updateReplyByUserId']);
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
Route::get('tokos', [TokoController::class, 'index']);  // Mengambil semua toko
Route::get('tokos/{id}', [TokoController::class, 'show']);  // Mengambil toko berdasarkan ID

//resep
Route::get('/reseps', [ResepController::class, 'index']);

//iklan
Route::get('/iklans', [IklanController::class, 'index']);
Route::get('/iklans/{id}', [IklanController::class, 'show']);

