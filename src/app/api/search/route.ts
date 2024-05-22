import { NextRequest } from "next/server";
import conn from "@/lib/db"

export async function GET(req: NextRequest){
    const { searchParams } = new URL(req.url)
    const query = searchParams.get('query')
    const resPost = await conn.query(`SELECT posts.id as id, posts.title as title, posts.content as content, users.name as author, posts.pictures as pictures, posts.likes as likes, posts.comments as comments, posts.views as views, posts.created_at as \"createdAt\", posts.category as category, users.is_upn_member as \"isUpnMember\", users.profile_picture as \"profilePicture\", users.role as role FROM posts INNER JOIN users ON posts.author = users.id WHERE LOWER(content) LIKE '%${query?.toLowerCase()}%' OR LOWER(title) LIKE '%${query?.toLowerCase()}%'`)
    const posts = resPost.rows
    const response1 = posts.map(post => {
        post.pictures = JSON.parse(post.pictures)
        return post
    })
    const resPodcast = await conn.query(`SELECT podcasts.id as id, podcasts.title as title, podcasts.thumbnail as thumbnail, podcasts.duration as duration, podcasts.views as views, podcasts.likes as likes, podcasts.comments as comments, podcasts.created_at as \"createdAt\", users.is_upn_member as \"isUpnMember\", users.profile_picture as \"profilePicture\", users.role as role, users.name as author FROM podcasts INNER JOIN users ON podcasts.author = users.id WHERE LOWER(title) LIKE '%${query?.toLowerCase()}%'`)
    return Response.json({
        posts: response1,
        podcasts: resPodcast.rows
    })
}