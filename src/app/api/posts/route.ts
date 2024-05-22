import conn from "@/lib/db"
import { SignJWT, decodeJwt } from "jose"
import { NextRequest, NextResponse } from "next/server"
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL || "",
    process.env.NEXT_PUBLIC_SUPABASE_KEY || ""
)

export async function GET(req: Request) {
    const { searchParams } = new URL(req.url)
    const type = searchParams.get('type')
    if (type !== null && type === "discussion") {
        const res = await conn.query("SELECT posts.id as id, posts.title as title, posts.content as content, users.name as author, posts.pictures as pictures, posts.likes as likes, posts.comments as comments, posts.views as views, posts.created_at as \"createdAt\", posts.category as category, users.is_upn_member as \"isUpnMember\", users.profile_picture as \"profilePicture\", users.role as role FROM posts INNER JOIN users ON posts.author = users.id WHERE category = 'DISCUSSION' ORDER BY posts.id DESC LIMIT 20");
        const posts = res.rows
        const responses = posts.map(post => {
            post.pictures = JSON.parse(post.pictures)
            return post
        })
        return Response.json(responses)
    }
    const user = searchParams.get("user")
    if(user !== null){
        if(isNaN(Number.parseInt(user))){
            return Response.json({status: "fail"})
        }
        const res = await conn.query("SELECT posts.id as id, posts.title as title, posts.content as content, users.name as author, posts.pictures as pictures, posts.likes as likes, posts.comments as comments, posts.views as views, posts.created_at as \"createdAt\", posts.category as category, users.is_upn_member as \"isUpnMember\", users.profile_picture as \"profilePicture\", users.role as role FROM posts INNER JOIN users ON posts.author = users.id WHERE posts.author = $1 ORDER BY posts.id DESC LIMIT 20", [user]);
        const posts = res.rows
        const responses = posts.map(post => {
            post.pictures = JSON.parse(post.pictures)
            return post
        })
        return Response.json(responses)
    }
    const id = searchParams.get('id')
    const addViews = searchParams.get('addViews')
    if (addViews === 'true') {
    }
    if (id !== null) {
        const res = await conn.query("SELECT posts.id as id, posts.title as title, posts.content as content, users.name as author, posts.pictures as pictures, posts.likes as likes, posts.comments as comments, posts.views as views, posts.created_at as \"createdAt\", posts.category as category, users.is_upn_member as \"isUpnMember\", users.profile_picture as \"profilePicture\", users.role as role FROM posts INNER JOIN users ON posts.author = users.id WHERE posts.id = $1 ORDER BY posts.id DESC", [id]);
        conn.query("UPDATE posts SET views = views + 1 WHERE id = $1", [id])
        const posts = res.rows
        const responses = posts.map(post => {
            post.pictures = JSON.parse(post.pictures)
            return post
        })

        return Response.json(responses[0])
    }

    const res = await conn.query("SELECT posts.id as id, posts.title as title, posts.content as content, users.name as author, posts.pictures as pictures, posts.likes as likes, posts.comments as comments, posts.views as views, posts.created_at as \"createdAt\", posts.category as category, users.is_upn_member as \"isUpnMember\", users.profile_picture as \"profilePicture\", users.role as role FROM posts INNER JOIN users ON posts.author = users.id WHERE category = 'NEWS' ORDER BY posts.id DESC LIMIT 20");
    const posts = res.rows
    const responses = posts.map(post => {
        post.pictures = JSON.parse(post.pictures)
        return post
    })
    return Response.json(responses)
}
export async function POST(request: NextRequest) {
    const token = request.cookies.get('token')?.value
    if (token === undefined)
        throw Error
    const claims = decodeJwt(token)

    const { searchParams } = new URL(request.url)
    const type = searchParams.get('type')
    if (type !== null && type === "discussion") {
        if (request.headers.get('Content-Type')?.startsWith("multipart/form-data")) {
            const formData = await request.formData()
            const content = formData.get("content")
            const paths: Array<string> = []
            let files: Array<File> = []
            for (let i = 1; i <= 5; i++) {
                if (formData.get("attachment" + i) !== null) {
                    files.push(formData.get("attachment" + i) as File)
                } else {
                    break
                }
            }
            const date = new Date()
            let year = date.getFullYear()
            let day = date.getDate()
            let month = date.getMonth() + 1
            let hour = date.getHours()
            let minute = date.getMinutes()
            let second = date.getSeconds()
            for (let ind = 0; ind < files.length; ind++) {
                const file: File = files[ind]
                const { data, error } = await supabase.storage
                    .from('store')
                    .upload(`${claims.id}-${year}${month}${day}${hour}${minute}${second}-attachment${ind}.png`, file, {
                        cacheControl: "0",
                        upsert: true
                    })
                if (error !== null) {
                    console.log(error)
                    return Response.json({ status: "error" })
                }
                paths.push(`https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/${data?.path}`)
            }
            const query = "INSERT INTO posts(title, content, author, pictures, likes, comments, views, category) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING id"
            const res = await conn.query(query, ["", content, claims.id, JSON.stringify(paths), 0, 0, 0, "DISCUSSION"])
            const postId = res.rows[0].id
            return Response.json({
                status: "ok",
                id: postId
            })
        }
    }
    if (claims.role === "USER") {
        return Response.json({ status: "fail" })
    }
    const { body, header, title } = await request.json()
    if (body === undefined || body === null) {
        return Response.json({ status: "fail" })
    }
    if (header === undefined || header === null) {
        return Response.json({ status: "fail" })
    }
    if (title === undefined || title === null) {
        return Response.json({ status: "fail" })
    }

    const query = "INSERT INTO posts(title, content, author, pictures, likes, comments, views, category) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING id"
    const res = await conn.query(query, [title, body, claims.id, JSON.stringify([header]), 0, 0, 0, "NEWS"])
    const postId = res.rows[0].id
    return Response.json({
        status: "ok",
        id: postId
    })
}

export async function PUT(req: NextRequest){
    const token = req.cookies.get('token')?.value
    if (token === undefined)
        throw Error
    const claims = decodeJwt(token)
    const { id, content, title } = await req.json()
    if (id === undefined || id === null) {
        return Response.json({ status: "fail" })
    }
    if (content === undefined || content === null) {
        return Response.json({ status: "fail" })
    }
    let query = "UPDATE posts SET content = $1 WHERE id = $2 AND author = $3"
    let data = [content, id, claims.id]
    if(title !== undefined && title !== null){
        query = "UPDATE posts SET content = $1, title = $2 WHERE id = $3 AND author = $4"
        data = [content, title, id, claims.id]
    }
    const res = await conn.query(query, data)
    return Response.json({status: "ok"}) 
}

export async function DELETE(req: NextRequest){
    const token = req.cookies.get('token')?.value
    if (token === undefined)
        throw Error
    const claims = decodeJwt(token)
    const { id } = await req.json()
    const res = await conn.query("DELETE FROM posts WHERE id = $1 AND author = $2", [id, claims.id])
    return Response.json({status: "ok"}) 
}