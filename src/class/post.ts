export type Post = {
    id: number;
    title: string;
    content: string;
    author: number;
    pictures: string[];
    likes: number;
    comments: number;
    views: number;
    createdAt: Date;
    category: string;
    profilePicture: string;
    isUpnMember: boolean;
    role: string;
}