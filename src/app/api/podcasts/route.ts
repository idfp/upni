import conn from "@/lib/db"
import { SignJWT, decodeJwt } from "jose"
import { NextRequest, NextResponse } from "next/server"
import { createClient } from '@supabase/supabase-js'

export async function GET(req: NextRequest){
    const { searchParams } = new URL(req.url)
    const user = searchParams.get("user")
    if(user !== null){
        if(isNaN(Number.parseInt(user))){
            return Response.json({status: "fail"})
        }
        const res = await conn.query("SELECT podcasts.id as id, podcasts.title as title, podcasts.thumbnail as thumbnail, users.name as author, podcasts.duration as duration, podcasts.likes as likes, podcasts.comments as comments, podcasts.views as views, podcasts.created_at as \"createdAt\", users.is_upn_member as \"isUpnMember\", users.profile_picture as \"profilePicture\", users.role as role FROM podcasts INNER JOIN users ON podcasts.author = users.id WHERE podcasts.author = $1 ORDER BY podcasts.id DESC LIMIT 20", [user]);
        const podcasts = res.rows
        return Response.json(podcasts)
    }
    const id = searchParams.get('id')
    const addViews = searchParams.get('addViews')
    if (addViews === 'true') {
    }
    if (id !== null) {
        const res = await conn.query("SELECT podcasts.id as id, podcasts.title as title, podcasts.thumbnail as thumbnail, users.name as author, podcasts.duration as duration, podcasts.likes as likes, podcasts.comments as comments, podcasts.views as views, podcasts.created_at as \"createdAt\", users.is_upn_member as \"isUpnMember\", users.profile_picture as \"profilePicture\", users.role as role FROM podcasts INNER JOIN users ON podcasts.author = users.id WHERE podcasts.id = $1 ORDER BY podcasts.id DESC", [id]);
        conn.query("UPDATE podcasts SET views = views + 1 WHERE id = $1", [id])
        const podcasts = res.rows
        return Response.json(podcasts)
    }

    const res = await conn.query("SELECT podcasts.id as id, podcasts.title as title, podcasts.thumbnail as thumbnail, users.name as author, podcasts.duration as duration, podcasts.likes as likes, podcasts.comments as comments, podcasts.views as views, podcasts.created_at as \"createdAt\", users.is_upn_member as \"isUpnMember\", users.profile_picture as \"profilePicture\", users.role as role FROM podcasts INNER JOIN users ON podcasts.author = users.id ORDER BY podcasts.id DESC LIMIT 20");
    const podcasts = res.rows
    
    return Response.json(podcasts)
}