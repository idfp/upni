export type Post = {
    id: number;
    title: string;
    content: string;
    author: string | number;
    pictures: string[];
    likes: number;
    comments: number;
    views: number;
    createdAt: Date;
    category: string;
    profilePicture: string;
    timediff: string;
    isUpnMember: boolean;
    role: string;
}