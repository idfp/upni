"use client"
import { Navbar } from "@/components/navbar"
import { useEffect, useRef, useState } from "react"
import { Post } from "@/class/post"
import { Avatar, AvatarFallback, AvatarImage } from "@radix-ui/react-avatar"
import { Separator } from "@/components/ui/separator"
import { Editor } from "@tinymce/tinymce-react"
import { Button } from "@/components/ui/button"
import { Paperclip, Send, Trash2, Heart, GanttChart, MessageCircle } from "lucide-react"
import Image from "next/image"
import { AspectRatio } from "@radix-ui/react-aspect-ratio"
import Link from "next/link"
type Attachment = {
    file: File,
    bloburl: string
}
const Overlay = () => {
    return (
        <div className="absolute inset-0 bg-black opacity-0 hover:opacity-60 transition-opacity duration-300 rounded-lg">
            <Trash2 className="mx-auto mt-5 w-8 h-8 text-white" />
        </div>
    );
};


export default function Discussion() {
    const [discussions, setDiscussions] = useState<Array<Post>>([])
    const [discussionsContent, setDiscussionsContent] = useState<Array<string>>([])
    const [value, setValue] = useState("");
    const [text, setText] = useState("");
    const [attachments, setAttachments] = useState<Array<Attachment>>([])
    const attachmentRef = useRef<HTMLInputElement>(null)
    const [likedPosts, setLikedPosts] = useState<Array<number>>([])
    useEffect(() => {
        (async () => {
            const discussions = await (await fetch("/api/posts?type=discussion", {
                method: "GET",
                credentials: "include"
            })).json()
            discussions.forEach((discussion: Post, id) => {
                const dateVariable: Date = new Date(discussion.createdAt);
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

                    discussions[id].timediff = years + " years ago."
                } else if (months > 0) {
                    discussions[id].timediff = months + " months ago."
                } else if (days > 0) {
                    discussions[id].timediff = days + " days ago."
                } else if (hours > 0) {
                    discussions[id].timediff = hours + " hours ago."
                } else if (minutes > 0) {
                    discussions[id].timediff = minutes + " minutes ago."
                } else {
                    discussions[id].timediff = seconds + " seconds ago."
                }
            })
            setDiscussions(discussions)

            const contents = discussions.map(x => x.content.slice(0, 120) + (x.content.length > 120 ? '...' : ''))
            setDiscussionsContent(contents)

            const settings = await (await fetch("/api/settings", {
                method: "GET",
                credentials: "include"
            })).json()
            if (settings.postLikes !== undefined) {
                setLikedPosts(settings.postLikes)
            }
        })()
    }, [])
    const onEditorInputChange = (newValue, editor) => {
        setValue(newValue)
        setText(editor.getContent({ format: "text" }))
    }
    async function addAttachment(event: React.ChangeEvent<HTMLInputElement>) {
        if (event.target.files === null) {
            return
        }
        const image: File = event.target.files[0]
        const bloburl = URL.createObjectURL(image)
        setAttachments([...attachments, { file: image, bloburl }])
    }
    return (<>
        <Navbar />
        <div className="w-full p-16 pt-0">
            <div className="max-w-[800px] mx-auto">
                <Editor
                    apiKey='5giff1qn36x3xf186a0i7l6qagfzedlzzgs73ecj10eddt3n'
                    init={{
                        plugins: 'anchor autolink charmap codesample emoticons image link lists searchreplace table visualblocks wordcount checklist mediaembed casechange export formatpainter pageembed linkchecker a11ychecker tinymcespellchecker permanentpen powerpaste advtable advcode editimage advtemplate mentions tinycomments tableofcontents footnotes mergetags autocorrect typography inlinecss markdown',
                        toolbar: 'bold italic underline strikethrough | link | checklist numlist bullist ',
                        tinycomments_mode: 'embedded',
                        menubar: '',
                        statusbar: false,
                        height: 200,
                        placeholder: "Write Something...",
                        images_upload_url: '/api/image',
                        images_reuse_filename: true,
                        automatic_uploads: true
                    }}
                    onEditorChange={(newValue, editor) => onEditorInputChange(newValue, editor)}
                    onInit={(evt, editor) => setText(editor.getContent({ format: "text" }))}
                    value={value}
                    initialValue="" />
                <div className="flex flex-row">
                    <input className="hidden" type="file" ref={attachmentRef} onChange={addAttachment} />
                    <div className="flex flex-row overflow-x-auto mt-4">
                        {
                            attachments.map((attachment, index) => {
                                return <>
                                    <div className="relative cursor-pointer w-[80px] h-[80px] mr-4" onClick={() => {
                                        const clone = [...attachments];
                                        clone.splice(index, 1)
                                        setAttachments(clone)
                                    }}>
                                        <img
                                            src={attachment.bloburl}
                                            alt={"attachment"}
                                            className="w-[80px] h-[80px] object-cover rounded-lg"
                                        />
                                        <Overlay />
                                    </div>
                                </>
                            })
                        }
                    </div >
                    <Button variant={"outline"} className="ml-auto mt-4" onClick={() => { attachmentRef.current?.click() }}>
                        <Paperclip className="h-4 w-4 mr-2" />
                        Attach
                    </Button>
                    <Button className="ml-4 mt-4" onClick={() => { attachmentRef.current?.click() }}>
                        <Send className="h-4 w-4 mr-2" />
                        Post
                    </Button>
                </div>
                {discussions.map((discussion) => {
                    let isLiked = false
                    let id = -1
                    likedPosts.forEach((post, ind) => {
                        if (post == discussion.id) {
                            isLiked = true
                            id = ind
                        }
                    })
                    const toggleLike = async () => {
                        const discid = discussion.id
                        if (isLiked) {
                            const likes = [...likedPosts]
                            likes.splice(id, 1)
                            setLikedPosts(likes)
                            isLiked = false
                            discussion.likes = Number.parseInt(discussion.likes + '') - 1
                        }else{
                            setLikedPosts([...likedPosts, discid])
                            isLiked = true
                            discussion.likes = Number.parseInt(discussion.likes + '') + 1
                        }
                        const res = await (await fetch("/api/likes?type=post&id=" + discid, {
                            method: "POST",
                            credentials: "include"
                        })).json()
                    }
                    return <>
                        <Link href={`/app/discussion/${discussion.id}`}>
                            <div className="flex flex-row mt-4 max-w-[800px] mx-auto space-x-2">
                                <Avatar className="cursor-pointer h-14 w-14" onClick={() => { console.log("Avatar Clicked") }}>
                                    <AvatarImage src={discussion.profilePicture} alt={discussion.author + ''} />
                                    <AvatarFallback>ID</AvatarFallback>
                                </Avatar>
                                <div className="mt-1">
                                    <span className="text-gray-800 mr-4">{discussion.author}</span>
                                    <span className="text-gray-500 mr-4">{discussion.createdAt.toLocaleString().substring(0, discussion.createdAt.toLocaleString().length - 8).replace("T", " ")} - {discussion.timediff}</span><br />
                                </div>
                            </div>
                            <p className="ml-16 -mt-5 mb-8">
                                {discussion.content}
                            </p>
                            <div className="ml-16 mb-2">
                                {
                                    discussion.pictures.length == 0 ?
                                        <></>
                                        :
                                        (discussion.pictures.length == 1 ?
                                            <>
                                                <img alt="attachment1" className="w-[400px] h-[400px] object-cover rounded-lg" src={discussion.pictures[0]} />
                                            </>
                                            :
                                            (discussion.pictures.length == 2 ?
                                                <></>
                                                :
                                                (discussion.pictures.length == 3 ?
                                                    <></>
                                                    :
                                                    <></>
                                                )
                                            )
                                        )
                                }
                            </div>
                        </Link>
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
                                <span className="text-sm">{discussion.likes}</span>
                            </div>
                            <div className="flex flex-row items-center">
                                <Button variant="link" size="icon">
                                    <MessageCircle className="h-6 w-6" />
                                </Button>
                                <span className="text-sm">{discussion.comments}</span>
                            </div>
                            <div className="flex flex-row items-center">
                                <Button variant="link" size="icon">
                                    <GanttChart className="h-6 w-6" />
                                </Button>
                                <span className="text-sm">{discussion.views}</span>
                            </div>
                        </div>
                        <Separator />
                    </>
                })}
            </div>
        </div>
    </>)
}