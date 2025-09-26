<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\LikeController;

Route::get('/likes', [LikeController::class, 'index']);   // عرض عدد الإعجابات
Route::post('/likes', [LikeController::class, 'store']); // إضافة إعجاب جديد
