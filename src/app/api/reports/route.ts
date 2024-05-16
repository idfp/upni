import { NextRequest } from "next/server";
import { SignJWT, decodeJwt } from "jose"
import { Post } from "@/class/post";
import conn from "@/lib/db"

export async function POST(req: NextRequest) {
    const token = req.cookies.get("token")?.value
    if (token === undefined)
        throw Error
    const claims = decodeJwt(token)
    const { complain, post }: { complain: string, post: Post } = await req.json()
    const message =
        `New report from: ${claims.id} - ${claims.name} - @${claims.username}\n` +
        `Reported Content: \n` +
        `\tPostId: ${post.id} (${post.category})\n` +
        `\tTitle: ${post.title}\n` +
        `\tAuthor: ${post.author}\n` +
        `Complain: ${complain}`
    const url = "https://discord.com/api/webhooks/1239579638506852362/IumVT_SGt9aG0YU87cZ208S7Dk1nG-belqsyLRS1JoyzK6KopJ8UcsKJvvg_is3qXwTN"
    fetch(
        url,
        {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                content: message,
            }),
        },
    )
    return Response.json({status: "ok"})
}