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
    let image: string
    let imageAb: ArrayBuffer
    if(req.headers.get('Content-Type')?.startsWith("multipart/form-data")){
        const formData = await req.formData()
        const file = formData.get("file") as File
        imageAb = await file.arrayBuffer()
    }else{
        image = await req.text()
        imageAb = base64ToArrayBuffer(image)
    }
    const file: File = arrayBufferToFile(imageAb, claims.id + "-attachment.png", "image/png")
    const { data, error } = await supabase.storage
        .from('store')
        .upload(`${claims.id}-${year}${month}${day}${hour}${minute}${second}-attachment.png`, file, {
            cacheControl: "0",
            upsert: true
        })
    console.log(data)
    if (error !== null) {
        console.log(error)
        return Response.json({ status: "error" })
    }
    const response = NextResponse.json(
        { status: "ok", location: `${process.env.NEXT_PUBLIC_SUPABASE_URL}/storage/v1/object/public/store/${claims.id}-${year}${month}${day}${hour}${minute}${second}-attachment.png` },
        { status: 200, headers: { "content-type": "application/json" } }
    );
    
    return response
}