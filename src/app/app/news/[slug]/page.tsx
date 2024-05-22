"use client";

import { useEffect, useState } from "react"
import { redirect } from 'next/navigation'
import { Post } from "@/class/post";
import { Comment } from "@/class/comment"
import { getCookie } from "@/lib/getCookie";
import { User, defaultUser } from "@/class/user"
import Image from "next/image"
import Link from "next/link"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button";
import { Search, Heart, MessageCircle, GanttChart, Send } from "lucide-react";
import {
    Avatar,
    AvatarFallback,
    AvatarImage,
} from "@/components/ui/avatar"
import { Skeleton } from "@/components/ui/skeleton";
import { AspectRatio } from "@/components/ui/aspect-ratio"
import { Textarea } from "@/components/ui/textarea"
import { Navbar } from "@/components/navbar";


export default function News({ params }: { params: { slug: string } }) {
    const [post, setPost] = useState<Post>()
    const [user, setUser] = useState<User>(defaultUser)
    const [comments, setComments] = useState<Array<Comment>>([])
    const [comment, setComment] = useState("")
    const [isLiked, setIsLiked] = useState(false)
    const [timediff, setTimediff] = useState("")
    async function sendComment() {
        const result: Comment = await (await fetch("/api/comments", {
            method: "POST",
            credentials: "include",
            body: JSON.stringify({
                content: comment,
                type: "post",
                id: post?.id
            })
        })).json()
        setComments([...comments, result])
        setComment("")
    }
    async function toggleLike() {
        const id = params.slug
        const res = await (await fetch("/api/likes?type=post&id=" + id, {
            method: "POST",
            credentials: "include"
        })).json()
        console.log(res)
        if (isLiked) {
            setIsLiked(false)
            if (post) {
                setPost({ ...post, likes: Number.parseInt(post.likes + '') - 1 })
            }
        } else { 
            setIsLiked(true)
            if (post) {
                setPost({ ...post, likes: Number.parseInt(post.likes + '') + 1 })
            }
        }
    }
    useEffect(() => {
        (async () => {
            const id = params.slug
            if (isNaN(parseInt(id))) {
                redirect("/app")
                return
            }
            const token = getCookie("token");
            setUser(JSON.parse(atob(token.split(".")[1].replace(/_/g, '/').replace(/-/g, '+'))));
            const post = await (await fetch("/api/posts?addViews=true&id=" + id, {
                method: "GET",
                credentials: "include"
            })).json()
            setPost(post)
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
                setTimediff(years + " years ago.")
            } else if (months > 0) {
                setTimediff( months + " months ago.")
            } else if (days > 0) {
                setTimediff(days + " days ago.")
            } else if (hours > 0) {
                setTimediff(hours + " hours ago.")
            } else if (minutes > 0) {
                setTimediff(minutes + " minutes ago.")
            } else {
                setTimediff(seconds + " seconds ago.")
            }
            let comments = await (await fetch("/api/comments?type=post&id=" + id, {
                method: "GET",
                credentials: "include"
            })).json()
            console.log(comments)
            comments.reverse()
            console.log(comments)
            comments.forEach((comment:Comment, id) => {
                const dateVariable: Date = new Date(comment.createdAt);
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

                    comments[id].timediff = years + " years ago."
                } else if (months > 0) {
                    comments[id].timediff = months + " months ago."
                } else if (days > 0) {
                    comments[id].timediff = days + " days ago."
                } else if (hours > 0) {
                    comments[id].timediff = hours + " hours ago."
                } else if (minutes > 0) {
                    comments[id].timediff = minutes + " minutes ago."
                } else {
                    comments[id].timediff = seconds + " seconds ago."
                }
            })
            setComments(comments)

            const liked = await (await fetch("/api/likes?type=post&id=" + id, {
                method: "GET",
                credentials: "include"
            })).json()
            if (liked.isLiked) {
                setIsLiked(true)
            }
        })()
    }, [])
    return (
        <>
            <Navbar/>
            <div className="w-full p-16 pt-8">
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
                        <AspectRatio ratio={16 / 9} className="bg-muted">
                            <Image
                                src={post.pictures[0]}
                                alt="Hero image"
                                fill
                                className="object-cover"
                            />
                        </AspectRatio>
                        <h1 className="mt-8 font-sans text-xl sm:text-2xl lg:text-4xl font-bold">{post.title}</h1>
                        <div className="flex flex-row mt-4 max-w-[800px] mx-auto items-center space-x-2">
                            <Avatar className="cursor-pointer h-14 w-14" onClick={() => { console.log("Avatar Clicked") }}>
                                <AvatarImage src={post.profilePicture} alt={user ? user.name : ''} />
                                <AvatarFallback>ID</AvatarFallback>
                            </Avatar>
                            <div>
                                <span className="text-gray-600">{post.author}</span><br />
                                <span className="text-gray-500">{post.createdAt.toLocaleString().substring(0, post.createdAt.toLocaleString().length - 8).replace("T", " ")} - {timediff}</span>
                            </div>
                        </div>
                        <p className="mt-8 mb-8" dangerouslySetInnerHTML={{__html: post.content}}></p>
                        <div className="flex flex-row items-center space-x-3">
                            <div className="flex flex-row items-center">
                                <Button variant="link" size="icon" onClick={toggleLike}>
                                    {
                                        isLiked ?
                                            <div className="h-6 w-6">
                                                <img src="/heart.svg" alt="heart" />
                                            </div>
                                            :
                                            <Heart className="h-6 w-6" />
                                    }
                                </Button>
                                <span className="text-sm">{post.likes}</span>
                            </div>
                            <div className="flex flex-row items-center">
                                <Button variant="link" size="icon">
                                    <MessageCircle className="h-6 w-6" />
                                </Button>
                                <span className="text-sm">{post.comments}</span>
                            </div>
                            <div className="flex flex-row items-center">
                                <Button variant="link" size="icon">
                                    <GanttChart className="h-6 w-6" />
                                </Button>
                                <span className="text-sm">{post.views}</span>
                            </div>
                        </div>
                        <div className="mt-8 flex flex-col">
                            <h1 className="font-sans text-md sm:text-xl mb-4 lg:text-2xl font-medium">Komentar</h1>
                            {
                                comments?.length == 0 ?
                                    <span className="font-sans text-md text-gray-500">Tidak ada komentar untuk saat ini...</span>
                                    :
                                    comments.map(comment => (<>
                                        <div className="flex flex-row mt-2">
                                            <Avatar className="cursor-pointer h-14 w-14 mr-2" onClick={() => { console.log("Avatar Clicked") }}>
                                                <AvatarImage src={comment.profilePicture} alt={comment ? comment.author : ''} />
                                                <AvatarFallback>ID</AvatarFallback>
                                            </Avatar>
                                            <div>
                                                <h3 className="font-sans font-bold mt-1">{comment.author} <span className="font-normal ">- {comment.timediff}</span></h3>
                                                <p>{comment.content}</p>
                                            </div>
                                        </div>
                                        <span className="w-full h-[0.1px] m-4 bg-gray-200"></span>
                                    </>))
                            }
                            <h1 className="font-sans text-sm sm:text-md mb-4 mt-8 lg:text-xl font-normal">Tulis Komentar</h1>
                            <Textarea value={comment} placeholder="Type your comment here." onChange={(x) => { setComment(x.target.value) }} />
                            <Button className="mt-4 ml-auto" onClick={sendComment}>
                                <Send className="mr-2 h-4 w-4" />
                                Kirim
                            </Button>
                        </div>
                    </div>}
            </div>
        </>
    )
}