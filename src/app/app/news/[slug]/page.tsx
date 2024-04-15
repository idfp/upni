import { useEffect, useState } from "react"
import { redirect } from 'next/navigation'
import { Post } from "@/class/post";


export default function News({ params }: { params: { slug: string } }){
    const [post, setPost] = useState<Post>()
    useEffect(()=>{
        (async()=>{
            const id = params.slug
            if(isNaN(parseInt(id))){
                redirect("/app")
                return
            }
            const post = await (await fetch("/api/posts?id="+id, {
                method: "GET",
                credentials: "include"
            })).json()
            setPost(post)
        })()
    }, [])
    return(
        <>
        { post === undefined ? 
        <>
        
        </>: 
        <>
        </> }
        </>
    )
}