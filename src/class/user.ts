export type ServerUser = {
    id: number;
    email: string;
    username: string;
    name: string;
    password: string;
    is_upn_member: boolean;
    profile_picture: string;
    created_at: Date;
    role: string;
}

export type User = {
    id: number;
    email: string;
    username: string;
    name: string;
    isUpnMember: boolean;
    profilePicture: string;
    createdAt: Date;
    role: string;
    exp: number;
    iat: number;
}

export const defaultUser = {
    id: 0,
    email: "user@mail.com",
    username: "2312345678",
    name: "Mahasiswa UPN",
    isUpnMember: true,
    profilePicture: "https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/default_avatar.svg?t=2024-03-18T06%3A44%3A56.263Z",
    createdAt: new Date(),
    role: "USER",
    exp: 0,
    iat: 0
}
