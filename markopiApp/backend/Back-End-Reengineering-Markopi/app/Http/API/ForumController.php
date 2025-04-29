<?php

namespace App\Http\API;

use App\Models\Forum;
use App\Models\LikeForum;
use Illuminate\Http\Request;
use App\Models\KomentarForum;
use App\Http\Controllers\Controller;
use App\Http\Resources\ForumResource;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class ForumController extends Controller
{
    public function index()
    {
        $forums = Forum::with('images','user')->get();
        // return response()->json([
        //     'data' => $forums
        // ]);
        return ForumResource::collection($forums);
        // $forums = Forum
    }

    public function getLimaForum(Request $request){
        $limit = $request->get('limit',5);
        $forum = Forum::paginate($limit);

        return ForumResource::collection($forum);
    }

    public function store(Request $request)
    {
        try {
            $request->validate([
                'title' => 'required|string',
                'deskripsi' => 'required|string',
                'gambar' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                'user_id' => 'required',
        ]);

            $forum = Forum::create([
                'title' => $request->title,
                'deskripsi' => $request->deskripsi,
                'user_id' => $request->user_id,
            ]);

            if ($forum) {
                $gambarPath = null;
                if ($request->hasFile('gambar')) {
                    $uploadedFile = $request->file('gambar');
                    if ($uploadedFile->isValid()) {
                        $gambarPath = $uploadedFile->store('forumimage', 'public');
                        $forum->images()->create(['gambar' => $gambarPath]);
                    } else {
                        return response()->json(['message' => 'Gagal mengunggah Gambar', 'status' => 'error', 'error' => 'Invalid file'], 400);
                    }
                }

                // ngambil url
                $gambarUrl = $gambarPath ? asset('storage/' . $gambarPath) : null;

                //jika data berhasil
                return response()->json([
                    'message' => 'Forum berhasil ditambahkan',
                    'status' => 'success',
                    'gambar' => $gambarUrl,
                ], 200);
            } else {
               //jika gagal ngambil data
                return response()->json(['message' => 'Gagal menambahkan data', 'status' => 'error', 'error' => 'Failed to save data to the database'], 500);
            }
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal menambahkan data', 'status' => 'error', 'error' => $e->getMessage()], 500);
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

            // Cek apakah ada file gambar yang diunggah
            if ($request->hasFile('gambar')) {
                $uploadedFile = $request->file('gambar');
                if ($uploadedFile->isValid()) {
                    $gambarPath = $uploadedFile->store('forumimage', 'public');

                    if ($forum->images()->exists()) {
                        $forum->images()->first()->delete();
                    }
                    $forum->images()->create(['gambar' => $gambarPath]);
                } else {
                    return response()->json(['message' => 'Gagal mengunggah Gambar', 'status' => 'error', 'error' => 'Invalid file'], 400);
                }
            }

            // Save updated forum
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

            // Delete associated images
            $forum->images()->delete();

            // Delete the forum itself
            $forum->delete();

            return response()->json(['message' => 'Forum berhasil dihapus', 'status' => 'success'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to delete forum', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    public function comment_forum(Request $request, $forum_id)
    {
        try {
            $forumId = Forum::find($forum_id);

            if (!$forumId) {
                return response()->json(['message' => 'Forum not found', 'status' => 'error'], 404);
            }

            $request->validate([
                'komentar' => 'required|string',
                'forum_id' => 'required',
                'user_id' => 'required',
            ]);

            $forumKomen = KomentarForum::create([
                'komentar' => $request->komentar,
                'forum_id' => $forum_id,
                'user_id' => $request->user_id,
            ]);

            if ($forumKomen) {
                return response()->json([
                    'message' => 'Forum berhasil ditambahkan',
                    'status' => 'success',
                ], 200);
            } else {
                return response()->json(['message' => 'Gagal menambahkan data', 'status' => 'error', 'error' => 'Failed to save data to the database'], 500);
            }
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to comment forum', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    public function update_comment_forum(Request $request, $id)
    {
        try {
            $request->validate([
                'komentar' => 'required|string',
            ]);

            $forumKomen = KomentarForum::find($id);

            if (!$forumKomen) {
                return response()->json(['message' => 'Komentar Forum not found', 'status' => 'error'], 404);
            }

            $forumKomen->update([
                'komentar' => $request->komentar,
            ]);

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
                    // Unlike
                    $existingLike->delete();
                    return response()->json(['message' => 'Like removed', 'status' => 'success'], 200);
                } else {
                    // Change dislike to like
                    $existingLike->update(['like' => '1']);
                    return response()->json(['message' => 'Changed unlike to like', 'status' => 'success'], 200);
                }
            } else {
                // Add new like
                LikeForum::create(['forum_id' => $forum_id, 'user_id' => $user_id, 'like' => '1']);
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

            $existingLike = LikeForum::where('forum_id', $forum_id)
                ->where('user_id', $user_id)
                ->first();

            if ($existingLike) {
                if ($existingLike->like == '2') {
                    // Undislike
                    $existingLike->delete();
                    return response()->json(['message' => 'Dislike removed', 'status' => 'success'], 200);
                } else {
                    // Change like to dislike
                    $existingLike->update(['like' => '2']);
                    return response()->json(['message' => 'Changed like to dislike', 'status' => 'success'], 200);
                }
            } else {
                // Add new dislike
                LikeForum::create(['forum_id' => $forum_id, 'user_id' => $user_id, 'like' => '2']);
                return response()->json(['message' => 'Dislike added', 'status' => 'success'], 200);
            }
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to dislike forum', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    public function getForumLikes($forum_id)
    {
        try {
            $forum = Forum::find($forum_id);

            if (!$forum) {
                return response()->json(['message' => 'Forum not found', 'status' => 'error'], 404);
            }

            $likeCount = LikeForum::where('forum_id', $forum_id)->where('like', '1')->count();

            return response()->json([
                'success' => true,
                'message' => 'Get like count successfully',
                'data' => [
                    'likes' => $likeCount,
                ]
            ], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to get like count', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }

    public function getForumDislikes($forum_id)
    {
        try {
            $forum = Forum::find($forum_id);

            if (!$forum) {
                return response()->json(['message' => 'Forum not found', 'status' => 'error'], 404);
            }

            $dislikeCount = LikeForum::where('forum_id', $forum_id)->where('like', '2')->count();

            return response()->json([
                'success' => true,
                'message' => 'Get dislike count successfully',
                'data' => [
                    'dislikes' => $dislikeCount,
                ]
            ], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to get dislike count', 'status' => 'error', 'error' => $e->getMessage()], 500);
        }
    }
}
