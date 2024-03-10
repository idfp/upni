import Image from "next/image";
import Link from "next/link"
import { Key } from "lucide-react"
import { Boxes } from "../components/ui/background-boxes";
import { cn } from "@/lib/utils";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Button } from "@/components/ui/button"

export default function Home() {
  return (
    <div className="h-screen relative w-full overflow-hidden bg-green-50 flex flex-col items-center justify-center ">
      <div className="absolute inset-0 w-full h-full bg-green-50 z-20 [mask-image:radial-gradient(transparent,white)] pointer-events-none" />
      <Boxes />
      <div className="flex flex-row items-center content-center flex-wrap">

        <div className="m-32 ABSOLUTEZINDEX">
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
        <div className="bg-white rounded-lg min-h-48 min-w-64 z-20 m-32 border-solid border border-gray-300">
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
                <Input id="id" placeholder="mahasiswa@upnv.ac.id" />
              </div>
              <div className="space-y-1">
                <Label htmlFor="password">Password</Label>
                <Input id="password" type="password" placeholder="********" />
              </div>
              <Link href="/forgot" className="text-gray-500 text-xs">Forgot Password</Link>
              <Button className="my-4" style={{ marginLeft: "70%" }}><Key className="mr-2 h-4 w-4" />Login</Button>
            </TabsContent>
            <TabsContent value="register" className="px-8 inline-block">
              <p className="text-sm text-gray-500 mb-4 mt-0">
                Buat akun baru di UPN Insight, kosongkan NIM apabila tidak memiliki.
              </p>

              <div className="space-y-1 mt-2">
                <Label htmlFor="id">Email</Label>
                <Input id="id" placeholder="mahasiswa@upnv.ac.id" />
              </div>
              <div className="space-y-1 mt-2">
                <Label htmlFor="nim">NIM</Label>
                <Input id="nim" placeholder="2310123456" />
              </div>
              <div className="space-y-1 mt-2">
                <Label htmlFor="password">Password</Label>
                <Input id="password" type="password" placeholder="********" />
              </div>
              <div className="space-y-1 mt-2">
                <Label htmlFor="rpassword">Retype Password</Label>
                <Input id="rpassword" type="password" placeholder="********" />
              </div>
              <Button className="my-4" style={{ marginLeft: "70%" }}><Key className="mr-2 h-4 w-4" />Register</Button>
            </TabsContent>
          </Tabs>
        </div>
      </div>
    </div>
  );
}
