import { Post } from "@/class/post"

let drafts: Array<Post | null> = [];

export const getDrafts = (): Array<Post | null> => {
    return drafts;
};

export const addDraft = (post: Post): Array<Post | null> => {
    drafts.push(post)
    return drafts
}

export const removeDraft = (id: number) => {
    drafts[id] = null
}

export const modifyDraft = (id: number, post: Post): Array<Post | null> => {
    drafts[id] = post;
    return drafts
}