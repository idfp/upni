"use client";

import Image from "next/image";
import Link from "next/link";
import { useEffect, useState } from "react";
import { getCookie } from "@/lib/getCookie";
import { User, defaultUser } from "@/class/user"
import { Post } from "@/class/post";
import { Button } from "@/components/ui/button";
import { AspectRatio } from "@/components/ui/aspect-ratio"
import { Search } from "lucide-react";
import { BentoGrid, BentoGridItem } from "@/components/ui/bento-grid";

import {
    Select,
    SelectContent,
    SelectGroup,
    SelectItem,
    SelectLabel,
    SelectTrigger,
    SelectValue,
  } from "@/components/ui/select"
import {
    Avatar,
    AvatarFallback,
    AvatarImage,
} from "@/components/ui/avatar"
import { Input } from "@/components/ui/input"

export default function App() {
    const [user, setUser] = useState<User>(defaultUser)
    const [posts, setPosts] = useState<Array<Post>>()
    useEffect(() => {
        (async () => {
            const token = getCookie("token");
            setUser(JSON.parse(atob(token.split(".")[1].replace(/_/g, '/').replace(/-/g, '+'))));
            const posts = await (await fetch("/api/posts", {
                method: "GET",
                credentials: "include"
            })).json()
            console.log(posts)
            setPosts(posts)
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
            {/* News etc */}
            <div className="flex flex-row space-x-2 px-12">
                <div className="grow-4 border border-gray-300 h-full">
                    <h1>Account Menu</h1>
                    
                </div>
                <div className="grow h-full p-6 py-2">
                    <Select>
                        <SelectTrigger className="w-[180px] mb-4">
                            <SelectValue placeholder="Sort News By" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectGroup>
                                <SelectLabel>News</SelectLabel>
                                <SelectItem value="apple">Date</SelectItem>
                                <SelectItem value="banana">Popularity</SelectItem>
                            </SelectGroup>
                        </SelectContent>
                    </Select>
                    <BentoGrid className="max-w-4xl mx-auto">
                    {posts?.map((post, i) => (
                        <BentoGridItem
                        key={i}
                        title={post.title.length > 50 ? post.title.substring(0, 50) + "..." : post.title}
                        description={post.content.substring(0, 70) + "..."}
                        header={<AspectRatio ratio={16 / 9}><Image src={post.pictures[0]} fill alt={post.title} className="max-h[275px] -mr-8 -mb-16"/></AspectRatio>}
                        className={"border-gray-100 cursor-pointer"}
                        />
                    ))}
                    </BentoGrid>
                   
                </div>
                <div className="grow-4 border border-gray-300 h-full">
                    <h1>Chat and Menu</h1>
                </div>
            </div>
        </>
    )
}