import conn from "@/lib/db"
import { createHash } from "crypto"
import { ServerUser } from "@/class/user"
import { SignJWT, decodeJwt } from "jose"
import { getJwtSecretKey } from "@/lib/auth"
import { NextRequest, NextResponse } from "next/server"
import { getDrafts, addDraft, removeDraft, modifyDraft } from "./draft"
import { Post } from "@/class/post"

export async function GET(req:NextRequest){
    const { searchParams } = new URL(req.url)
    const id = searchParams.get('id')
    const token = req.cookies.get('token')?.value
    if(token === undefined)
        throw Error 
    const claims = decodeJwt(token)
    const drafts = getDrafts()
    if(id !== null){
        if(drafts[id].author == claims.id){
            return Response.json(drafts[id])
        }
    }
    let returnedDrafts:Array<Post> = [];
    drafts.forEach((draft)=>{
        if(draft === null) return
        if(draft.author == claims.id){
            returnedDrafts.push(draft)
        }
    })
    return Response.json(returnedDrafts)
}

export async function PUT(req: NextRequest){
    const { searchParams } = new URL(req.url)
    const id = searchParams.get('id')
    if(id === null) return Response.json({status: "fail"})
    if(isNaN(Number.parseInt(id))) return Response.json({status: "fail"})
    const { body, header, title } = await req.json()
    const token = req.cookies.get('token')?.value
    if(token === undefined)
        throw Error 
    const claims = decodeJwt(token)
    const post: Post = {
        id: 0,
        author: claims.name + '',
        title,
        content: body,
        pictures: [header],
        likes: 0,
        views: 0,
        comments: 0,
        createdAt: new Date(),
        category: "NEWS",
        profilePicture: claims.profilePicture + '',
        isUpnMember: !!claims.isUPNMember,
        role: claims.role + '',
        timediff: ''
    }
    modifyDraft(Number.parseInt(id), post)
    return Response.json({status: "ok"})
}

export async function POST(request: NextRequest){
    const { body, header, title } = await request.json()
    if(body === undefined || body === null){
        return Response.json({status: "fail"})
    }
    if(header === undefined || header === null){
        return Response.json({status: "fail"})
    }
    if(title === undefined || title === null){
        return Response.json({status: "fail"})
    }
    const token = request.cookies.get('token')?.value
    if(token === undefined)
        throw Error 
    const claims = decodeJwt(token)
    const post: Post = {
        id: 0,
        author: claims.name+'',
        title,
        content: body,
        pictures: [header],
        likes: 0,
        views: 0,
        comments: 0,
        createdAt: new Date(),
        category: "NEWS",
        profilePicture: claims.profilePicture + '',
        isUpnMember: !!claims.isUPNMember,
        role: claims.role + '',
        timediff: ''
    }
    const drafts = addDraft(post)
    return Response.json({status: "ok", id: drafts.length - 1})
}