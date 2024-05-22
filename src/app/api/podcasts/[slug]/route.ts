import conn from "@/lib/db"
import { SignJWT, decodeJwt } from "jose"
import { NextRequest, NextResponse } from "next/server"
import { createClient } from '@supabase/supabase-js'

export async function GET(req: NextRequest, { params }: { params: { slug: string } }){
    console.log(params.slug)
    if(isNaN(Number.parseInt(params.slug))) return Response.json({status: "fail"})
    const res = await conn.query("SELECT podcasts.id as id, podcasts.title as title, podcasts.thumbnail as thumbnail, users.name as author, podcasts.duration as duration, podcasts.likes as likes, podcasts.comments as comments, podcasts.views as views, podcasts.created_at as \"createdAt\", users.is_upn_member as \"isUpnMember\", users.profile_picture as \"profilePicture\", users.role as role, podcasts.url as url FROM podcasts INNER JOIN users ON podcasts.author = users.id WHERE podcasts.id = $1", [params.slug])
    console.log(res.rows)
    if(res.rows.length > 0){
        return Response.json(res.rows[0])
    }
    return Response.json({status: "ok"})
}