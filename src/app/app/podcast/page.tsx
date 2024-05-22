"use client";
import { Navbar } from "@/components/navbar";
import { useEffect, useState } from "react";
import { Podcast } from "@/class/podcast";
import Image from "next/image";
import Link from "next/link";
import { Heart, MessageCircle, GanttChart } from "lucide-react";
import { AspectRatio } from "@radix-ui/react-aspect-ratio";
function Stats({ views, likes, comments }: { views: number, likes: number, comments: number }) {
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
        </div>
    )
}
const Overlay = ({ duration }) => {
    return (
        <div className="absolute inset-0 flex justify-end items-end p-1">
            <div className="bg-black opacity-80 rounded-sm text-white p-1 text-sm">{duration}</div>
        </div>
    );
};
export default function Pod() {
    const [podcasts, setPodcasts] = useState<Array<Podcast>>([])
    useEffect(() => {
        (async () => {
            const podcasts = await (await fetch("/api/podcasts", {
                method: "GET",
                credentials: "include"
            })).json()
            podcasts.forEach((podcast: Podcast, id: number) => {
                console.log(podcast)
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
        })()
    }, [])
    return (
        <>
            <Navbar />
            <div className="max-w-[1200px] mx-auto flex flex-row flex-wrap">
                {podcasts.map(podcast => {
                    podcast.thumbnail
                    return (

                        <Link className="m-2 max-w-[380px] mt-4" href={"/app/podcast/" + podcast.id}>
                            <div className="relative">
                                <Image src={podcast.thumbnail} width={320} height={180} style={{ width: "380px", height: "225px" }} className="object-cover" alt={podcast.title} />
                                <Overlay duration={`${Math.floor(podcast.duration / 60)}:${podcast.duration % 60 < 10 ? '0'+podcast.duration % 60:podcast.duration % 60}`} />
                            </div>
                            <div className="flex-row flex mt-2">
                                <img src={podcast.profilePicture} width={20} height={20} style={{ width: "40px", height: "40px", marginTop: "5px", marginRight: "8px", borderRadius: "9999px" }} />
                                <div>
                                    <h1 className="font-bold break-words">{podcast.title}</h1>
                                    <div className="flex flex-row items-center -mt-2">
                                        <h1 className="" style={{ wordBreak: "keep-all" }}>{podcast.author.length > 16 ? podcast.author.substring(0, 16) : podcast.author}</h1>
                                        <div className="ml-auto">
                                            <Stats views={podcast.views} likes={podcast.likes} comments={podcast.comments} />
                                        </div>
                                    </div>
                                    <div className="text-xs -mt-2 text-gray-500" >
                                        {podcast.timediff}
                                    </div>
                                </div>
                            </div>
                        </Link>
                    )
                })}
            </div>
        </>
    )
}