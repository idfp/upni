import conn from "@/lib/db"
import { createHash } from "crypto"
import { ServerUser } from "@/class/user"
import { SignJWT, decodeJwt } from "jose"
import { getJwtSecretKey } from "@/lib/auth"
import sharp from "sharp"
import { NextRequest, NextResponse } from "next/server"
import { createClient } from '@supabase/supabase-js'
import { base64toFile, base64ToArrayBuffer, arrayBufferToFile } from "@/lib/buffertobase64"

const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL || "",
    process.env.NEXT_PUBLIC_SUPABASE_KEY || ""
)
export async function POST(req: NextRequest) {
    const token = req.cookies.get('token')?.value
    if (token === undefined)
        throw Error
    const claims = decodeJwt(token)
    const date = new Date()
    let year = date.getFullYear()
    let day = date.getDate()
    let month = date.getMonth() + 1
    let hour = date.getHours()
    let minute = date.getMinutes()
    let second = date.getSeconds()
    const image = await req.text()
    const imageAb: ArrayBuffer = base64ToArrayBuffer(image)
    const croppedImage: ArrayBuffer = await sharp(imageAb)
        .resize({ width: 2048, height: 2048, fit: 'cover' })
        .toBuffer()
    const file: File = arrayBufferToFile(croppedImage, claims.id + "-avatar.png", "image/png")
    const { data, error } = await supabase.storage
        .from('store')
        .upload(`${claims.id}-${year}${month}${day}${hour}${minute}${second}-avatar.png`, file, {
            cacheControl: "0",
            upsert: true
        })
    if (error !== null) {
        console.log(error)
        return Response.json({ status: "error" })
    }
    const response = NextResponse.json(
        { status: "ok", link: `${process.env.NEXT_PUBLIC_SUPABASE_URL}/storage/v1/object/public/store/${claims.id}-${year}${month}${day}${hour}${minute}${second}-avatar.png` },
        { status: 200, headers: { "content-type": "application/json" } }
    );
    conn.query("UPDATE users SET profile_picture = $1 WHERE id = $2", [`${process.env.NEXT_PUBLIC_SUPABASE_URL}/storage/v1/object/public/store/${claims.id}-${year}${month}${day}${hour}${minute}${second}-avatar.png`, claims.id])
    const jwt = await new SignJWT({
        id: claims.id,
        email: claims.email,
        username: claims.username,
        name: claims.name,
        profilePicture: `${process.env.NEXT_PUBLIC_SUPABASE_URL}/storage/v1/object/public/store/${claims.id}-${year}${month}${day}${hour}${minute}${second}-avatar.png`,
        isUPNMember: claims.isUPNMember,
        createdAt: claims.createdAt,
        role: claims.role
    })
        .setProtectedHeader({ alg: "HS256" })
        .setIssuedAt()
        .setExpirationTime("30d")
        .sign(getJwtSecretKey());
    response.cookies.set({
        name: "token",
        value: jwt,
        path: "/",
    });
    return response
}