import conn from "@/lib/db"
import { createHash } from "crypto"
import { ServerUser } from "@/class/user"
import { SignJWT } from "jose"
import { getJwtSecretKey } from "@/lib/auth"
import { NextRequest, NextResponse } from "next/server"

export async function GET(){
    const res = await conn.query("SELECT * FROM posts INNER JOIN users ON posts.author = users.id ORDER BY posts.id DESC LIMIT 20");
    const posts = res.rows
    const responses = posts.map(post=>{
        post.pictures = JSON.parse(post.pictures)
        return post
    })
    return Response.json(responses)
}
export async function POST(request: NextRequest){
}