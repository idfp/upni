"use client";
import { Navbar } from "@/components/navbar"
import { useEffect, useState } from "react"
import { getCookie } from "@/lib/getCookie"
import { User, defaultUser } from "@/class/user"
import { Post } from "@/class/post"
import { Button } from "@/components/ui/button"
import { NotebookPen, Pencil, Trash2 } from "lucide-react"
import { AspectRatio } from "@radix-ui/react-aspect-ratio"
import Image from "next/image";
import { Separator } from "@/components/ui/separator";
import { removeHtmlTags } from "@/lib/utils";
import Link from "next/link";

export default function Author() {
    const [user, setUser] = useState<User>(defaultUser)
    const [posts, setPosts] = useState<Array<Post>>()
    const [drafts, setDrafts] = useState<Array<Post>>()
    async function deletePost(id: number) {
        await (await fetch("/api/posts", {
            method: "DELETE",
            body: JSON.stringify({ id }),
            credentials: "include"
        })).json()
    }
    async function deleteDraft(id: number){
        await (await fetch("/api/draft", {
            method: "DELETE",
            body: JSON.stringify({ id }),
            credentials: "include"
        })).json()
    }
    useEffect(() => {
        (async () => {
            const token = getCookie("token")
            const user: User = JSON.parse(atob(token.split(".")[1].replace(/_/g, '/').replace(/-/g, '+')))
            setUser(user)
            const res = await (await fetch("/api/posts?user=" + user.id)).json()
            res.forEach((post: Post, id: number) => {
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
                    res[id].timediff = years + " years ago."
                } else if (months > 0) {
                    res[id].timediff = months + " months ago."
                } else if (days > 0) {
                    res[id].timediff = days + " days ago."
                } else if (hours > 0) {
                    res[id].timediff = hours + " hours ago."
                } else if (minutes > 0) {
                    res[id].timediff = minutes + " minutes ago."
                } else {
                    res[id].timediff = seconds + " seconds ago."
                }
            })
            setPosts(res.filter(x => {
                return x.category == "NEWS"
            }))
            const res1 = await (await fetch("/api/drafts")).json()
            res1.forEach((post: Post, id: number) => {
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
                    res1[id].timediff = years + " years ago."
                } else if (months > 0) {
                    res1[id].timediff = months + " months ago."
                } else if (days > 0) {
                    res1[id].timediff = days + " days ago."
                } else if (hours > 0) {
                    res1[id].timediff = hours + " hours ago."
                } else if (minutes > 0) {
                    res1[id].timediff = minutes + " minutes ago."
                } else {
                    res1[id].timediff = seconds + " seconds ago."
                }
            })
            setDrafts(res1)
        })()
    }, [])
    return (<>
        <Navbar />
        <div className="max-w-[900px] mx-auto mt-8">
            <h1 className="text-4xl mb-4">Hai, {user.name}! </h1>
            <Separator />
            <div className="mt-8 flex flex-row">
                <h1 className="text-2xl">Drafts</h1>
                <Link className="ml-auto" href="/author/new">
                    <Button><NotebookPen className="mr-2" /> Unggah Konten</Button>
                </Link>
            </div>
            {drafts === undefined || drafts.length == 0 ?
                <div className="mt-8 w-full flex justify-center items-center">
                    <h1 className="mx-auto">Tidak ada draft berita baru.</h1>
                </div>
                :
                <div>
                    {drafts?.map(draft => {
                        return (
                            <>
                                <div className="flex flex-row mb-4 mt-4">

                                    <Link href={"/author/new?draftid=" + draft.id} className="flex flex-row w-full">
                                        <img className="object-cover" style={{ width: "160px", height: "120px" }} src={draft.pictures[0]} />
                                        <div className="ml-2 w-full">
                                            <h1 className="font-bold">{draft.title}</h1>
                                            <p>{removeHtmlTags(draft.content.substring(0, 70) + "...")}</p>
                                            <span className="text-gray-600">{draft.timediff}</span>
                                            <div className="flex flex-row justify-end">
                                                <Button className="mr-2"> <Pencil className="h-4 w-4 mr-2" /> Edit</Button>
                                                <Button variant={"destructive"} onClick={e => { e.stopPropagation(); deleteDraft(draft.id) }}> <Trash2 className="h-4 w-4 mr-2" />Delete</Button>
                                            </div>
                                        </div>
                                    </Link>

                                </div>
                                <Separator />
                            </>
                        )
                    })}
                </div>}
            <h1 className="text-2xl mt-16">Published News</h1>
            {posts === undefined || posts.length == 0 ?
                <div className="mt-8 w-full flex justify-center items-center">
                    <h1 className="mx-auto">Tidak ada berita yang anda publish.</h1>
                </div>
                :
                <div>
                    {posts?.map(post => {
                        return (
                            <>
                                <div className="flex flex-row mb-4 mt-4">

                                    <Link href={"/app/news/" + post.id} className="flex flex-row w-full">
                                        <img className="object-cover" style={{ width: "160px", height: "120px" }} src={post.pictures[0]} />
                                        <div className="ml-2 w-full">
                                            <h1 className="font-bold">{post.title}</h1>
                                            <p>{removeHtmlTags(post.content.substring(0, 70) + "...")}</p>
                                            <span className="text-gray-600">{post.timediff}</span>
                                            <div className="flex flex-row justify-end">
                                                <Link className="mr-2" href={"/author/edit/"+post.id}>
                                                    <Button> <Pencil className="h-4 w-4 mr-2" /> Edit</Button>
                                                </Link>
                                                <Button variant={"destructive"} onClick={e => { e.stopPropagation(); deletePost(post.id) }}> <Trash2 className="h-4 w-4 mr-2" />Delete</Button>
                                            </div>
                                        </div>
                                    </Link>

                                </div>
                                <Separator />
                            </>
                        )
                    })}
                </div>}
        </div>
    </>)
}