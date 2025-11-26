"use client"
import Image from "next/image";
import Link from "next/link"
import { Key } from "lucide-react"
import { Boxes } from "../components/ui/background-boxes";
import { cn } from "@/lib/utils";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Button } from "@/components/ui/button"
import { useEffect, useState } from "react";
import { useRouter } from 'next/navigation'
import { getCookie } from "@/lib/getCookie";
export default function Home() {
  const [username, setUsername] = useState("")
  const [email, setEmail] = useState("")
  const [password, setPassword] = useState("")
  const [password2, setPassword2] = useState("")
  const [errorLogin, setErrorLogin] = useState("")
  const [errorRegister, setErrorRegister] = useState("")
  const router = useRouter()
  async function login(){
    setErrorLogin("")
    const req = await fetch("/api/login", {
      method: "POST",
      body: JSON.stringify({ username, password })
    })
    const res = await req.json()
    if(res.status === "success"){
      return router.push("/app")
    }
    if(res.reason === "invalid credential"){
      return setErrorLogin("Password / Email Salah!")
    }
    setErrorLogin("Login gagal")
  }
  async function register(){
    setErrorRegister("")
    if(password !== password2) return setErrorRegister("Password tidak sesuai!")
    const req = await fetch("/api/register", {
      method: "POST",
      body: JSON.stringify({ email, username, password })
    })
    const res = await req.json()
    if(res.status === "success"){
      return router.push("/app")
    }
    if(res.reason === "email already used"){
      return setErrorRegister("Email sudah digunakan oleh user lain!")
    }
    return setErrorRegister("Register gagal")
  }
  useEffect(()=>{
    const token = getCookie("token")
    if(token.length > 0){
      router.push("/app")
    }
  }, [])
  return (
    <div className="w-full overflow-hidden bg-green-50 flex flex-col items-center justify-center pb-16 -my-16">
      <div className="absolute inset-0 w-full h-full bg-green-50 z-20 [mask-image:radial-gradient(transparent,transparent)] pointer-events-none" />
      <Boxes />
      <div className="flex flex-row items-center content-center flex-wrap lg:flex-no-wrap -pt-8">

        <div className="m-32 ABSOLUTEZINDEX w-screen lg:w-auto flex flex-col items-center content-center">
          <div className="bg-white z-20 m-8">
            <Image src={"/upni.svg"} width={200} height={200} alt="UPN Insight Logo" className="z-20" style={{ zIndex: 20, color: "#000" }} />
          </div>
          <h1 className={cn("md:text-4xl text-xl text-black text-center z-20 ")}>
            UPN Insight
          </h1>
          <p className="text-center mt-2 text-gray-700 z-20">
            Talks, News, and Discussion
          </p>
        </div>
        <div className="bg-white rounded-lg min-h-48 md:min-w-32 lg:min-w-64 z-20 m-auto sm:m-auto xl:m-32 lg:m-16 lg:mx-8 border-solid border border-gray-300">
          <h1 className="text-center m-8 text-black text-xl md:text-2xl">Masuk ke Halaman Utama</h1>
          <Tabs defaultValue="login" className="w-[400px] m-4">
            <TabsList className="grid w-full grid-cols-2">
              <TabsTrigger value="login">Login</TabsTrigger>
              <TabsTrigger value="register">Register</TabsTrigger>
            </TabsList>
            <TabsContent value="login" className="px-8 py-2 inline-block">
              <p className="text-sm text-gray-500 mb-4">
                Masuk menggunakan email / NIM dan password.
              </p>
              <div className="space-y-1">
                <Label htmlFor="id">Email / NIM</Label>
                <Input id="id" placeholder="user@mail.com" onChange={(x)=>{setUsername(x.target.value)}}/>
              </div>
              <div className="space-y-1">
                <Label htmlFor="password">Password</Label>
                <Input id="password" type="password" placeholder="********" onChange={(x)=>{setPassword(x.target.value)}} onKeyDown={(e)=>{
                  if(e.key === "Enter"){
                    login()
                  }
                }}/>
              </div>
              <Link href="/forgot" className="text-gray-500 text-xs">Forgot Password</Link>
              <p className="text-red-500 text-sm">{errorLogin}</p>
              <Button onClick={login} className="my-4" style={{ marginLeft: "70%" }}><Key className="mr-2 h-4 w-4" />Login</Button>
            </TabsContent>
            <TabsContent value="register" className="px-8 inline-block">
              <p className="text-sm text-gray-500 mb-4 mt-0">
                Buat akun baru di UPN Insight, kosongkan NIM apabila tidak memiliki.
              </p>

              <div className="space-y-1 mt-2">
                <Label htmlFor="id">Email</Label>
                <Input id="id" placeholder="user@mail.com" onChange={(x)=>{setEmail(x.target.value)}} />
              </div>
              <div className="space-y-1 mt-2">
                <Label htmlFor="nim">NIM</Label>
                <Input id="nim" placeholder="2310123456" onChange={(x)=>{setUsername(x.target.value)}}/>
              </div>
              <div className="space-y-1 mt-2">
                <Label htmlFor="password">Password</Label>
                <Input id="password" type="password" placeholder="********" onChange={(x)=>{setPassword(x.target.value)}}/>
              </div>
              <div className="space-y-1 mt-2">
                <Label htmlFor="rpassword">Retype Password</Label>
                <Input id="rpassword" type="password" placeholder="********" onChange={(x)=>{setPassword2(x.target.value)}} onKeyDown={(e)=>{
                  if(e.key === "Enter"){
                    register()
                  }
                }}/>
              </div>
              <p className="text-red-500 text-sm">{errorRegister}</p>
              <Button onClick={register} className="my-4" style={{ marginLeft: "70%" }}><Key className="mr-2 h-4 w-4" />Register</Button>
            </TabsContent>
          </Tabs>
        </div>
      </div>
    </div>
  );
}
