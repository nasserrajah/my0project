<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LikeController extends Controller
{
    public function index()
    {
        $count = DB::table('likes')->count();
        return response()->json(['likes' => $count]);
    }

    public function store()
    {
        DB::table('likes')->insert(['created_at' => now(), 'updated_at' => now()]);
        $count = DB::table('likes')->count();
        return response()->json(['likes' => $count]);
    }
}
