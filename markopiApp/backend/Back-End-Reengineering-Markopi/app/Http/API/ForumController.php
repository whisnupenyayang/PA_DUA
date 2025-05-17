<?php

namespace App\Http\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\ForumResource;
use App\Models\Forum;
use App\Models\ImageForum;
use App\Models\KomentarForum;
use App\Models\LikeForum;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class ForumController extends Controller
{
    public function index()
    {
        $forums = Forum::with('images', 'user')->get();
        return ForumResource::collection($forums);
    }

    public function getLimaForum(Request $request)
    {
        $limit = $request->get('limit', 5);
        $forum = Forum::orderBy('created_at', 'desc')->paginate($limit);
        return ForumResource::collection($forum);
    }

    public function storeForum(Request $request)
    {
        $request->validate([
            'title' => 'required|string',
            'deskripsi' => 'required|string',
            'gambar' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
            'user_id' => 'required',
        ]);

        $forum = Forum::create([
            'title' => $request->title,
            'deskripsi' => $request->deskripsi,
            'user_id' => $request->user_id,
        ]);

        if ($forum && $request->hasFile('gambar')) {
            $file = $request->file('gambar');
            $path = $file->store('budidayaimage', 'public');

            ImageForum::create([
                'forum_id' => $forum->id_forums,
                'gambar' => '/storage/' . $path,
            ]);
        }

        return response()->json('selesai');
    }

    public function store(Request $request)
    {
        try {
            $request->validate([
                'title' => 'required|string',
                'deskripsi' => 'required|string',
                'gambar' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
                'user_id' => 'required',
            ]);

            $forum = Forum::create([
                'title' => $request->title,
                'deskripsi' => $request->deskripsi,
                'user_id' => $request->user_id,
            ]);

            $gambarPath = null;
            if ($forum && $request->hasFile('gambar')) {
                $uploadedFile = $request->file('gambar');
                $gambarPath = $uploadedFile->store('forumimage', 'public');
                $forum->images()->create(['gambar' => $gambarPath]);
            }

            return response()->json([
                'message' => 'Forum berhasil ditambahkan',
                'status' => 'success',
                'gambar' => $gambarPath ? asset('storage/' . $gambarPath) : null,
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Gagal menambahkan data',
                'status' => 'error',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function show($id)
    {
        try {
            $forum = Forum::with('images')->find($id);
            if (!$forum) {
                return response()->json(['message' => 'Forum not found', 'status' => 'error'], 404);
            }
            return response()->json(['data' => $forum, 'status' => 'success'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to fetch forum', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    public function getForumByUserId($user_id)
    {
        try {
            $forums = Forum::with('images')->where('user_id', $user_id)->get();
            if ($forums->isEmpty()) {
                return response()->json(['message' => 'No forums found for the user', 'status' => 'error'], 404);
            }
            return response()->json(['data' => $forums, 'status' => 'success'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to fetch forum', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $validator = Validator::make($request->all(), [
                'title' => 'required|string',
                'deskripsi' => 'required|string',
                'gambar' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            ]);

            if ($validator->fails()) {
                return response()->json($validator->errors(), 422);
            }

            $forum = Forum::find($id);
            if (!$forum) {
                return response()->json(['message' => 'Forum not found', 'status' => 'error'], 404);
            }

            if ($request->hasFile('gambar')) {
                $uploadedFile = $request->file('gambar');
                if ($uploadedFile->isValid()) {
                    $gambarPath = $uploadedFile->store('forumimage', 'public');

                    if ($forum->images()->exists()) {
                        $forum->images()->first()->delete();
                    }

                    $forum->images()->create(['gambar' => $gambarPath]);
                } else {
                    return response()->json(['message' => 'Gagal mengunggah Gambar', 'status' => 'error'], 400);
                }
            }

            $forum->update([
                'title' => $request->title,
                'deskripsi' => $request->deskripsi,
            ]);

            return response()->json(['message' => 'Forum berhasil diperbarui', 'status' => 'success'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to update forum', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $forum = Forum::find($id);
            if (!$forum) {
                return response()->json(['message' => 'Forum not found', 'status' => 'error'], 404);
            }

            $forum->images->each(function ($image) {
                Storage::disk('public')->delete($image->gambar);
            });

            $forum->images()->delete();
            $forum->delete();

            return response()->json(['message' => 'Forum berhasil dihapus', 'status' => 'success'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to delete forum', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    public function test(Request $request, $forum_id)
    {
        $request->validate(['komentar' => 'required']);
        $user = $request->user();
        $userid = $user->id_users;

        $forum = Forum::find($forum_id);
        if (!$forum) {
            return response()->json(['message' => 'Forum tidak ditemukan', 'status' => 'error'], 404);
        }

        $komentar = KomentarForum::create([
            'komentar' => $request->komentar,
            'forum_id' => $forum_id,
            'user_id' => $userid,
        ]);

        return $komentar
            ? response()->json('berhasil')
            : response()->json('gagal');
    }

    public function update_comment_forum(Request $request, $id)
    {
        try {
            $request->validate(['komentar' => 'required|string']);
            $forumKomen = KomentarForum::find($id);

            if (!$forumKomen) {
                return response()->json(['message' => 'Komentar Forum not found', 'status' => 'error'], 404);
            }

            $forumKomen->update(['komentar' => $request->komentar]);

            return response()->json(['message' => 'Komentar Forum berhasil diperbarui', 'status' => 'success'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal memperbaharui Komentar Forum', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    public function delete_comment_forum($id)
    {
        try {
            $forumKomen = KomentarForum::find($id);

            if (!$forumKomen) {
                return response()->json(['message' => 'Komentar Forum not found', 'status' => 'error'], 404);
            }

            $forumKomen->delete();
            return response()->json(['message' => 'Komentar Forum berhasil dihapus', 'status' => 'success'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal menghapus Komentar Forum', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    public function get_comment_forum($forum_id)
    {
        try {
            $forumKomentar = KomentarForum::where('forum_id', $forum_id)->get();

            if (!$forumKomentar) {
                return response()->json(['message' => 'Komentar Forum not found', 'status' => 'error'], 404);
            }

            return response()->json(['data' => $forumKomentar, 'status' => 'success'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to fetch forum', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    public function likeForum($forum_id, $user_id)
    {
        try {
            $forum = Forum::find($forum_id);
            if (!$forum) {
                return response()->json(['message' => 'Forum not found', 'status' => 'error'], 404);
            }

            $existingLike = LikeForum::where('forum_id', $forum_id)
                ->where('user_id', $user_id)
                ->first();

            if ($existingLike) {
                if ($existingLike->like == '1') {
                    $existingLike->delete();
                    return response()->json(['message' => 'Like removed', 'status' => 'success'], 200);
                } else {
                    $existingLike->update(['like' => '1']);
                    return response()->json(['message' => 'Changed unlike to like', 'status' => 'success'], 200);
                }
            } else {
                LikeForum::create([
                    'forum_id' => $forum_id,
                    'user_id' => $user_id,
                    'like' => '1',
                ]);
                return response()->json(['message' => 'Like added', 'status' => 'success'], 200);
            }
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to like forum', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    public function dislikeForum($forum_id, $user_id)
    {
        try {
            $forum = Forum::find($forum_id);
            if (!$forum) {
                return response()->json(['message' => 'Forum not found', 'status' => 'error'], 404);
            }

            $existingDislike = LikeForum::where('forum_id', $forum_id)
                ->where('user_id', $user_id)
                ->first();

            if ($existingDislike) {
                if ($existingDislike->like == '0') {
                    $existingDislike->delete();
                    return response()->json(['message' => 'Dislike removed', 'status' => 'success'], 200);
                } else {
                    $existingDislike->update(['like' => '0']);
                    return response()->json(['message' => 'Changed like to dislike', 'status' => 'success'], 200);
                }
            } else {
                LikeForum::create([
                    'forum_id' => $forum_id,
                    'user_id' => $user_id,
                    'like' => '0',
                ]);
                return response()->json(['message' => 'Dislike added', 'status' => 'success'], 200);
            }
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to dislike forum', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }
}
