CREATE OR REPLACE PROCEDURE create_user_with_post_and_comment(
    p_email character varying,
    p_username character varying,
    p_name character varying,
    p_password character varying,
    p_post_title character varying,
    p_post_content text,
    p_comment_content text
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_user_id bigint;
    v_post_id bigint;
BEGIN
    -- Insert a new user into the users table
    INSERT INTO public.users (email, username, name, password)
    VALUES (p_email, p_username, p_name, p_password)
    RETURNING id INTO v_user_id;

    -- Insert a new post into the posts table
    INSERT INTO public.posts (title, content, author)
    VALUES (p_post_title, p_post_content, v_user_id)
    RETURNING id INTO v_post_id;

    -- Insert a new comment into the comments table
    INSERT INTO public.comments (author, content, posttype, postid)
    VALUES (v_user_id, p_comment_content, 'DISCUSSION', v_post_id);

EXCEPTION
    WHEN OTHERS THEN
        -- Raise the exception for rollback
        RAISE;
END;
$$;

CREATE OR REPLACE PROCEDURE create_user_with_posts_and_comments(
    p_email character varying,
    p_username character varying,
    p_name character varying,
    p_password character varying,
    p_post_titles text[],
    p_post_contents text[],
    p_comment_contents text[]
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_user_id bigint;
    v_post_id bigint;
    i integer;
BEGIN
    INSERT INTO public.users (email, username, name, password)
    VALUES (p_email, p_username, p_name, p_password)
    RETURNING id INTO v_user_id;

    FOR i IN 1..array_length(p_post_titles, 1) LOOP
        INSERT INTO public.posts (title, content, author)
        VALUES (p_post_titles[i], p_post_contents[i], v_user_id)
        RETURNING id INTO v_post_id;

        CASE
            WHEN p_comment_contents[i] IS NOT NULL THEN
                INSERT INTO public.comments (author, content, posttype, postid)
                VALUES (v_user_id, p_comment_contents[i], 'DISCUSSION', v_post_id);
            ELSE
                RAISE NOTICE 'No comment provided for post %', v_post_id;
        END CASE;
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error occurred during user, posts, and comments creation: %', SQLERRM;
END;
$$;


CALL create_user_with_posts_and_comments(
    'user2@example.com',
    'user2name',
    'User Name',
    'securepassword',
    ARRAY['Post Title 1', 'Post Title 2'],
    ARRAY['This is the content of post 1.', 'This is the content of post 2.'],
    ARRAY['This is a comment on post 1.', 'This is a comment on post 2.']
);

SELECT posts.id, posts.title, posts.content, users.id, users.name, users.email 
FROM posts JOIN users ON posts.author = users.id WHERE posts.id > 23;


CREATE OR REPLACE FUNCTION create_user_post_comment(
    p_email character varying,
    p_username character varying,
    p_name character varying,
    p_password character varying,
    p_post_title character varying,
    p_post_content text,
    p_comment_content text
)
RETURNS json AS $$
DECLARE
    v_user_id bigint;
    v_post_id bigint;
    v_comment_id bigint;
BEGIN
    INSERT INTO public.users (email, username, name, password)
    VALUES (p_email, p_username, p_name, p_password)
    RETURNING id INTO v_user_id;

    INSERT INTO public.posts (title, content, author)
    VALUES (p_post_title, p_post_content, v_user_id)
    RETURNING id INTO v_post_id;

    INSERT INTO public.comments (author, content, posttype, postid)
    VALUES (v_user_id, p_comment_content, 'DISCUSSION', v_post_id)
    RETURNING id INTO v_comment_id;

    RETURN json_build_object(
        'user_id', v_user_id,
        'post_id', v_post_id,
        'comment_id', v_comment_id
    );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error occurred during user, post, and comment creation: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;

SELECT create_user_post_comment(
    'jamal@upni.com',
    'Jamal123',
    'Jamalludin',
    'fa73338e4a7d529ad8ed3da7d4a6282a73da775117ed4b52d294a580a0d57964',
    'Test post',
    'Test content.',
    'Test Comment.'
);

CREATE OR REPLACE PROCEDURE update_user_profile_pictures(new_profile_picture character varying)
LANGUAGE plpgsql
AS $$
DECLARE
    user_cursor CURSOR FOR
        SELECT id FROM public.users
        WHERE profile_picture = 
'https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/default_avatar.svg?t=2024-03-18T06%3A44%3A56.263Z';
    v_user_id bigint;
BEGIN
    OPEN user_cursor;

    LOOP
        FETCH user_cursor INTO v_user_id;
        EXIT WHEN NOT FOUND;
        UPDATE public.users
        SET profile_picture = new_profile_picture
        WHERE id = v_user_id;
    END LOOP;

    CLOSE user_cursor;

    RAISE NOTICE 'User profile pictures updated successfully.';
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error occurred while updating profile pictures: %', SQLERRM;
        CLOSE user_cursor;
END;
$$;

CALL update_user_profile_pictures('https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/1-2024526103650-avatar.png');

SELECT id FROM users WHERE profile_picture = 'https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/default_avatar.svg?t=2024-03-18T06%3A44%3A56.263Z';

SELECT id, name, profile_picture
FROM public.users
WHERE id IN (5, 4, 18, 20, 6, 10, 3, 11, 23, 24);
