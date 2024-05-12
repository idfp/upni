"use client";
import { useEffect, useState } from "react"
import { redirect } from 'next/navigation'
import { getCookie } from "@/lib/getCookie";
import { Post } from "@/class/post";
import { User, defaultUser } from "@/class/user"
import { Comment } from "@/class/comment"
import { Avatar, AvatarFallback, AvatarImage } from "@radix-ui/react-avatar"
import {
    Carousel,
    CarouselContent,
    CarouselItem,
    CarouselNext,
    CarouselPrevious,
} from "@/components/ui/carousel"
import { Button } from "@/components/ui/button"
import { Paperclip, Send, Trash2, Heart, GanttChart, MessageCircle, CircleX } from "lucide-react"
import { Separator } from "@/components/ui/separator"
import { Textarea } from "@/components/ui/textarea"
import { useRouter} from 'next/navigation'

import Image from "next/image";

export default function Discussion({ params }: { params: { slug: string } }) {
    const [post, setPost] = useState<Post>()
    const [timediff, setTimediff] = useState("")
    const [comments, setComments] = useState<Array<Comment>>([])
    const [isLiked, setIsLiked] = useState(false)
    const [comment, setComment] = useState("")
    const router = useRouter()

    const [user, setUser] = useState<User>(defaultUser)
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
        setComments([...comments, {
            id: 0, 
            content: comment, 
            createdAt: new Date(), 
            posttype: "DISCUSSION", 
            author: user.name,
            authorid: user.id,
            role: user.role,
            isUpnMember: user.isUPNMember,
            profilePicture: user.profilePicture,
            timediff: "Just right now"
        }])
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
                setTimediff(months + " months ago.")
            } else if (days > 0) {
                setTimediff(days + " days ago.")
            } else if (hours > 0) {
                setTimediff(hours + " hours ago.")
            } else if (minutes > 0) {
                setTimediff(minutes + " minutes ago.")
            } else {
                setTimediff(seconds + " seconds ago.")
            }
            const comments = await (await fetch("/api/comments?type=post&id=" + id, {
                method: "GET",
                credentials: "include"
            })).json()
            setComments(comments)

            comments.forEach((comment: Comment, id) => {
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

            const liked = await (await fetch("/api/likes?type=post&id=" + id, {
                method: "GET",
                credentials: "include"
            })).json()
            if (liked.isLiked) {
                setIsLiked(true)
            }
        })()
    }, [])
    return (<>
        <div className="flex flex-row">
            <div className="flex pl-20 bg-black fixed" style={{ width: "60vw", height: "100vh" }}>
                <Button variant="link" className="fixed top-4 left-4" onClick={()=>{router.back()}}>
                    <CircleX color="white" />
                </Button>
                <Carousel className="h-full ">
                    <CarouselContent className="h-full" style={{ marginTop: "10vh"}}>
                        {
                            post?.pictures.map((picture, ind) => {
                                return <>
                                    <CarouselItem key={ind}>
                                        <img src={picture} style={{width:"55vw" }} className="mx-auto my-auto" />
                                    </CarouselItem>
                                </>
                            })
                        }
                    </CarouselContent>
                    <CarouselPrevious />
                    <CarouselNext className="bg-white" />
                </Carousel>
            </div>
            <div className="bg-black fixed" style={{ width: "5vw", height:"100vh", right: "35vw", zIndex:"-1"}}>

            </div>
            <div className="grow p-8 absolute right-0" style={{ maxWidth: "35vw" }}>
                {post === undefined ?
                    <></>
                    :
                    <>
                        <div className="flex flex-row mt-4 max-w-[800px] mx-auto space-x-2">
                            <Avatar className="cursor-pointer h-14 w-14" onClick={() => { console.log("Avatar Clicked") }}>
                                <AvatarImage src={post.profilePicture} alt={post.author + ''} />
                                <AvatarFallback>ID</AvatarFallback>
                            </Avatar>
                            <div className="mt-1">
                                <span className="text-gray-800 mr-4">{post.author}</span>
                                <span className="text-gray-500 mr-4">{post.createdAt.toLocaleString().substring(0, post.createdAt.toLocaleString().length - 8).replace("T", " ")} - {timediff}</span><br />
                            </div>
                        </div>
                        <p className="ml-16 -mt-5 mb-2">
                            {post.content}
                        </p>
                        <div className="flex flex-row items-center space-x-3 ml-16 mb-4">
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
                        <Separator />
                        <Textarea value={comment} placeholder="Type your comment here." onChange={(x) => { setComment(x.target.value) }} />
                        <Button className="mt-4" style={{ marginLeft: "80%" }} onClick={sendComment}>
                            <Send className="mr-2 h-4 w-4" />
                            Kirim
                        </Button>
                        <div style={{maxWidth: "30vw", lineBreak:"auto", wordBreak:"break-all"}}>
                        {
                            comments?.length == 0 ?
                                <span className="font-sans text-md text-gray-500">Tidak ada komentar untuk saat ini...</span>
                                :
                                comments.map(comment => (<>
                                    <div className="flex flex-row mt-2">
                                        <Avatar className="h-14 w-14 mr-2 rounded-lg" style={{borderRadius:"9999px !important"}}>
                                            <AvatarImage src={comment.profilePicture} alt={comment ? comment.author : ''} />
                                            <AvatarFallback>ID</AvatarFallback>
                                        </Avatar>
                                        <div style={{maxWidth: "25vw"}}>
                                            <h3 className="font-sans font-bold mt-1">{comment.author} <span className="font-normal ">- {comment.timediff}</span></h3>
                                            <p>{comment.content}</p>
                                        </div>
                                    </div>
                                    <Separator className="m-4"/>
                                </>))
                        }
                        </div>
                    </>
                }
            </div>
        </div>
    </>)
}