export type Comment = {
    id: number;
    content: string;
    createdAt: Date;
    posttype: string;
    author: string;
    authorid: number;
    role: string;
    isUpnMember: boolean;
    profilePicture: string;
}