import conn from "@/lib/db"
import { createHash } from "crypto"
import { ServerUser } from "@/class/user"
import { SignJWT } from "jose"
import { getJwtSecretKey } from "@/lib/auth"
import { NextRequest, NextResponse } from "next/server"

export async function GET(req:Request){
    const { searchParams } = new URL(req.url)
    const id = searchParams.get('id')
    if(id !== null){
        const res = await conn.query("SELECT posts.id as id, posts.title as title, posts.content as content, users.name as author, posts.pictures as pictures, posts.likes as likes, posts.comments as comments, posts.views as views, posts.created_at as created_at, posts.category as category, users.is_upn_member as is_upn_member, users.profile_picture as profile_picture, users.role as role FROM posts INNER JOIN users ON posts.author = users.id WHERE posts.id = $1 ORDER BY posts.id DESC", [id]);
        const posts = res.rows
        const responses = posts.map(post=>{
            post.pictures = JSON.parse(post.pictures)
            return post
        })
        return Response.json(responses)
    }

    const res = await conn.query("SELECT posts.id as id, posts.title as title, posts.content as content, users.name as author, posts.pictures as pictures, posts.likes as likes, posts.comments as comments, posts.views as views, posts.created_at as created_at, posts.category as category, users.is_upn_member as is_upn_member, users.profile_picture as profile_picture, users.role as role FROM posts INNER JOIN users ON posts.author = users.id ORDER BY posts.id DESC LIMIT 20");
    const posts = res.rows
    const responses = posts.map(post=>{
        post.pictures = JSON.parse(post.pictures)
        return post
    })
    return Response.json(responses)
}
export async function POST(request: NextRequest){
}