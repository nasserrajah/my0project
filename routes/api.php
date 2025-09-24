<?php
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\DB;

// جلب العدد الإجمالي وحالة المستخدم الحالي
Route::get('/likes', function (Request $request) {
    $userIdentifier = $request->header('X-USER-ID'); // نقرأ من الهيدر
    $liked = $userIdentifier ? DB::table('likes')->where('user_identifier', $userIdentifier)->exists() : false;
    $count = DB::table('likes')->count();

    return response()->json([
        'count' => $count,
        'liked' => $liked
    ]);
});

// إضافة إعجاب جديد إذا لم يكن موجود
Route::post('/likes', function (Request $request) {
    $userIdentifier = $request->header('X-USER-ID');
    if (!$userIdentifier) {
        return response()->json(['error' => 'User ID required'], 400);
    }

    $exists = DB::table('likes')->where('user_identifier', $userIdentifier)->exists();

    if (!$exists) {
        DB::table('likes')->insert([
            'user_identifier' => $userIdentifier,
            'created_at' => now(),
            'updated_at' => now()
        ]);
    }

    $count = DB::table('likes')->count();
    return response()->json([
        'count' => $count,
        'liked' => true
    ]);
});

