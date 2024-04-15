import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'
import { verifyJwtToken } from "@/lib/auth"
 
// This function can be marked `async` if using `await` inside
export function middleware(request: NextRequest) {
    const token = request.cookies.get('token')?.value
    if(!token){
        return Response.redirect(new URL('/', request.url))
    }
    const payload = verifyJwtToken(token)
    if(!payload){
        return Response.redirect(new URL('/', request.url))
    }
}
 
export const config = {
    matcher: ["/app", "/app/:path*", "/api/posts"]
}