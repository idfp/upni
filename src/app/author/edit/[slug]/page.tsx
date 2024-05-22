"use client";
import { Navbar } from "@/components/navbar";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { useState, useRef, useEffect } from "react";
import { AspectRatio } from "@/components/ui/aspect-ratio";
import Image from "next/image"
import { Editor } from "@tinymce/tinymce-react";
import AutoResizableTextarea from "@/components/textarea"
import { base64ArrayBuffer } from "@/lib/buffertobase64"
import { Button } from "@/components/ui/button";
import { Save, Send, Pencil } from "lucide-react";
import { useRouter } from 'next/navigation'
import { toast } from "sonner"
import { Post } from "@/class/post";

const Overlay = () => {
    return (
        <div className="absolute inset-0 bg-black opacity-0 hover:opacity-20 transition-opacity duration-300">
            <Pencil className="mt-96 ml-auto mr-6 w-8 h-8 text-white" />
        </div>
    );
};

export default function EditPost({ params }: { params: { slug: string } }) {
    const [title, setTitle] = useState("Judul")
    const [header, setHeader] = useState("/add-image.jpg")
    const inputRef = useRef<HTMLInputElement>(null)
    const [value, setValue] = useState("");
    const [text, setText] = useState("");
    const [saveState, setSaveState] = useState("Saved")
    const [id, setId] = useState(-1)
    const router = useRouter()
    useEffect(() => {
        (async () => {
            const postid = params.slug

            if (isNaN(Number.parseInt(postid))) return
            setId(Number.parseInt(postid))
            const res:Post = await (await fetch("/api/posts?id=" + postid, {
                method: "GET",
                credentials: "include"
            })).json()
            setValue(res.content)
            setHeader(res.pictures[0])
            setTitle(res.title)
        })()
    }, [])


   
    const uploadImage = async (event: React.ChangeEvent<HTMLInputElement>) => {
        if (event.target.files === null) {
            return
        }
        const imageArrayBuffer = await event.target.files[0].arrayBuffer()
        const imageB64 = base64ArrayBuffer(imageArrayBuffer)
        const res = await (await fetch("/api/image", {
            method: "POST",
            credentials: "include",
            body: imageB64
        })).json()
        if (res.status === "ok") {
            setHeader(res.location)

        }
    }
    const onEditorInputChange = (newValue, editor) => {
        setValue(newValue)
        setText(editor.getContent({ format: "text" }))

    }
    const publish = async () => {
        setSaveState("Publishing...")
        const res = await (await fetch("/api/posts", {
            body: JSON.stringify({
                id: id,
                content: value,
                header,
                title
            }),
            credentials: "include",
            method: "PUT",
        })).json()
        if (res.status === "ok") {
            setSaveState("Published")
            toast("Berhasil mengedit berita.")
            setTimeout(() => {
                router.push("/app/news/" + id)
            }, 500)
            return
        }
        setSaveState("Error Publishing...")
    }
    return (<>
        <Navbar />
        <div className="px-10 py-2">

            <h1 className="font-sans text-xl sm:text-2xl lg:text-4xl font-normal">Edit Post</h1>

                <div className="px-8 py-2">
                    <div className="max-w-[800px] mx-auto">
                        <input className="hidden" type="file" ref={inputRef} onChange={uploadImage} />
                        <div className="relative cursor-pointer" onClick={() => { inputRef.current?.click() }}>
                            <AspectRatio ratio={16 / 9} className="bg-muted">
                                <Image
                                    src={header}
                                    alt="Hero image"
                                    fill
                                    className="object-cover"
                                />
                            </AspectRatio>
                            <Overlay />
                        </div>
        
                        <AutoResizableTextarea autoFocus placeholder="Tulis Judul Disini" className="mb-12 w-full mt-8 h-12 font-sans text-xl sm:text-2xl lg:text-4xl font-bold focus:border-none focus:outline-none" value={title} onChange={x => {setTitle(x.target.value);}} />
                        <Editor
                            apiKey='5giff1qn36x3xf186a0i7l6qagfzedlzzgs73ecj10eddt3n'
                            init={{
                                plugins: 'anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount linkchecker',
                                toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat',
                                tinycomments_mode: 'embedded',
                                menubar: '',
                                images_upload_url: '/api/image',
                                images_reuse_filename: true,
                                automatic_uploads: true
                            }}
                            onEditorChange={(newValue, editor) => onEditorInputChange(newValue, editor)}
                            onInit={(evt, editor) => setText(editor.getContent({ format: "text" }))}
                            value={value}
                            initialValue="Isi Konten Berita." />
                        <Button className="mt-4" variant="outline" onClick={publish}>
                            <Send className="mr-1 w-4 h-4" />Save</Button>
                        <span style={{ marginLeft: "95%", marginTop: "-20px" }}>{saveState}</span>
                    </div>
                </div>
        </div>
    </>)
}