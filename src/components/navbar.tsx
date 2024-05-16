import { User, defaultUser } from "@/class/user"
import Link from "next/link"
import Image from "next/image"
import { Button } from "./ui/button"
import { Input } from "./ui/input"
import { getCookie } from "@/lib/getCookie";
import { Avatar, AvatarFallback, AvatarImage } from "./ui/avatar"
import { Search, Pencil, Save } from "lucide-react"
import {
    Dialog,
    DialogContent,
    DialogDescription,
    DialogClose,
    DialogHeader,
    DialogTitle,
    DialogTrigger,
} from "@/components/ui/dialog"
import { base64ArrayBuffer } from "@/lib/buffertobase64"
import { Label } from "@/components/ui/label"
import { useEffect, useRef, useState } from "react"

export function Navbar() {
    const [user, setUser] = useState<User>(defaultUser)
    const [name, setName] = useState(user.name)
    const [username, setUserName] = useState(user.username)
    const [email, setEmail] = useState(user.email)
    const fileInput = useRef<HTMLInputElement>(null)

    useEffect(() => {
        const token = getCookie("token");
        const claims: User = JSON.parse(atob(token.split(".")[1].replace(/_/g, '/').replace(/-/g, '+')))
        setUser(claims)
        setName(claims.name)
        setUserName(claims.username)
        setEmail(claims.email)
    }, [])
    async function changeInfo() {
        const res = await (await fetch("/api/user", {
            method: "PUT",
            body: JSON.stringify({ username, email, name })
        })).json()
        if (res.status === "ok") {
            setUser({ ...user, name, username, email })
        }
    }
    async function changeAvatar(files: FileList | null) {
        if (files == null) {
            return
        }
        const image = base64ArrayBuffer(await files[0].arrayBuffer())
        const res = await (await fetch("/api/avatar", {
            method: "POST",
            credentials: "include",
            body: image
        })).json()
        if (res.status === "ok") {

            setUser({ ...user, profilePicture: res.link })
        }
    }
    return (
        <Dialog>
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
                    <Link href="/author/new">
                        <Button className="mr-4">
                            <Pencil className="w-4 h-4 mr-2" />
                            Author
                        </Button>
                    </Link>
                    <DialogTrigger>
                        <Avatar className="cursor-pointer" onClick={() => { console.log("Avatar Clicked") }}>
                            <AvatarImage src={user ? user.profilePicture : ""} alt={user ? user.name : ''} />
                            <AvatarFallback>ID</AvatarFallback>
                        </Avatar>
                    </DialogTrigger>
                </div>
            </div>
            <DialogContent className="max-w-[425px]">
                <DialogHeader>
                    <DialogTitle>Edit User</DialogTitle>
                    <DialogDescription className="font-sm">
                        Ubah data pribadi anda.
                    </DialogDescription>
                </DialogHeader>
                <div className="flex flex-col">
                    <Avatar className="cursor-pointer w-20 h-20 mx-auto" onClick={() => { fileInput.current?.click() }}>
                        <AvatarImage src={user ? user.profilePicture : ""} alt={user ? user.name : ''} />
                        <AvatarFallback>ID</AvatarFallback>
                    </Avatar>
                    <Button onClick={() => { fileInput.current?.click() }} variant="outline" className="-mt-6 z-10 h-8 w-8 p-0 rounded-full" style={{ marginLeft: "53%" }}>
                        <Pencil className="h-4 w-4" />
                    </Button>
                    <div className="px-4 pr-8 mt-4">
                        <Input onChange={(x) => { changeAvatar(x.target.files) }} ref={fileInput} id="picture" type="file" className="hidden" />
                        <Label htmlFor="name">Nama Lengkap</Label>
                        <Input value={name} onChange={(val) => { setName(val.target.value) }} className="mt-2" type="text" id="name" placeholder="Name" />
                        <Label htmlFor="email">Alamat Email</Label>
                        <Input value={email} onChange={(val) => { setEmail(val.target.value) }} className="mt-2" type="email" id="email" placeholder="email" />
                        <Label htmlFor="username">Username</Label>
                        <Input value={username} disabled={user.isUPNMember} onChange={(val) => { setUserName(val.target.value) }} className="mt-2" type="text" id="username" placeholder="username" />
                    </div>
                    <div className="ml-auto mt-4">
                        <DialogClose asChild>
                            <Button className="" onClick={changeInfo}>
                                <Save className="h-4 w-4 mr-2" />
                                Save
                            </Button>
                        </DialogClose>
                    </div>
                </div>
            </DialogContent>
        </Dialog>
    )
}