"use client";

import { useEffect, useState } from "react"
import { redirect } from 'next/navigation'
import { Post } from "@/class/post";
import { getCookie } from "@/lib/getCookie";
import { User, defaultUser } from "@/class/user"
import Image from "next/image"
import Link from "next/link"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button";
import { Search } from "lucide-react";
import {
    Avatar,
    AvatarFallback,
    AvatarImage,
} from "@/components/ui/avatar"
import { Skeleton } from "@/components/ui/skeleton";

export default function News({ params }: { params: { slug: string } }) {
    const [post, setPost] = useState<Post>()
    const [user, setUser] = useState<User>(defaultUser)
    useEffect(() => {
        (async () => {
            const id = params.slug
            if (isNaN(parseInt(id))) {
                redirect("/app")
                return
            }
            const token = getCookie("token");
            setUser(JSON.parse(atob(token.split(".")[1].replace(/_/g, '/').replace(/-/g, '+'))));
            const post = await (await fetch("/api/posts?id=" + id, {
                method: "GET",
                credentials: "include"
            })).json()
            setPost(post)
            console.log(post.profilePicture)
        })()
    }, [])
    return (
        <>
            <div className="w-auto m-2 border-gray-300 border rounded-md h-14 flex flex-row p-1 px-4 items-center">
                <Link href="/app" className="grow">
                    <Image src="/logo-small.png" width={40} height={30} alt={"logo"} />
                </Link>
                <div className="grow self-center flex flex-row items-center content-center">
                    <Link href="/app" className="self-center flex-1">
                        <Image src="/news.svg" className="mx-auto" width={30} height={20} alt={"logo"} />
                    </Link>
                    <Link href="/app/discussion" className="self-center flex-1">
                        <Image src="/discussion.svg" className="mx-auto" width={30} height={20} alt={"logo"} />
                    </Link>
                    <Link href="/app/podcast" className="self-center flex-1">
                        <Image src="/podcast.svg" className="mx-auto" width={30} height={20} alt={"logo"} />
                    </Link>
                </div>
                <div className="grow-2"></div>
                <div className="grow flex w-full max-w-sm items-center">
                    <Input type="text" placeholder="Search Post / Podcast" />
                    <Button type="submit" className="-ml-12"><Search className="h-4 w-4" /></Button>
                </div>
                <div className="grow flex justify-end">
                    <Avatar className="cursor-pointer" onClick={() => { console.log("Avatar Clicked") }}>
                        <AvatarImage src={user ? user.profilePicture : ""} alt={user ? user.name : ''} />
                        <AvatarFallback>ID</AvatarFallback>
                    </Avatar>
                </div>
            </div>
            <div className="w-full p-16">
                {post === undefined ?
                    <>
                        <Skeleton className="h-12 max-w-[800px] mx-auto" />
                        <div className="flex flex-row mt-4 max-w-[800px] mx-auto">
                            <Skeleton className="h-14 w-14 rounded-full mr-2" />
                            <div>
                                <Skeleton className="h-6 w-72 mb-2" />
                                <Skeleton className="h-6 w-72" />
                            </div>
                        </div>
                        <div className="max-w-[800px] mx-auto mt-16">
                            <div className="pl-16">
                                <Skeleton className="h-6 w-full mb-2" />
                            </div>
                            <Skeleton className="h-6 w-full mb-2" />
                            <Skeleton className="h-6 w-full mb-2" />
                            <Skeleton className="h-6 w-full mb-2" />
                            <Skeleton className="h-6 w-full mb-2" />
                            <Skeleton className="h-6 w-full mb-2" />
                            <div className="pr-16">
                                <Skeleton className="h-6 w-full" />
                            </div>
                        </div>
                        <div className="max-w-[800px] mx-auto mt-8">
                            <div className="pl-16">
                                <Skeleton className="h-6 w-full mb-2" />
                            </div>
                            <Skeleton className="h-6 w-full mb-2" />
                            <Skeleton className="h-6 w-full mb-2" />
                            <Skeleton className="h-6 w-full mb-2" />
                            <Skeleton className="h-6 w-full mb-2" />
                            <Skeleton className="h-6 w-full mb-2" />
                            <div className="pr-16">
                                <Skeleton className="h-6 w-full" />
                            </div>
                        </div>
                    </> :
                    <div className="max-w-[800px] mx-auto">
                        <h1 className="font-sans text-xl sm:text-2xl lg:text-4xl font-bold">{post.title}</h1>
                        <div className="flex flex-row mt-4 max-w-[800px] mx-auto items-center space-x-2">
                            <Avatar className="cursor-pointer h-14 w-14" onClick={() => { console.log("Avatar Clicked") }}>
                                <AvatarImage src={post.profilePicture} alt={user ? user.name : ''} />
                                <AvatarFallback>ID</AvatarFallback>
                            </Avatar>
                            <div>
                                <span className="text-gray-600">{post.author}</span><br/>
                                <span className="text-gray-500">{post.createdAt.toLocaleString().substring(0, post.createdAt.toLocaleString().length - 8).replace("T", " ")}</span>
                            </div>
                        </div>
                    </div>}
            </div>
        </>
    )
}