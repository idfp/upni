export type Podcast = {
    id: number;
    title: string;
    thumbnail: string;
    duration: number;
    views: number;
    author: string;
    likes: number;
    comments: number;
    createdAt: Date;
    profilePicture: string;
    timediff: string;
    isUpnMember: boolean;
    role: string;
    url: string | null;
}