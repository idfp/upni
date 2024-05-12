import { NextRequest } from "next/server";
import { SignJWT, decodeJwt } from "jose"
import conn from "@/lib/db"


export async function GET(req: NextRequest) {
    const token = req.cookies.get('token')?.value
    if (token === undefined)
        throw Error
    const claims = decodeJwt(token)
    const query = "SELECT * FROM settings WHERE userid = $1"
    const res = await conn.query(query, [claims.id])
    if(res.rows.length == 0){
        conn.query("INSERT INTO settings(settings, userid) VALUES($1, $2)", ["{}", claims.id])
        return Response.json({})
    }
    return Response.json(res.rows[0].settings)
}

export async function POST(req: NextRequest){
    const { settings } = await req.json()
    const token = req.cookies.get('token')?.value
    if (token === undefined)
        throw Error
    const claims = decodeJwt(token)
    const query = "SELECT * FROM settings WHERE userid = $1"
    const res = await conn.query(query, [claims.id])
    if(res.rows.length == 0){
        conn.query("INSERT INTO settings(settings, userid) VALUES($1, $2)", [JSON.stringify(settings), claims.id])
        return Response.json({status: "ok"})
    }
    await conn.query("UPDATE settings SET settings = $1 WHERE userid = $2", [JSON.stringify(settings), claims.id])
    return Response.json({status: "ok"})

}