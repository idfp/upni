"use client"

import { useEffect, useState } from "react"
import { Podcast } from "@/class/podcast"
import { useRouter } from "next/navigation"
import { Navbar } from "@/components/navbar"
import {
    Card,
    CardContent,
    CardHeader,
    CardTitle,
} from "@/components/ui/card"
import {
    Avatar,
    AvatarFallback,
    AvatarImage,
} from "@/components/ui/avatar"
import { Search, Heart, MessageCircle, GanttChart, Send } from "lucide-react";
import { Button } from "@/components/ui/button"
import { Comment } from "@/class/comment"
import { Separator } from "@/components/ui/separator"
import { Input } from "@/components/ui/input"
import { User, defaultUser } from "@/class/user"
import { getCookie } from "@/lib/getCookie"
const Overlay = () => {
    return (
        <div className="absolute inset-0 bg-black opacity-80 flex justify-center items-center">
            <h1 className="text-white font-semibold text-4xl text-center">Podcast tidak tersedia<br />Silahkan kunjungi lagi nanti</h1>
        </div>
    );
};
export default function Player({ params }: { params: { slug: string } }) {
    const router = useRouter()
    const [podcast, setPodcast] = useState<Podcast>()
    const [timediff, setTimediff] = useState("")
    const [isLiked, setIsLiked] = useState(false)
    const [comments, setComments] = useState<Array<Comment>>([])
    const [comment, setComment] = useState("")
    const [user, setUser] = useState<User>(defaultUser)
    async function sendComment() {
        const result: Comment = await (await fetch("/api/comments", {
            method: "POST",
            credentials: "include",
            body: JSON.stringify({
                content: comment,
                type: "podcast",
                id: podcast?.id
            })
        })).json()
        const cmt: Comment = {
            id: 0,
            content: comment,
            createdAt: new Date(),
            posttype: "PODCAST",
            author: user.name,
            authorid: user.id,
            role: user.role,
            isUpnMember: user.isUPNMember,
            profilePicture: user.profilePicture,
            timediff: "Just Right Now..."
        }
        setComments([cmt, ...comments])
        setComment("")
    }
    async function handleInputKeyDown(event: React.KeyboardEvent<HTMLInputElement>) {
        if (event.key === 'Enter') {
            sendComment()
        }
    }
    async function toggleLike() {
        const id = params.slug
        const res = await (await fetch("/api/likes?type=podcast&id=" + id, {
            method: "POST",
            credentials: "include"
        })).json()
        console.log(res)
        if (isLiked) {
            setIsLiked(false)
            if (podcast) {
                setPodcast({ ...podcast, likes: Number.parseInt(podcast.likes + '') - 1 })
            }
        } else {
            setIsLiked(true)
            if (podcast) {
                setPodcast({ ...podcast, likes: Number.parseInt(podcast.likes + '') + 1 })
            }
        }
    }
    useEffect(() => {
        (async () => {
            const token = getCookie("token");
            setUser(JSON.parse(atob(token.split(".")[1].replace(/_/g, '/').replace(/-/g, '+'))));
            if (isNaN(Number.parseInt(params.slug))) return router.push("/app")
            const res = await (await fetch("/api/podcasts/" + params.slug, {
                method: "GET",
                credentials: "include"
            })).json()
            if (res.status && res.status === "fail") {
                return router.push("/app")
            }
            setPodcast(res)
            const dateVariable: Date = new Date(res.createdAt);
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

            const comments = await (await fetch("/api/comments?type=podcast&id=" + res.id, {
                method: "GET",
                credentials: "include"
            })).json()
            comments.reverse()

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

            const liked = await (await fetch("/api/likes?type=podcast&id=" + res.id, {
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
            <Navbar />
            {podcast === undefined ?
                <></>
                :
                <>
                    <div className="flex flex-row p-12 space-x-8 justify-center">
                        <div className="">
                            {podcast.url == null ?
                                <div className="relative">
                                    <Overlay />
                                    <img src={podcast.thumbnail} alt="podcast" className="object-cover" style={{ maxHeight: "70vh", minWidth: "60vw" }} />
                                </div>
                                :
                                <>
                                    <video style={{maxHeight: "70vh", minWidth: "60vw"}}
                                        controls>
                                        <source src={podcast.url} type="video/mp4" />
                                    </video>
                                </>
                            }
                            <h1 className="font-bold text-4xl mt-4">{podcast.title}</h1>
                            <div className="flex flex-row mt-2">
                                <Avatar className="cursor-pointer h-14 w-14" onClick={() => { console.log("Avatar Clicked") }}>
                                    <AvatarImage src={podcast.profilePicture} alt={podcast.author} />
                                    <AvatarFallback>ID</AvatarFallback>
                                </Avatar>
                                <div className="ml-4">
                                    <span className="text-gray-700 font-bold">{podcast.author}</span><br />
                                    <span className="text-gray-500">{podcast.createdAt.toLocaleString().substring(0, podcast.createdAt.toLocaleString().length - 8).replace("T", " ")} - {timediff}</span>
                                </div>
                                <div className="flex flex-row items-center space-x-3 ml-auto">
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
                                        <span className="text-sm">{podcast.likes}</span>
                                    </div>
                                    <div className="flex flex-row items-center">
                                        <Button variant="link" size="icon">
                                            <MessageCircle className="h-6 w-6" />
                                        </Button>
                                        <span className="text-sm">{podcast.comments}</span>
                                    </div>
                                    <div className="flex flex-row items-center">
                                        <Button variant="link" size="icon">
                                            <GanttChart className="h-6 w-6" />
                                        </Button>
                                        <span className="text-sm">{podcast.views}</span>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div>
                            <Card className="w-[450px]">
                                <CardHeader>
                                    <CardTitle>Komentar</CardTitle>
                                </CardHeader>
                                <CardContent>
                                    <Separator className="-mt-4 mb-4" />
                                    <div className="max-h-[500px] min-h-[400px] overflow-auto">
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
                                    </div>
                                    <div className="flex flex-row -mb-6 -ml-6">

                                        <input className="w-[450px] mt-4 px-4 rounded-bl-lg rounded-t-none rounded-r-none focus:outline-none border-1 border-gray-200 border" placeholder="Tulis komentar anda disini" type="text" value={comment} onChange={(e) => setComment(e.target.value)} onKeyDown={handleInputKeyDown} />
                                        <Button variant={"outline"} className="-mr-6 mt-4 rounded-l-none rounded-t-none border-l-0" onClick={() => { sendComment() }}><Send className="text-gray-400" /></Button>
                                    </div>
                                </CardContent>
                            </Card>
                        </div>
                    </div >
                </>}
        </>
    )
}