"use client"
import { useRouter } from 'next/navigation'
import { useEffect, useState } from "react"
import { Post } from '@/class/post'
import { Podcast } from '@/class/podcast'
import { Navbar } from '@/components/navbar'
import { AspectRatio } from "@/components/ui/aspect-ratio"
import { BentoGrid, BentoGridItem } from "@/components/ui/bento-grid";
import { Heart, MessageCircle, GanttChart } from "lucide-react";
import Image from "next/image";
import Link from "next/link";
import { removeHtmlTags } from "@/lib/utils";
import {
    Select,
    SelectContent,
    SelectGroup,
    SelectItem,
    SelectLabel,
    SelectTrigger,
    SelectValue,
} from "@/components/ui/select"
import { Separator } from '@/components/ui/separator'
function popularity(a: Post | Podcast, b: Post | Podcast) {
    return b.views - a.views
}
function datesort(a: Post | Podcast, b: Post | Podcast) {
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
export default function Search({ params }: { params: { slug: string } }) {
    const [posts, setPosts] = useState<Array<Post>>([])
    const [podcasts, setPodcasts] = useState<Array<Podcast>>([])
    const [query, setQuery] = useState("")
    const router = useRouter()
    const [sortPost, setSortPost] = useState("date")
    const [sortPodcast, setSortPodcast] = useState("date")
    useEffect(() => {
        const query = params.slug
        if (query === null) {
            router.push("/app")
            return
        }
        setQuery(query)
        fetch(`/api/search?query=${query}`, {
            method: "GET",
            credentials: "include"
        })
            .then(x => x.json())
            .then(res => {
                let posts = res.posts
                posts.forEach((post: Post, id: number) => {
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
                let podcasts = res.podcasts
                podcasts.forEach((podcast: Podcast, id: number) => {
                    const dateVariable: Date = new Date(podcast.createdAt);
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
                        podcasts[id].timediff = years + " years ago."
                    } else if (months > 0) {
                        podcasts[id].timediff = months + " months ago."
                    } else if (days > 0) {
                        podcasts[id].timediff = days + " days ago."
                    } else if (hours > 0) {
                        podcasts[id].timediff = hours + " hours ago."
                    } else if (minutes > 0) {
                        podcasts[id].timediff = minutes + " minutes ago."
                    } else {
                        podcasts[id].timediff = seconds + " seconds ago."
                    }
                })
                setPodcasts(podcasts)
            })
    }, [])
    return (<>
        <Navbar query={query}/>
        <div className="flex flex-row space-x-2 px-12">
            <div className="grow-4 h-full">
            </div>
            <div className="grow h-full p-6 py-2">
                <h1 className='text-2xl mb-4 font-semibold -ml-2'>Hasil Pencarian untuk: {query}</h1>
                <Separator className='mb-4' />
                <h1 className='text-2xl mb-4'>News</h1>
                <Select onValueChange={(val) => { setSortPost(val) }}>
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
                {posts.length == 0 ?
                    <>
                        <h1>Tidak ada hasil pencarian pada News.</h1>
                    
                    </>
                    :
                    <BentoGrid className="max-w-4xl mx-auto">
                        {sortPost === "date" ?
                            posts?.sort(datesort).map((post, i) => (
                                <Link href={"/app/news/" + post.id}>
                                    <BentoGridItem
                                        key={i}
                                        icon={<Stats views={post.views} likes={post.likes} comments={post.comments} timediff={post.timediff} />}
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
                                        icon={<Stats views={post.views} likes={post.likes} comments={post.comments} timediff={post.timediff} />}
                                        title={post.title.length > 50 ? post.title.substring(0, 50) + "..." : post.title}
                                        description={removeHtmlTags(post.content.substring(0, 70) + "...")}
                                        header={<AspectRatio ratio={16 / 9}><Image src={post.pictures[0]} fill alt={post.title} className="max-h[275px] -mr-8 -mb-16" /></AspectRatio>}
                                        className={"border-gray-100 cursor-pointer"}
                                    />
                                </Link>
                            ))
                        }
                    </BentoGrid>
                }
                <Separator className='mb-4 mt-20' />
                <h1 className='text-2xl mb-4'>Podcasts</h1>
                <Select onValueChange={(val) => { setSortPodcast(val) }}>
                    <SelectTrigger className="w-[180px] mb-4">
                        <SelectValue placeholder="Sort Podcasts By" />
                    </SelectTrigger>
                    <SelectContent>
                        <SelectGroup>
                            <SelectLabel>News</SelectLabel>
                            <SelectItem value="date">Date</SelectItem>
                            <SelectItem value="popularity">Popularity</SelectItem>
                        </SelectGroup>
                    </SelectContent>
                </Select>
                {podcasts.length == 0 ?
                    <>
                        <h1>Tidak ada hasil pencarian pada Podcasts.</h1>
                    </>
                    :
                    <BentoGrid className="max-w-4xl mx-auto">
                        {sortPodcast === "date" ?
                            podcasts?.sort(datesort).map((podcast, i) => (
                                <Link href={"/app/podcast/" + podcast.id}>
                                    <BentoGridItem
                                        key={i}
                                        icon={<Stats views={podcast.views} likes={podcast.likes} comments={podcast.comments} timediff={podcast.timediff} />}
                                        title={podcast.title.length > 50 ? podcast.title.substring(0, 50) + "..." : podcast.title}
                                        header={<AspectRatio ratio={16 / 9}><Image src={podcast.thumbnail} fill alt={podcast.title} className="max-h[275px] -mr-8 -mb-16" /></AspectRatio>}
                                        className={"border-gray-100 cursor-pointer"}
                                    />
                                </Link>
                            ))
                            :
                            podcasts?.sort(popularity).map((podcast, i) => (
                                <Link href={"/app/podcasts/" + podcast.id}>
                                    <BentoGridItem
                                        key={i}
                                        icon={<Stats views={podcast.views} likes={podcast.likes} comments={podcast.comments} timediff={podcast.timediff} />}
                                        title={podcast.title.length > 50 ? podcast.title.substring(0, 50) + "..." : podcast.title}
                                        header={<AspectRatio ratio={16 / 9}><Image src={podcast.thumbnail} fill alt={podcast.title} className="max-h[275px] -mr-8 -mb-16" /></AspectRatio>}
                                        className={"border-gray-100 cursor-pointer"}
                                    />
                                </Link>
                            ))
                        }
               
                    </BentoGrid>
                }
            </div>
            <div className="grow-4 h-full">
            </div>
        </div>
    </>)
}