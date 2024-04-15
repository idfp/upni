import conn from "@/lib/db"
import { createHash } from "crypto"
import { ServerUser } from "@/class/user"
import { SignJWT } from "jose"
import { getJwtSecretKey } from "@/lib/auth"
import { NextResponse } from "next/server"

export async function GET(){
    return Response.json({msg: "You shouldn't be here"})
}

export async function POST(request: Request){
    try{
        const { email, username, password } = await request.json()
        const res1 = await conn.query("SELECT * FROM users WHERE email = $1", [email])
        if(res1.rows.length > 0){
            return Response.json({status: "failed", reason:"email already used"})
        }
        let isUPNMember = false;
        if(isNaN(username)) isUPNMember = true;
        const pwhash = createHash("sha256").update(password).digest("hex")
        const user:ServerUser = {
            id: 0,
            email: email,
            username: username,
            name: "",
            is_upn_member: isUPNMember,
            password: pwhash,
            profile_picture: "https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/default_avatar.svg?t=2024-03-18T06%3A44%3A56.263Z",
            created_at: new Date(),
            role: "USER"
        }
        const query = "INSERT INTO users(email, username, is_upn_member, password, role) VALUES($1, $2, $3, $4, $5) RETURNING id"
        const res = await conn.query(query, [
            user.email,
            user.username,
            user.is_upn_member,
            user.password,
            user.role
        ])
        user.id = Number.parseInt(res.rows[0].id)
        const token = await new SignJWT({
            id: user.id,
            email: user.email,
            username: user.username,
            name: user.name,
            profilePicture: user.profile_picture,
            isUPNMember: user.is_upn_member,
            createdAt: user.created_at,
            role: user.role
        })
            .setProtectedHeader({ alg: "HS256" })
            .setIssuedAt()
            .setExpirationTime("30d") 
            .sign(getJwtSecretKey());
        const response = NextResponse.json(
            { status: "success" },
            { status: 200, headers: { "content-type": "application/json" } }
            )
        response.cookies.set({
            name: "token",
            value: token,
            path: "/",
            }); 
        return response
    }catch(e){
        console.log(e)
        return Response.json({status: "failed", reason:"none"})
    }
}