import conn from "@/lib/db"
import { createHash } from "crypto"
import { ServerUser } from "@/class/user"
import { SignJWT, decodeJwt } from "jose"
import { getJwtSecretKey } from "@/lib/auth"
import { NextRequest, NextResponse } from "next/server"

export async function GET(req: Request) {
    const { searchParams } = new URL(req.url)
    const id = searchParams.get('id')
    const type = searchParams.get('type')
    if (id == null) {
        return Response.json({ status: "Error", message: "Please provide id" })
    }
    if (type == null) {
        return Response.json({ status: "Error", message: "Please provide type" })
    }
    if(type === "post"){
        const res = await conn.query("SELECT comments.id as id, comments.content as content, comments.created_at as \"createdAt\", comments.posttype as posttype, users.name as author, users.id as authorid, users.role as role, users.is_upn_member as \"isUpnMember\", users.profile_picture as \"profilePicture\"  FROM comments JOIN users ON comments.author = users.id WHERE postid = $1", [id]);
        const comments = res.rows
        
        return Response.json(comments)
    }else{
        const res = await conn.query("SELECT comments.id as id, comments.content as content, comments.created_at as \"createdAt\", comments.posttype as posttype, users.name as author, users.id as authorid, users.role as role, users.is_upn_member as \"isUpnMember\", users.profile_picture as \"profilePicture\"  FROM comments JOIN users ON comments.author = users.id WHERE podcastid = $1", [id]);
        const comments = res.rows
        
        return Response.json(comments)
    }
}
export async function POST(request: NextRequest) {
    try{
        const { content, id, type } = await request.json()
        const token = request.cookies.get('token')?.value
        if(token === undefined)
            throw Error 
        const claims = decodeJwt(token)
        let query = "INSERT INTO comments (author, content, posttype, postid) VALUES ($1, $2, $3, $4) RETURNING id, created_at"
        let posttype = "NEWS"
        if(type === "podcast"){
            query = "INSERT INTO comments (author, content, posttype, podcastid) VALUES ($1, $2, $3, $4) RETURNING id, created_at"
            posttype = "PODCAST"
        }
        const res = await conn.query(query, [claims.id, content, posttype, id])
        const comment = {
            "id": res.rows[0].id,
            "content": content,
            "createdAt": res.rows[0].created_at,
            "posttype": posttype,
            "author": claims.name,
            "authorid": claims.id,
            "role": claims.role,
            "isUpnMember": claims.isUPNMember,
            "profilePicture": claims.profilePicture
        }
        return Response.json(comment)
    }catch(e){
        console.error(e)
        return Response.json({status: "failed", message: "failed to post comment"})
    }
}