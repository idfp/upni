--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg20.04+1)
-- Dumped by pg_dump version 16.2

-- Started on 2024-06-10 10:11:41

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 20 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3856 (class 0 OID 0)
-- Dependencies: 20
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 1207 (class 1247 OID 29360)
-- Name: postType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."postType" AS ENUM (
    'DISCUSSION',
    'NEWS',
    'PODCAST'
);


ALTER TYPE public."postType" OWNER TO postgres;

--
-- TOC entry 514 (class 1255 OID 29415)
-- Name: addcomment(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.addcomment() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.postType = 'PODCAST' THEN
        UPDATE podcasts
        SET comments = comments + 1
        WHERE id = NEW.podcastId;
    ELSE
        UPDATE posts
        SET comments = comments + 1
        WHERE id = NEW.postId;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.addcomment() OWNER TO postgres;

--
-- TOC entry 515 (class 1255 OID 29416)
-- Name: checkpermission(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.checkpermission() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    userrole VARCHAR;
BEGIN
    SELECT role INTO userrole FROM users WHERE id = NEW.author;
    IF userrole = 'USER' THEN
        RAISE EXCEPTION 'Insufficient Permission' ;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.checkpermission() OWNER TO postgres;

--
-- TOC entry 516 (class 1255 OID 29417)
-- Name: create_user_post_comment(character varying, character varying, character varying, character varying, character varying, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_user_post_comment(p_email character varying, p_username character varying, p_name character varying, p_password character varying, p_post_title character varying, p_post_content text, p_comment_content text) RETURNS json
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.create_user_post_comment(p_email character varying, p_username character varying, p_name character varying, p_password character varying, p_post_title character varying, p_post_content text, p_comment_content text) OWNER TO postgres;

--
-- TOC entry 517 (class 1255 OID 29418)
-- Name: create_user_with_post_and_comment(character varying, character varying, character varying, character varying, character varying, text, text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.create_user_with_post_and_comment(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_title character varying, IN p_post_content text, IN p_comment_content text)
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


ALTER PROCEDURE public.create_user_with_post_and_comment(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_title character varying, IN p_post_content text, IN p_comment_content text) OWNER TO postgres;

--
-- TOC entry 518 (class 1255 OID 29419)
-- Name: create_user_with_posts_and_comments(character varying, character varying, character varying, character varying, text[], text[], text[]); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.create_user_with_posts_and_comments(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_titles text[], IN p_post_contents text[], IN p_comment_contents text[])
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


ALTER PROCEDURE public.create_user_with_posts_and_comments(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_titles text[], IN p_post_contents text[], IN p_comment_contents text[]) OWNER TO postgres;

--
-- TOC entry 519 (class 1255 OID 29420)
-- Name: delcomment(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delcomment() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF OLD.postType = 'PODCAST' THEN
        UPDATE podcasts
        SET comments = comments - 1
        WHERE id = OLD.podcastId;
    ELSE
        UPDATE posts
        SET comments = comments - 1
        WHERE id = OLD.postId;
    END IF;
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.delcomment() OWNER TO postgres;

--
-- TOC entry 548 (class 1255 OID 30024)
-- Name: get_posts_by_author(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_posts_by_author(author_id bigint) RETURNS TABLE(post_id bigint, title character varying, content text, likes bigint, comments bigint, created_at timestamp with time zone, category public."postType")
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.id AS post_id,
        p.title,
        p.content,
        p.likes,
        p.comments,
        p.created_at,
        p.category
    FROM
        public.posts p
    WHERE
        p.author = author_id;
END;
$$;


ALTER FUNCTION public.get_posts_by_author(author_id bigint) OWNER TO postgres;

--
-- TOC entry 549 (class 1255 OID 30025)
-- Name: print_comments_for_post(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.print_comments_for_post(post_id bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    comment_cursor CURSOR FOR
    SELECT content FROM public.comments WHERE postid = post_id;
    comment_record RECORD;
BEGIN
    OPEN comment_cursor;
    
    LOOP
        FETCH comment_cursor INTO comment_record;
        EXIT WHEN NOT FOUND;
        
        RAISE NOTICE 'Comment: %', comment_record.content;
    END LOOP;
    
    CLOSE comment_cursor;
END;
$$;


ALTER FUNCTION public.print_comments_for_post(post_id bigint) OWNER TO postgres;

--
-- TOC entry 520 (class 1255 OID 29421)
-- Name: update_comment_type(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_comment_type() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.postid IS NOT NULL AND OLD.postid IS NULL THEN
        NEW.podcastid = NULL;
        NEW.posttype = 'DISCUSSION';
    END IF;

    IF NEW.podcastid IS NOT NULL AND OLD.podcastid IS NULL THEN
        NEW.postid = NULL;
        NEW.posttype = 'PODCAST';
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_comment_type() OWNER TO postgres;

--
-- TOC entry 521 (class 1255 OID 29422)
-- Name: update_user_profile_pictures(character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.update_user_profile_pictures(IN new_profile_picture character varying)
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


ALTER PROCEDURE public.update_user_profile_pictures(IN new_profile_picture character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 268 (class 1259 OID 29544)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying NOT NULL,
    username character varying,
    name character varying,
    password character varying,
    is_upn_member boolean DEFAULT false NOT NULL,
    profile_picture character varying DEFAULT 'https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/default_avatar.svg?t=2024-03-18T06%3A44%3A56.263Z'::character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    followed_authors json DEFAULT '[]'::json,
    role character varying DEFAULT 'user'::character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 29554)
-- Name: admins; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.admins AS
 SELECT users.id,
    users.email,
    users.username,
    users.name,
    users.password,
    users.is_upn_member,
    users.profile_picture,
    users.created_at,
    users.followed_authors,
    users.role
   FROM public.users
  WHERE (((users.role)::text = 'USERADMIN'::text) OR ((users.role)::text = 'ITADMIN'::text));


ALTER VIEW public.admins OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 29558)
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    author bigint,
    content text,
    posttype public."postType",
    postid bigint,
    created_at timestamp with time zone DEFAULT now(),
    podcastid bigint
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 29564)
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.comments ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 272 (class 1259 OID 29565)
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    id bigint NOT NULL,
    title character varying,
    content text,
    author bigint,
    pictures text DEFAULT '[]'::text,
    likes bigint DEFAULT '0'::bigint,
    comments bigint DEFAULT '0'::bigint,
    views bigint DEFAULT '0'::bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    category public."postType"
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 29575)
-- Name: discussions; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.discussions AS
 SELECT posts.id,
    posts.title,
    posts.content,
    posts.author,
    posts.pictures,
    posts.likes,
    posts.comments,
    posts.views,
    posts.created_at,
    posts.category
   FROM public.posts
  WHERE (posts.category = 'DISCUSSION'::public."postType");


ALTER VIEW public.discussions OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 29579)
-- Name: news; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.news AS
 SELECT posts.id,
    posts.title,
    posts.content,
    posts.author,
    posts.pictures,
    posts.likes,
    posts.comments,
    posts.views,
    posts.created_at,
    posts.category
   FROM public.posts
  WHERE (posts.category = 'NEWS'::public."postType");


ALTER VIEW public.news OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 29583)
-- Name: podcasts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.podcasts (
    id bigint NOT NULL,
    title character varying,
    author bigint,
    thumbnail character varying,
    duration bigint DEFAULT '0'::bigint,
    views bigint DEFAULT '0'::bigint,
    likes bigint DEFAULT '0'::bigint,
    comments bigint DEFAULT '0'::bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    url text
);


ALTER TABLE public.podcasts OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 29593)
-- Name: podcasts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.podcasts ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.podcasts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 277 (class 1259 OID 29594)
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.posts ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 278 (class 1259 OID 29595)
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settings (
    id bigint NOT NULL,
    userid bigint,
    settings json,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 29601)
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.settings ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 280 (class 1259 OID 29602)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3842 (class 0 OID 29558)
-- Dependencies: 270
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, author, content, posttype, postid, created_at, podcastid) FROM stdin;
3	5	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	DISCUSSION	4	2024-03-30 14:59:15.986266+00	\N
4	5	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.	DISCUSSION	3	2024-03-30 15:12:05.566933+00	\N
5	5	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.	NEWS	1	2024-03-30 15:12:27.805309+00	\N
13	1	Permadi muliadi	NEWS	5	2024-04-16 11:44:46.318704+00	\N
20	1	aasdasdasd	NEWS	3	2024-05-12 04:44:51.787553+00	\N
21	1	lkamsdlkamsdlkmasldkmalskdmalkmsdlkasmdlkamsldkmaslkdmalksdmlakmsdlkasmdlkamsdlkamsldkmalskdmlaksmdlkamsldkamsldkmalskdmalksdmlaksmdl	NEWS	3	2024-05-12 05:15:45.684831+00	\N
22	1	asdasdasdasdasd	NEWS	5	2024-05-12 09:45:53.012658+00	\N
2	4	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	PODCAST	2	2024-03-30 14:58:42.654021+00	6
26	1	test comment	PODCAST	\N	2024-05-21 13:27:17.778712+00	6
27	1	woiaosidaosidjaoisdjoaisjdoaisdj	PODCAST	\N	2024-05-21 14:35:25.376154+00	6
25	1	Sangat bermanfaat!	NEWS	9	2024-05-16 03:53:08.100809+00	\N
28	1	Fendi dimana	PODCAST	\N	2024-05-21 14:40:19.027236+00	6
29	1	Lorem ipsum	PODCAST	\N	2024-05-21 14:44:52.212857+00	5
30	1	Lorem ipsum	PODCAST	\N	2024-05-21 14:45:01.250909+00	5
14	1	alskdmalksmdlaksmdlakmsd	NEWS	5	2024-04-18 00:33:12.12124+00	\N
19	1	akmsldkamsldkmasldkmasd	NEWS	3	2024-05-12 04:39:35.920447+00	\N
11	1	klamsdklasmdlkamsdklas	NEWS	1	2024-04-16 11:43:21.586673+00	\N
10	1	alskdmlaksmdlakmsdlkamsd	NEWS	2	2024-04-16 09:32:48.214047+00	\N
31	6	keren bgt\n	NEWS	5	2024-05-23 04:37:36.002687+00	\N
33	6	ssaa	NEWS	9	2024-05-25 03:04:45.370621+00	\N
34	6	shshshs	PODCAST	\N	2024-05-25 03:05:40.302696+00	5
35	6	sttsa	NEWS	9	2024-05-25 03:08:01.809114+00	\N
36	6	ahahah	NEWS	9	2024-05-26 05:12:54.318122+00	\N
37	6	tes\n	NEWS	5	2024-05-26 05:13:32.130728+00	\N
38	6	test	PODCAST	\N	2024-05-26 05:13:51.218107+00	5
39	1	tesss	NEWS	8	2024-05-28 11:53:23.094563+00	\N
41	1	test 1 (Contoh)	PODCAST	\N	2024-05-28 16:56:25.043343+00	1
42	1	test 1 (Contoh)	PODCAST	\N	2024-05-28 17:10:02.845312+00	1
1	4	Contoh Komen baru	NEWS	1	2024-03-30 14:58:21.329765+00	\N
44	1	test 1 (Contoh)	DISCUSSION	2	2024-05-29 00:07:20.334114+00	\N
43	1	test 1 (Contoh)	DISCUSSION	3	2024-05-28 17:10:58.985193+00	\N
\.


--
-- TOC entry 3845 (class 0 OID 29583)
-- Dependencies: 275
-- Data for Name: podcasts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.podcasts (id, title, author, thumbnail, duration, views, likes, comments, created_at, url) FROM stdin;
2	Review Project UI Design Mobile dari pada Androider	3	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/original-a3c7656c746c207995eba8db27460e1c.png	620	152	24	2	2024-03-30 15:05:37.347651+00	\N
3	String 2 - Persiapan UTS Statistika dan Probabilitas	3	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/maxresdefault%20(1).jpg	780	189	15	4	2024-03-30 15:06:25.969332+00	\N
4	Announcement Hasil Rapat BEM-FIK Mei 2024	2	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/WhatsApp-Image-2023-11-19-at-15.10.36.jpeg	720	362	39	12	2024-05-20 13:58:11.3241+00	\N
5	Campus Tour UPN Veteran Jakarta 2024	1	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/maxresdefault%20(2).jpg	375	1280	236	60	2024-05-21 03:09:28.834682+00	https://firebasestorage.googleapis.com/v0/b/dot-sh.appspot.com/o/PETUALANGAN%20MENGENAL%20PROGRAM%20STUDI%20DI%20UPN%20_VETERAN_%20JAKARTA.mp4?alt=media&token=771e8988-e77a-444b-ab8c-23152ebae837
6	String 3 - Persiapan UAS Interaksi Manusia dan Komputer	2	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/BlogWhat-is-Userflow-in-UX-Design_.jpg	924	367	30	12	2024-05-21 04:51:03.25303+00	\N
1	String 1 - Persiapan UTS Struktur Data dan Algoritma	3	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/maxresdefault.jpg	993	321	104	27	2024-03-30 15:04:41.095671+00	\N
\.


--
-- TOC entry 3844 (class 0 OID 29565)
-- Dependencies: 272
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, title, content, author, pictures, likes, comments, views, created_at, category) FROM stdin;
3	Menyongsong Bulan Suci Ramadan: Bagaimana Kontribusi Mahasiswa Dalam Berbagi Takjil?	Dekatnya bulan Ramadan seringkali diwarnai dengan berbagai aksi kebaikan, salah satunya adalah pembagian takjil gratis. Namun, seberapa besar kontribusi mahasiswa dalam berbagi takjil? Mari kita diskusikan pengalaman dan pandangan Anda tentang peran mahasiswa dalam menyongsong Ramadan dengan berbagi kebahagiaan melalui takjil. Apakah Anda merasa tergerak untuk turut berpartisipasi dalam kegiatan semacam ini? Bagikan cerita Anda atau berikan pandangan tentang pentingnya berbagi dalam semangat Ramadan.	4	["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/eJDhv5G09z.jpg", "https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/eJDhv5G09z.jpg"]	41	15	204	2024-03-30 14:56:29+00	DISCUSSION
4	Menggali Potensi Mahasiswa: Apakah Anda Percaya Bahwa Kemampuan Pemrograman Dapat Menjadi Kunci Kemenangan?\r\n	Prestasi tim KSM Android dalam memenangkan perlombaan ICPC mengundang pertanyaan menarik: apakah Anda percaya bahwa kemampuan pemrograman dapat menjadi kunci utama untuk meraih kemenangan dalam berbagai kompetisi? Mari kita bahas bersama! Apakah Anda yakin bahwa kemampuan teknis seperti pemrograman memegang peranan penting dalam kesuksesan akademik dan profesional? Ataukah Anda memiliki pandangan lain? Bagikan pemikiran dan pengalaman Anda dalam diskusi ini.	4	["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/5e97c962dd1dc.jpg","https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/5e97c962dd1dc.jpg","https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/5e97c962dd1dc.jpg"]	34	9	238	2024-03-30 14:57:51+00	DISCUSSION
7	Peluncuran Program Beasiswa "Mendaki Cerdas" oleh UPN "Veteran" Jakarta	<p>UPN "Veteran" Jakarta dengan bangga meluncurkan Program Beasiswa "Mendaki Cerdas" sebagai bentuk komitmen universitas dalam mendukung akses pendidikan tinggi bagi masyarakat kurang mampu. Program ini bertujuan untuk memberikan kesempatan kepada siswa berprestasi dari latar belakang ekonomi yang terbatas untuk mengejar mimpi pendidikan mereka.</p>\n<p>Program Beasiswa "Mendaki Cerdas" menawarkan bantuan keuangan penuh, termasuk biaya kuliah, biaya hidup, dan bantuan buku bagi siswa yang terpilih. Selain itu, program ini juga menyediakan berbagai program pendukung, seperti bimbingan akademik, pelatihan keterampilan, dan mentoring, untuk membantu siswa meraih kesuksesan akademik dan profesional.</p>\n<p>UPN "Veteran" Jakarta mengundang para siswa berprestasi yang berasal dari keluarga kurang mampu untuk mendaftar dan mengikuti proses seleksi Program Beasiswa "Mendaki Cerdas". Universitas ini berharap bahwa program ini dapat memberikan kontribusi yang signifikan dalam meningkatkan akses pendidikan tinggi bagi generasi muda Indonesia.</p>\n<p>Dengan diluncurkannya Program Beasiswa "Mendaki Cerdas", UPN "Veteran" Jakarta berkomitmen untuk terus menjadi agen perubahan positif dalam membantu mewujudkan impian pendidikan setiap individu, tanpa memandang latar belakang ekonomi.</p>\n	1	["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/mahasiswa-upn-veteran-jakarta-meminta-penjelasan-rektorat-fo-bcn5.jpg"]	33	16	410	2024-05-10 01:31:01.777296+00	NEWS
1	Gebyar Ramadan : Takjil Gratis kepada mahasiswa Fakultas Ilmu Komputer UPNVJ	UPN Veteran Jakarta menggelar acara Gebyar Ramadan dengan menyediakan takjil gratis bagi mahasiswa Fakultas Ilmu Komputer. Acara yang bertujuan untuk mempererat silaturahim di bulan suci Ramadan ini dihadiri oleh ratusan mahasiswa yang antusias menyambut berkah bulan suci. Takjil gratis yang disediakan tidak hanya menjadi sajian lezat bagi mahasiswa, tetapi juga menjadi momen untuk berbagi kebahagiaan dan kebersamaan di tengah kesibukan akademik. Dengan adanya acara Gebyar Ramadan ini, diharapkan dapat meningkatkan kebersamaan dan kepedulian antar-mahasiswa serta memperkuat ikatan kekeluargaan di lingkungan Fakultas Ilmu Komputer UPNVJ.	3	["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/upn-veteran-jakarta-gandeng-asosiasi-pengusaha-hutan-indonesia-K1uFsneCAx.jpeg"]	40	3	86	2024-03-30 14:52:30.214755+00	NEWS
5	Memperluas Horison: Bagaimana Kolaborasi Antar Fakultas Dapat Mendorong Prestasi Akademik?	Prestasi tim debat UPNVJ dalam kompetisi nasional menyoroti pentingnya kolaborasi antar fakultas dalam mencapai keunggulan akademik. Bagaimana pandangan Anda tentang pentingnya kolaborasi lintas fakultas dalam mengembangkan potensi mahasiswa? Apakah Anda berpikir bahwa kerjasama antarbidang studi dapat menghasilkan ide-ide inovatif dan prestasi akademik yang lebih baik? Mari kita eksplorasi bersama bagaimana kerjasama antar fakultas dapat menjadi kunci untuk mencapai keunggulan di tingkat universitas. Bagikan pandangan dan pengalaman Anda dalam diskusi ini.\n	4	["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/DSC_1174.jpg","https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/DSC_1174.jpg","https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/DSC_1174.jpg","https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/DSC_1174.jpg"]	146	28	353	2024-03-30 15:08:07.260712+00	DISCUSSION
2	KSM Android memenangkan perlombaan ICPC	Keberhasilan gemilang diraih oleh tim KSM Android dari UPN Veteran Jakarta yang berhasil memenangkan perlombaan International Collegiate Programming Contest (ICPC). Dengan kemampuan pemrograman yang luar biasa, tim KSM Android berhasil menyelesaikan serangkaian tantangan pemrograman yang kompleks dan berhasil menjadi yang terbaik di antara ratusan tim peserta dari berbagai negara. Kemenangan ini tidak hanya menjadi kebanggaan bagi UPNVJ tetapi juga membuktikan bahwa mahasiswa-mahasiswa di universitas tersebut memiliki potensi dan kemampuan yang mumpuni dalam bidang teknologi informasi. Diharapkan prestasi ini akan menjadi inspirasi bagi mahasiswa-mahasiswa lainnya untuk terus berprestasi dan mengharumkan nama baik universitas.	3	["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/DSC_1253%20(2).jpg"]	40	11	317	2024-03-30 14:56:42.848474+00	NEWS
9	Workshop Kewirausahaan dan Inovasi di UPN "Veteran" Jakarta 2024	<p>UPN "Veteran" Jakarta mengadakan Workshop Kewirausahaan dan Inovasi sebagai bagian dari upaya universitas dalam membantu mahasiswa mengembangkan keterampilan kewirausahaan dan membangun jiwa inovasi. Workshop ini dirancang untuk memberikan pengetahuan dan wawasan praktis tentang proses memulai dan menjalankan bisnis yang sukses.</p>\n<p>Workshop ini menghadirkan para pembicara terkemuka dari berbagai industri yang berbagi pengalaman dan tips praktis tentang kewirausahaan, inovasi, dan pengembangan bisnis. Para peserta workshop diajak untuk terlibat dalam sesi diskusi, studi kasus, dan permainan peran yang dirancang untuk meningkatkan pemahaman dan keterampilan mereka dalam kewirausahaan.</p>\n<p>UPN "Veteran" Jakarta berharap bahwa workshop ini dapat menjadi platform yang bermanfaat bagi mahasiswa untuk mengembangkan potensi kewirausahaan mereka, memperluas jaringan profesional, dan menciptakan solusi inovatif yang dapat memberikan dampak positif bagi masyarakat.</p>\n<p>Dengan meningkatkan kesadaran dan keterampilan kewirausahaan di kalangan mahasiswa, UPN "Veteran" Jakarta percaya bahwa mereka dapat menjadi agen perubahan yang positif dalam menciptakan lapangan kerja, mendorong pertumbuhan ekonomi, dan membangun masa depan yang lebih baik bagi bangsa dan negara. Sekian terimakasih.</p>	1	["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/fisip-upn-veteran-jakarta-gelar-seminar-internasional-1_169.jpeg"]	40	23	330	2024-05-10 01:34:10.239207+00	NEWS
6	Seminar Internasional tentang Pembangunan Berkelanjutan di UPN "Veteran" Jakarta	<p>UPN "Veteran" Jakarta menyelenggarakan Seminar Internasional tentang Pembangunan Berkelanjutan sebagai bagian dari upaya universitas dalam memperluas wawasan akademik dan berkontribusi pada pembangunan berkelanjutan di Indonesia. Seminar ini dihadiri oleh para akademisi, praktisi, dan mahasiswa dari berbagai negara untuk berbagi pengetahuan, pengalaman, dan ide-ide inovatif dalam pembangunan berkelanjutan.</p>\n<p>Seminar ini menghadirkan berbagai topik menarik, mulai dari pengelolaan lingkungan, energi terbarukan, hingga pengembangan masyarakat yang berkelanjutan. Para pembicara terkemuka dari dalam dan luar negeri memberikan paparan tentang tren terkini, tantangan, dan solusi dalam pembangunan berkelanjutan.</p>\n<p>Selain itu, dalam seminar ini juga dilakukan diskusi panel yang melibatkan peserta untuk berbagi pandangan dan pemikiran mereka tentang isu-isu penting dalam pembangunan berkelanjutan. Diskusi ini memberikan kesempatan bagi semua peserta untuk berkontribusi secara aktif dalam merumuskan solusi yang dapat diimplementasikan di lapangan.</p>\n<p>UPN "Veteran" Jakarta berharap bahwa seminar ini dapat menjadi ajang inspirasi dan kolaborasi bagi semua pihak yang peduli terhadap pembangunan berkelanjutan. Dengan demikian, universitas ini terus berkomitmen untuk menjadi agen perubahan yang positif dalam memajukan pembangunan berkelanjutan di Indonesia.</p>\n<p>Seminar Internasional tentang Pembangunan Berkelanjutan di UPN "Veteran" Jakarta diharapkan dapat memberikan kontribusi nyata dalam upaya mewujudkan masa depan yang lebih baik bagi generasi mendatang.</p>	3	["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/DSC_47421.jpg"]	27	12	229	2024-05-10 01:23:23.560708+00	NEWS
8	Penghargaan Prestasi Akademik Tertinggi bagi Mahasiswa UPN "Veteran" Jakarta	<p>UPN "Veteran" Jakarta merayakan keberhasilan prestasi akademik tertinggi dari sejumlah mahasiswa yang telah menunjukkan dedikasi dan kerja kerasnya dalam mengejar keunggulan akademik. Penghargaan ini diberikan kepada mahasiswa yang berhasil meraih prestasi gemilang dalam studi mereka di berbagai bidang.</p>\n<p>Penghargaan ini meliputi berbagai kategori, termasuk prestasi akademik terbaik, penelitian terbaik, karya tulis ilmiah terbaik, dan proyek-proyek inovatif lainnya yang memberikan kontribusi positif bagi masyarakat dan lingkungan.</p>\n<p>Para penerima penghargaan ini tidak hanya diakui atas keunggulan akademik mereka, tetapi juga atas dedikasi mereka dalam melayani dan memberikan dampak positif bagi lingkungan sekitar. UPN "Veteran" Jakarta bangga memiliki mahasiswa-mahasiswa yang berkomitmen untuk berkontribusi pada pembangunan berkelanjutan dan perubahan sosial yang positif.</p>\n<p>Dengan memberikan penghargaan ini, UPN "Veteran" Jakarta berharap dapat memberikan dorongan motivasi tambahan bagi mahasiswa untuk terus mengejar keunggulan dalam studi mereka dan menginspirasi generasi mendatang untuk mengejar impian mereka.</p>	1	["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/PKS-dengan-UPN-Veteran-3.jpg"]	46	25	473	2024-05-10 01:32:31.137373+00	NEWS
21		<p>test</p>	6	[]	0	0	0	2024-05-26 05:13:17.507958+00	DISCUSSION
\.


--
-- TOC entry 3848 (class 0 OID 29595)
-- Dependencies: 278
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (id, userid, settings, created_at) FROM stdin;
6	10	{}	2024-05-23 04:22:28.835024+00
7	6	{}	2024-05-23 04:36:43.898363+00
3	1	{"postLikes":[4,3,10,15,9,17,18],"podcastLikes":["6"]}	2024-04-17 02:32:47.310976+00
4	2	{"postLikes":["5",9],"podcastLikes":[]}	2024-04-19 06:26:18.864043+00
8	25	{}	2024-05-29 19:24:45.792431+00
5	3	{"postLikes":[]}	2024-05-22 03:20:22.932059+00
\.


--
-- TOC entry 3841 (class 0 OID 29544)
-- Dependencies: 268
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, username, name, password, is_upn_member, profile_picture, created_at, followed_authors, role) FROM stdin;
2	2310512108@mahasiswa.upnvj.ac.id	2310512108	Vega Setiawan	8e8ac773c4f71f51ae13e6bb80b05b62c06eedfe5bf1569270f69f644bda2cdd	t	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/2-2024419132711-avatar.png	2024-03-30 14:38:50.424619+00	[]	ITADMIN
1	2310512113@mahasiswa.upnvj.ac.id	2310512113	Ashja Radithya Lesmana	ca14e77dc4468941e8b8e1a9960a54444815ae6d25d605145119eb22882e3522	t	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/1-2024526103650-avatar.png	2024-03-30 14:36:01+00	[]	ITADMIN
5	kitun330@gmail.com	kitun	Kitun Sincaka	3ab1dfe18f030f2998d3cfd7d2bc7e5768b7fac815010e78edb5e82285c011c1	f	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/1-2024526103650-avatar.png	2024-03-30 14:48:51.622928+00	[]	USER
4	suko002@gmail.com	2210512104	Suko Permadi	d793c5cb41bf56b6dd9a1a9e9e3b034f011594db76139b1fbc164743511fd03e	t	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/1-2024526103650-avatar.png	2024-03-30 14:46:05.196412+00	[]	USER
18	contoh123@gmail.com	contoh123	contohAsli	123	f	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/1-2024526103650-avatar.png	2024-05-29 04:01:18.593348+00	[]	USER
20	user@example.com	username	User Name	securepassword	f	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/1-2024526103650-avatar.png	2024-05-29 06:01:18.522245+00	[]	user
6	2310512119@mahasiswa.upnvj.ac.id	2310512119	Caleb Anthony Evan	47cab2786ba6c0573ba3e50d1d21cbce6c44e38912e39f31d601646095cee493	t	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/1-2024526103650-avatar.png	2024-05-22 02:59:28.265724+00	[]	USERADMIN
10	2310512102@mahasiswa.upnvj.ac.id	2310512102	Zahir Fakhri Achmad	3cdad5eda0be99fbbbfdabea12538aafdfaacd1c8b7fee4beced3ddfbd623525	t	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/1-2024526103650-avatar.png	2024-05-22 03:01:26.122267+00	[]	USERADMIN
3	2310512093@mahasiswa.upnvj.ac.id	2310512093	Fendi Permadi	3ce49067c0983cf32682a304a0585d617f2fef5a132d9d63a8b2320ae93ec4f3	t	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/1-2024526103650-avatar.png	2024-03-30 14:44:51.014422+00	[]	USERADMIN
11	zatinniqotaini@upnvj.ac.id	zatinniqotaini	Zatin Niqotaini	ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f	t	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/1-2024526103650-avatar.png	2024-05-23 04:21:44.406904+00	[]	USERADMIN
23	user2@example.com	user2name	User Name	securepassword	f	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/1-2024526103650-avatar.png	2024-05-29 06:13:40.411164+00	[]	user
24	jamal@upni.com	Jamal123	Jamalludin	fa73338e4a7d529ad8ed3da7d4a6282a73da775117ed4b52d294a580a0d57964	f	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/1-2024526103650-avatar.png	2024-05-29 06:20:52.892545+00	[]	user
25			\N	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855	f	https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/default_avatar.svg?t=2024-03-18T06%3A44%3A56.263Z	2024-05-29 19:24:31.992748+00	[]	USER
\.


--
-- TOC entry 3881 (class 0 OID 0)
-- Dependencies: 271
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 48, true);


--
-- TOC entry 3882 (class 0 OID 0)
-- Dependencies: 276
-- Name: podcasts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.podcasts_id_seq', 2, true);


--
-- TOC entry 3883 (class 0 OID 0)
-- Dependencies: 277
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 27, true);


--
-- TOC entry 3884 (class 0 OID 0)
-- Dependencies: 279
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settings_id_seq', 8, true);


--
-- TOC entry 3885 (class 0 OID 0)
-- Dependencies: 280
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 25, true);


--
-- TOC entry 3662 (class 2606 OID 29712)
-- Name: comments comments_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_id_key UNIQUE (id);


--
-- TOC entry 3664 (class 2606 OID 29714)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 3668 (class 2606 OID 29716)
-- Name: podcasts podcasts_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.podcasts
    ADD CONSTRAINT podcasts_id_key UNIQUE (id);


--
-- TOC entry 3670 (class 2606 OID 29718)
-- Name: podcasts podcasts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.podcasts
    ADD CONSTRAINT podcasts_pkey PRIMARY KEY (id);


--
-- TOC entry 3666 (class 2606 OID 29720)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 3672 (class 2606 OID 29722)
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- TOC entry 3658 (class 2606 OID 29724)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3660 (class 2606 OID 29726)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3679 (class 2620 OID 29796)
-- Name: comments commentsdelete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER commentsdelete AFTER DELETE ON public.comments FOR EACH ROW EXECUTE FUNCTION public.delcomment();


--
-- TOC entry 3680 (class 2620 OID 29797)
-- Name: comments commentsinsert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER commentsinsert AFTER INSERT ON public.comments FOR EACH ROW EXECUTE FUNCTION public.addcomment();


--
-- TOC entry 3682 (class 2620 OID 29798)
-- Name: podcasts insertpermission; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER insertpermission BEFORE INSERT ON public.podcasts FOR EACH ROW EXECUTE FUNCTION public.checkpermission();


--
-- TOC entry 3681 (class 2620 OID 29799)
-- Name: comments trg_update_comment_type; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_update_comment_type BEFORE UPDATE ON public.comments FOR EACH ROW EXECUTE FUNCTION public.update_comment_type();


--
-- TOC entry 3673 (class 2606 OID 29857)
-- Name: comments comments_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_author_fkey FOREIGN KEY (author) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3674 (class 2606 OID 29862)
-- Name: comments comments_podcastid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_podcastid_fkey FOREIGN KEY (podcastid) REFERENCES public.podcasts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3675 (class 2606 OID 29867)
-- Name: comments comments_postid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_postid_fkey FOREIGN KEY (postid) REFERENCES public.posts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3676 (class 2606 OID 29872)
-- Name: posts posts_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_author_fkey FOREIGN KEY (author) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3677 (class 2606 OID 29877)
-- Name: podcasts public_podcasts_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.podcasts
    ADD CONSTRAINT public_podcasts_author_fkey FOREIGN KEY (author) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3678 (class 2606 OID 29882)
-- Name: settings settings_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3836 (class 0 OID 29558)
-- Dependencies: 270
-- Name: comments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.comments ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3838 (class 0 OID 29583)
-- Dependencies: 275
-- Name: podcasts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.podcasts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3837 (class 0 OID 29565)
-- Dependencies: 272
-- Name: posts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3839 (class 0 OID 29595)
-- Dependencies: 278
-- Name: settings; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.settings ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3835 (class 0 OID 29544)
-- Dependencies: 268
-- Name: users; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3857 (class 0 OID 0)
-- Dependencies: 20
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 3858 (class 0 OID 0)
-- Dependencies: 514
-- Name: FUNCTION addcomment(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.addcomment() TO anon;
GRANT ALL ON FUNCTION public.addcomment() TO authenticated;
GRANT ALL ON FUNCTION public.addcomment() TO service_role;


--
-- TOC entry 3859 (class 0 OID 0)
-- Dependencies: 515
-- Name: FUNCTION checkpermission(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.checkpermission() TO anon;
GRANT ALL ON FUNCTION public.checkpermission() TO authenticated;
GRANT ALL ON FUNCTION public.checkpermission() TO service_role;


--
-- TOC entry 3860 (class 0 OID 0)
-- Dependencies: 516
-- Name: FUNCTION create_user_post_comment(p_email character varying, p_username character varying, p_name character varying, p_password character varying, p_post_title character varying, p_post_content text, p_comment_content text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.create_user_post_comment(p_email character varying, p_username character varying, p_name character varying, p_password character varying, p_post_title character varying, p_post_content text, p_comment_content text) TO anon;
GRANT ALL ON FUNCTION public.create_user_post_comment(p_email character varying, p_username character varying, p_name character varying, p_password character varying, p_post_title character varying, p_post_content text, p_comment_content text) TO authenticated;
GRANT ALL ON FUNCTION public.create_user_post_comment(p_email character varying, p_username character varying, p_name character varying, p_password character varying, p_post_title character varying, p_post_content text, p_comment_content text) TO service_role;


--
-- TOC entry 3861 (class 0 OID 0)
-- Dependencies: 517
-- Name: PROCEDURE create_user_with_post_and_comment(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_title character varying, IN p_post_content text, IN p_comment_content text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.create_user_with_post_and_comment(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_title character varying, IN p_post_content text, IN p_comment_content text) TO anon;
GRANT ALL ON PROCEDURE public.create_user_with_post_and_comment(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_title character varying, IN p_post_content text, IN p_comment_content text) TO authenticated;
GRANT ALL ON PROCEDURE public.create_user_with_post_and_comment(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_title character varying, IN p_post_content text, IN p_comment_content text) TO service_role;


--
-- TOC entry 3862 (class 0 OID 0)
-- Dependencies: 518
-- Name: PROCEDURE create_user_with_posts_and_comments(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_titles text[], IN p_post_contents text[], IN p_comment_contents text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.create_user_with_posts_and_comments(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_titles text[], IN p_post_contents text[], IN p_comment_contents text[]) TO anon;
GRANT ALL ON PROCEDURE public.create_user_with_posts_and_comments(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_titles text[], IN p_post_contents text[], IN p_comment_contents text[]) TO authenticated;
GRANT ALL ON PROCEDURE public.create_user_with_posts_and_comments(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_titles text[], IN p_post_contents text[], IN p_comment_contents text[]) TO service_role;


--
-- TOC entry 3863 (class 0 OID 0)
-- Dependencies: 519
-- Name: FUNCTION delcomment(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delcomment() TO anon;
GRANT ALL ON FUNCTION public.delcomment() TO authenticated;
GRANT ALL ON FUNCTION public.delcomment() TO service_role;


--
-- TOC entry 3864 (class 0 OID 0)
-- Dependencies: 548
-- Name: FUNCTION get_posts_by_author(author_id bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_posts_by_author(author_id bigint) TO anon;
GRANT ALL ON FUNCTION public.get_posts_by_author(author_id bigint) TO authenticated;
GRANT ALL ON FUNCTION public.get_posts_by_author(author_id bigint) TO service_role;


--
-- TOC entry 3865 (class 0 OID 0)
-- Dependencies: 549
-- Name: FUNCTION print_comments_for_post(post_id bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.print_comments_for_post(post_id bigint) TO anon;
GRANT ALL ON FUNCTION public.print_comments_for_post(post_id bigint) TO authenticated;
GRANT ALL ON FUNCTION public.print_comments_for_post(post_id bigint) TO service_role;


--
-- TOC entry 3866 (class 0 OID 0)
-- Dependencies: 520
-- Name: FUNCTION update_comment_type(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_comment_type() TO anon;
GRANT ALL ON FUNCTION public.update_comment_type() TO authenticated;
GRANT ALL ON FUNCTION public.update_comment_type() TO service_role;


--
-- TOC entry 3867 (class 0 OID 0)
-- Dependencies: 521
-- Name: PROCEDURE update_user_profile_pictures(IN new_profile_picture character varying); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.update_user_profile_pictures(IN new_profile_picture character varying) TO anon;
GRANT ALL ON PROCEDURE public.update_user_profile_pictures(IN new_profile_picture character varying) TO authenticated;
GRANT ALL ON PROCEDURE public.update_user_profile_pictures(IN new_profile_picture character varying) TO service_role;


--
-- TOC entry 3868 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO anon;
GRANT ALL ON TABLE public.users TO authenticated;
GRANT ALL ON TABLE public.users TO service_role;


--
-- TOC entry 3869 (class 0 OID 0)
-- Dependencies: 269
-- Name: TABLE admins; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.admins TO anon;
GRANT ALL ON TABLE public.admins TO authenticated;
GRANT ALL ON TABLE public.admins TO service_role;


--
-- TOC entry 3870 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE comments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.comments TO anon;
GRANT ALL ON TABLE public.comments TO authenticated;
GRANT ALL ON TABLE public.comments TO service_role;


--
-- TOC entry 3871 (class 0 OID 0)
-- Dependencies: 271
-- Name: SEQUENCE comments_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.comments_id_seq TO anon;
GRANT ALL ON SEQUENCE public.comments_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.comments_id_seq TO service_role;


--
-- TOC entry 3872 (class 0 OID 0)
-- Dependencies: 272
-- Name: TABLE posts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.posts TO anon;
GRANT ALL ON TABLE public.posts TO authenticated;
GRANT ALL ON TABLE public.posts TO service_role;


--
-- TOC entry 3873 (class 0 OID 0)
-- Dependencies: 273
-- Name: TABLE discussions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.discussions TO anon;
GRANT ALL ON TABLE public.discussions TO authenticated;
GRANT ALL ON TABLE public.discussions TO service_role;


--
-- TOC entry 3874 (class 0 OID 0)
-- Dependencies: 274
-- Name: TABLE news; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.news TO anon;
GRANT ALL ON TABLE public.news TO authenticated;
GRANT ALL ON TABLE public.news TO service_role;


--
-- TOC entry 3875 (class 0 OID 0)
-- Dependencies: 275
-- Name: TABLE podcasts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.podcasts TO anon;
GRANT ALL ON TABLE public.podcasts TO authenticated;
GRANT ALL ON TABLE public.podcasts TO service_role;


--
-- TOC entry 3876 (class 0 OID 0)
-- Dependencies: 276
-- Name: SEQUENCE podcasts_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.podcasts_id_seq TO anon;
GRANT ALL ON SEQUENCE public.podcasts_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.podcasts_id_seq TO service_role;


--
-- TOC entry 3877 (class 0 OID 0)
-- Dependencies: 277
-- Name: SEQUENCE posts_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.posts_id_seq TO anon;
GRANT ALL ON SEQUENCE public.posts_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.posts_id_seq TO service_role;


--
-- TOC entry 3878 (class 0 OID 0)
-- Dependencies: 278
-- Name: TABLE settings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.settings TO anon;
GRANT ALL ON TABLE public.settings TO authenticated;
GRANT ALL ON TABLE public.settings TO service_role;


--
-- TOC entry 3879 (class 0 OID 0)
-- Dependencies: 279
-- Name: SEQUENCE settings_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.settings_id_seq TO anon;
GRANT ALL ON SEQUENCE public.settings_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.settings_id_seq TO service_role;


--
-- TOC entry 3880 (class 0 OID 0)
-- Dependencies: 280
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.users_id_seq TO anon;
GRANT ALL ON SEQUENCE public.users_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.users_id_seq TO service_role;


--
-- TOC entry 2505 (class 826 OID 29940)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2508 (class 826 OID 29941)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2510 (class 826 OID 29942)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2511 (class 826 OID 29943)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2512 (class 826 OID 29944)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2514 (class 826 OID 29945)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


-- Completed on 2024-06-10 10:11:43

--
-- PostgreSQL database dump complete
--

