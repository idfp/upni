import conn from "@/lib/db"
import { createHash } from "crypto"
import { ServerUser } from "@/class/user"
import { SignJWT } from "jose"
import { getJwtSecretKey } from "@/lib/auth"
import { NextRequest, NextResponse } from "next/server"

export async function GET(){
    return Response.json({msg: "You shouldn't be here"})
}
export async function POST(request: NextRequest){
    try{
        const { username, password } = await request.json()
        let query = "SELECT * FROM users WHERE "
        if(isNaN(username)){
            query = query + "email = $1"
        }else{
            query = query + "username = $1"
        }
        const values = [username]
        const result = await conn.query(query, values)
        const user:ServerUser = result.rows[0]
        const pwhash = createHash("sha256").update(password).digest("hex")

        if(user.password === pwhash){
            const response = NextResponse.json(
                { status: "success" },
                { status: 200, headers: { "content-type": "application/json" } }
              );     
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
            response.cookies.set({
                name: "token",
                value: token,
                path: "/",
                }); 
            return response
        }

        return Response.json({status: "failed", reason: "invalid credential"})
    }catch(e){
        console.log(e)
        return Response.json({status: "failed", reason:"none"})
    }
    
}