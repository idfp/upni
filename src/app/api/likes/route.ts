import conn from "@/lib/db"
import { createHash } from "crypto"
import { ServerUser } from "@/class/user"
import { SignJWT, decodeJwt } from "jose"
import { getJwtSecretKey } from "@/lib/auth"
import { NextRequest, NextResponse } from "next/server"

export async function GET(req: NextRequest) {
    try{
        const { searchParams } = new URL(req.url)
        const id = searchParams.get('id')
        const type = searchParams.get('type')
        if(id == null) throw Error
        if(type == null) throw Error
        const token = req.cookies.get('token')?.value
        if (token === undefined)
            throw Error
        const claims = decodeJwt(token)
        const res = await conn.query("SELECT * FROM settings WHERE userid = $1", [claims.id])
        if(res.rows.length == 0){
            return Response.json({isLiked: false})
        }
        const settings = res.rows[0].settings

        if(settings.postLikes === undefined){
            return Response.json({isLiked: false})
        }
        let isLiked = false
        settings.postLikes.forEach(x=>{
            if(x == Number.parseInt(id)){
                isLiked = true
            }
        })
        if(isLiked){
            return Response.json({isLiked: true})
        }
        return Response.json({isLiked: false})
    }catch(e){
        console.log(e)
        return Response.json({"status": "error", "message": "failed to load likes"})
    }
}

export async function POST(req: NextRequest) {
    try{
        const { searchParams } = new URL(req.url)
        const id = searchParams.get('id')
        const type = searchParams.get('type')
        const token = req.cookies.get('token')?.value
        if(id == null) throw Error
        if(type == null) throw Error
        if (token === undefined)
            throw Error
        const claims = decodeJwt(token)
        const res = await conn.query("SELECT * FROM settings WHERE userid = $1", [claims.id])
        if(res.rows.length == 0){
            const settings = {
                postLikes: [id]
            }
            await conn.query("INSERT INTO settings(userid, settings) VALUES ($1, $2)", [claims.id, JSON.stringify(settings)])
            await conn.query("UPDATE posts SET likes = likes + 1 WHERE id = $1", [id])
            return Response.json({isLiked: true})
        }
        const settings = res.rows[0].settings
        if(settings.postLikes === undefined){
            settings.postLikes = [id]
            await conn.query("UPDATE settings SET settings = $1 WHERE userid = $2 ", [JSON.stringify(settings), claims.id])
            await conn.query("UPDATE posts SET likes = likes + 1 WHERE id = $1", [id])
            return Response.json({isLiked: true})
        }
        let isUnliked = false
        settings.postLikes.forEach((x:number, n:number)=>{
            if(x == Number.parseInt(id)){
                settings.postLikes.splice(n, 1)
                conn.query("UPDATE settings SET settings = $1 WHERE userid = $2 ", [JSON.stringify(settings), claims.id])
                conn.query("UPDATE posts SET likes = likes - 1 WHERE id = $1", [id])
                isUnliked = true
            }
        })
        if(isUnliked){
            return Response.json({isLiked: false})
        }
        settings.postLikes.push(Number.parseInt(id))
        conn.query("UPDATE settings SET settings = $1 WHERE userid = $2 ", [JSON.stringify(settings), claims.id])
        conn.query("UPDATE posts SET likes = likes + 1 WHERE id = $1", [id])
        return Response.json({isLiked: true})
    }catch(e){
        console.log(e)
        return Response.json({"status": "error", "message": "failed to load likes"})
    }
}