<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LikeController extends Controller
{
    public function getLikes(Request $request)
    {
        $userIdentifier = $request->ip(); // مؤقتًا، لاحقًا auth()->id() أفضل
        $liked = DB::table('likes')->where('user_identifier', $userIdentifier)->exists();
        $count = DB::table('likes')->count();

        return response()->json([
            'count' => $count,
            'liked' => $liked
        ]);
    }

    public function addLike(Request $request)
    {
        $userIdentifier = $request->ip();

        $exists = DB::table('likes')->where('user_identifier', $userIdentifier)->exists();

        if (!$exists) {
            DB::table('likes')->insert([
                'user_identifier' => $userIdentifier,
                'created_at' => now(),
                'updated_at' => now()
            ]);
        }

        $count = DB::table('likes')->count();
        return response()->json(['count' => $count]);
    }
}

