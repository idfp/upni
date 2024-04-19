import { NextRequest, NextResponse } from "next/server";
import conn from "@/lib/db"
import { createHash } from "crypto"
import { ServerUser } from "@/class/user"
import { SignJWT, decodeJwt } from "jose"
import { getJwtSecretKey } from "@/lib/auth"

export async function PUT(req: NextRequest) {
    try {
        const token = req.cookies.get('token')?.value
        if (token === undefined)
            throw Error
        const claims = decodeJwt(token)
        const { username, email, name } = await req.json()
        await conn.query(
            "UPDATE users SET username = $1, email = $2, name = $3 WHERE id = $4",
            [username, email, name, claims.id]
        )
        const response = NextResponse.json(
            { status: "ok" },
            { status: 200, headers: { "content-type": "application/json" } }
        )
        const jwt = await new SignJWT({
            id: claims.id,
            email: email,
            username: username,
            name: name,
            profilePicture: claims.profilePicture,
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
    } catch (e) {
        console.log(e)
        return Response.json({ status: "failed", reason: "none" })
    }
}