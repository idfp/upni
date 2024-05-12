"use client";

import Image from "next/image";
import Link from "next/link";
import { useEffect, useState } from "react";
import { getCookie } from "@/lib/getCookie";
import { User, defaultUser } from "@/class/user"
import { Post } from "@/class/post";
import { removeHtmlTags } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import { AspectRatio } from "@/components/ui/aspect-ratio"
import { BentoGrid, BentoGridItem } from "@/components/ui/bento-grid";
import { Heart, MessageCircle, GanttChart } from "lucide-react";

import {
    Select,
    SelectContent,
    SelectGroup,
    SelectItem,
    SelectLabel,
    SelectTrigger,
    SelectValue,
} from "@/components/ui/select"
import { Navbar } from "@/components/navbar";
function popularity(a: Post, b: Post) {
    return b.views - a.views
}
function datesort(a: Post, b: Post) {
    return b.id - a.id
}
function Stats({ views, likes, comments, timediff }: { views: number, likes: number, comments: number, timediff: string }) {
    return (
        <div className="flex flex-row items-center p-1 px-4 space-x-3">
            <div className="flex flex-row items-center h-10">
                <Heart color="#6B7280" className="h-4 w-4 mr-1" />
                <span className="text-xs text-gray-500">{likes}</span>
            </div>
            <div className="flex flex-row items-center h-10">
                <MessageCircle color="#6B7280" className="h-4 w-4 mr-1" />
                <span className="text-xs text-gray-500">{comments}</span>
            </div>
            <div className="flex flex-row items-center h-10">
                <GanttChart color="#6B7280" className="h-4 w-4 -ml-1 mr-1" />
                <span className="text-xs text-gray-500">{views}</span>
            </div>
            <span className="text-xs text-gray-500">
                {timediff}
            </span>
        </div>
    )

}
export default function App() {
    const [user, setUser] = useState<User>(defaultUser)
    const [posts, setPosts] = useState<Array<Post>>()
    const [sort, setSort] = useState("date")
    useEffect(() => {
        (async () => {
            const token = getCookie("token");
            setUser(JSON.parse(atob(token.split(".")[1].replace(/_/g, '/').replace(/-/g, '+'))));
            const posts = await (await fetch("/api/posts", {
                method: "GET",
                credentials: "include"
            })).json()
            console.log(posts)
            posts.forEach((post: Post, id: number)=>{
                console.log(post)
                const dateVariable: Date = new Date(post.createdAt);
                const currentTime: Date = new Date();
                const difference: number = currentTime.getTime() - dateVariable.getTime();
                const millisecondsPerSecond: number = 1000;
                const millisecondsPerMinute: number = millisecondsPerSecond * 60;
                const millisecondsPerHour: number = millisecondsPerMinute * 60;
                const millisecondsPerDay: number = millisecondsPerHour * 24;
                const millisecondsPerMonth: number = millisecondsPerDay * 30; // Approximation for simplicity
                const millisecondsPerYear: number = millisecondsPerDay * 365; // Approximation for simplicity

                const seconds: number = Math.floor(difference / millisecondsPerSecond);
                const minutes: number = Math.floor(difference / millisecondsPerMinute);
                const hours: number = Math.floor(difference / millisecondsPerHour);
                const days: number = Math.floor(difference / millisecondsPerDay);
                const months: number = Math.floor(difference / millisecondsPerMonth);
                const years: number = Math.floor(difference / millisecondsPerYear);

                // Output the result
                if (years > 0) {
                    posts[id].timediff = years + " years ago."
                } else if (months > 0) {
                    posts[id].timediff = months + " months ago."
                } else if (days > 0) {
                    posts[id].timediff = days + " days ago."
                } else if (hours > 0) {
                    posts[id].timediff = hours + " hours ago."
                } else if (minutes > 0) {
                    posts[id].timediff = minutes + " minutes ago."
                } else {
                    posts[id].timediff = seconds + " seconds ago."
                }
            })
            setPosts(posts)
        })()
    }, [])
    return (
        <>
            <Navbar />
            {/* News etc */}
            <div className="flex flex-row space-x-2 px-12">
                <div className="grow-4 h-full">
                </div>
                <div className="grow h-full p-6 py-2">
                    <Select onValueChange={(val) => { setSort(val) }}>
                        <SelectTrigger className="w-[180px] mb-4">
                            <SelectValue placeholder="Sort News By" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectGroup>
                                <SelectLabel>News</SelectLabel>
                                <SelectItem value="date">Date</SelectItem>
                                <SelectItem value="popularity">Popularity</SelectItem>
                            </SelectGroup>
                        </SelectContent>
                    </Select>
                    <BentoGrid className="max-w-4xl mx-auto">
                        {sort === "date" ?
                            posts?.sort(datesort).map((post, i) => (
                                <Link href={"/app/news/" + post.id}>
                                    <BentoGridItem
                                        key={i}
                                        icon={<Stats views={post.views} likes={post.likes} comments={post.comments} timediff={post.timediff}/>}
                                        title={post.title.length > 50 ? post.title.substring(0, 50) + "..." : post.title}
                                        description={removeHtmlTags(post.content.substring(0, 70) + "...")}
                                        header={<AspectRatio ratio={16 / 9}><Image src={post.pictures[0]} fill alt={post.title} className="max-h[275px] -mr-8 -mb-16" /></AspectRatio>}
                                        className={"border-gray-100 cursor-pointer"}
                                    />
                                </Link>
                            ))
                            :
                            posts?.sort(popularity).map((post, i) => (
                                <Link href={"/app/news/" + post.id}>
                                    <BentoGridItem
                                        key={i}
                                        icon={<Stats views={post.views} likes={post.likes} comments={post.comments} timediff={post.timediff}/>}
                                        title={post.title.length > 50 ? post.title.substring(0, 50) + "..." : post.title}
                                        description={removeHtmlTags(post.content.substring(0, 70) + "...")}
                                        header={<AspectRatio ratio={16 / 9}><Image src={post.pictures[0]} fill alt={post.title} className="max-h[275px] -mr-8 -mb-16" /></AspectRatio>}
                                        className={"border-gray-100 cursor-pointer"}
                                    />
                                </Link>
                            ))
                        }
                        { }
                    </BentoGrid>
                </div>
                <div className="grow-4 h-full">

                </div>
            </div>
        </>
    )
}