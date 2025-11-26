--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg20.04+1)
-- Dumped by pg_dump version 16.2

-- Started on 2024-06-10 08:33:36
-- c3Af?cupuBxJyVZ
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
-- TOC entry 12 (class 2615 OID 28886)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- TOC entry 21 (class 2615 OID 28887)
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- TOC entry 19 (class 2615 OID 28888)
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- TOC entry 18 (class 2615 OID 28889)
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- TOC entry 13 (class 2615 OID 28890)
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- TOC entry 15 (class 2615 OID 28891)
-- Name: pgsodium; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA pgsodium;


ALTER SCHEMA pgsodium OWNER TO supabase_admin;

--
-- TOC entry 2 (class 3079 OID 28892)
-- Name: pgsodium; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgsodium WITH SCHEMA pgsodium;


--
-- TOC entry 4154 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgsodium; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgsodium IS 'Pgsodium is a modern cryptography library for Postgres.';


--
-- TOC entry 14 (class 2615 OID 29193)
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- TOC entry 22 (class 2615 OID 29194)
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- TOC entry 17 (class 2615 OID 29195)
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- TOC entry 4 (class 3079 OID 29991)
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- TOC entry 4158 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- TOC entry 8 (class 3079 OID 29206)
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- TOC entry 4159 (class 0 OID 0)
-- Dependencies: 8
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- TOC entry 7 (class 3079 OID 29237)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- TOC entry 4160 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 6 (class 3079 OID 29274)
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- TOC entry 4161 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- TOC entry 3 (class 3079 OID 29281)
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- TOC entry 4162 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- TOC entry 5 (class 3079 OID 29309)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- TOC entry 4163 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 1213 (class 1247 OID 29321)
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- TOC entry 1216 (class 1247 OID 29328)
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- TOC entry 1219 (class 1247 OID 29334)
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- TOC entry 1222 (class 1247 OID 29340)
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1225 (class 1247 OID 29346)
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1228 (class 1247 OID 29360)
-- Name: postType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."postType" AS ENUM (
    'DISCUSSION',
    'NEWS',
    'PODCAST'
);


ALTER TYPE public."postType" OWNER TO postgres;

--
-- TOC entry 1231 (class 1247 OID 29368)
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- TOC entry 1234 (class 1247 OID 29380)
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- TOC entry 1237 (class 1247 OID 29397)
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- TOC entry 1240 (class 1247 OID 29400)
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- TOC entry 1243 (class 1247 OID 29403)
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- TOC entry 503 (class 1255 OID 29404)
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- TOC entry 4164 (class 0 OID 0)
-- Dependencies: 503
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- TOC entry 504 (class 1255 OID 29405)
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- TOC entry 505 (class 1255 OID 29406)
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- TOC entry 4167 (class 0 OID 0)
-- Dependencies: 505
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- TOC entry 506 (class 1255 OID 29407)
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- TOC entry 4169 (class 0 OID 0)
-- Dependencies: 506
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- TOC entry 507 (class 1255 OID 29408)
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO postgres;

--
-- TOC entry 4186 (class 0 OID 0)
-- Dependencies: 507
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- TOC entry 508 (class 1255 OID 29409)
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- TOC entry 4188 (class 0 OID 0)
-- Dependencies: 508
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- TOC entry 509 (class 1255 OID 29410)
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO postgres;

--
-- TOC entry 4190 (class 0 OID 0)
-- Dependencies: 509
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- TOC entry 510 (class 1255 OID 29411)
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- TOC entry 511 (class 1255 OID 29412)
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- TOC entry 512 (class 1255 OID 29413)
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- TOC entry 4219 (class 0 OID 0)
-- Dependencies: 512
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- TOC entry 513 (class 1255 OID 29414)
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: postgres
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    RAISE WARNING 'PgBouncer auth request: %', p_usename;

    RETURN QUERY
    SELECT usename::TEXT, passwd::TEXT FROM pg_catalog.pg_shadow
    WHERE usename = p_usename;
END;
$$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO postgres;

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

--
-- TOC entry 522 (class 1255 OID 29423)
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
    declare
        -- Regclass of the table e.g. public.notes
        entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

        -- I, U, D, T: insert, update ...
        action realtime.action = (
            case wal ->> 'action'
                when 'I' then 'INSERT'
                when 'U' then 'UPDATE'
                when 'D' then 'DELETE'
                else 'ERROR'
            end
        );

        -- Is row level security enabled for the table
        is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

        subscriptions realtime.subscription[] = array_agg(subs)
            from
                realtime.subscription subs
            where
                subs.entity = entity_;

        -- Subscription vars
        roles regrole[] = array_agg(distinct us.claims_role)
            from
                unnest(subscriptions) us;

        working_role regrole;
        claimed_role regrole;
        claims jsonb;

        subscription_id uuid;
        subscription_has_access bool;
        visible_to_subscription_ids uuid[] = '{}';

        -- structured info for wal's columns
        columns realtime.wal_column[];
        -- previous identity values for update/delete
        old_columns realtime.wal_column[];

        error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

        -- Primary jsonb output for record
        output jsonb;

    begin
        perform set_config('role', null, true);

        columns =
            array_agg(
                (
                    x->>'name',
                    x->>'type',
                    x->>'typeoid',
                    realtime.cast(
                        (x->'value') #>> '{}',
                        coalesce(
                            (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                            (x->>'type')::regtype
                        )
                    ),
                    (pks ->> 'name') is not null,
                    true
                )::realtime.wal_column
            )
            from
                jsonb_array_elements(wal -> 'columns') x
                left join jsonb_array_elements(wal -> 'pk') pks
                    on (x ->> 'name') = (pks ->> 'name');

        old_columns =
            array_agg(
                (
                    x->>'name',
                    x->>'type',
                    x->>'typeoid',
                    realtime.cast(
                        (x->'value') #>> '{}',
                        coalesce(
                            (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                            (x->>'type')::regtype
                        )
                    ),
                    (pks ->> 'name') is not null,
                    true
                )::realtime.wal_column
            )
            from
                jsonb_array_elements(wal -> 'identity') x
                left join jsonb_array_elements(wal -> 'pk') pks
                    on (x ->> 'name') = (pks ->> 'name');

        for working_role in select * from unnest(roles) loop

            -- Update `is_selectable` for columns and old_columns
            columns =
                array_agg(
                    (
                        c.name,
                        c.type_name,
                        c.type_oid,
                        c.value,
                        c.is_pkey,
                        pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                    )::realtime.wal_column
                )
                from
                    unnest(columns) c;

            old_columns =
                    array_agg(
                        (
                            c.name,
                            c.type_name,
                            c.type_oid,
                            c.value,
                            c.is_pkey,
                            pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                        )::realtime.wal_column
                    )
                    from
                        unnest(old_columns) c;

            if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    -- subscriptions is already filtered by entity
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
                    array['Error 400: Bad Request, no primary key']
                )::realtime.wal_rls;

            -- The claims role does not have SELECT permission to the primary key of entity
            elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
                    array['Error 401: Unauthorized']
                )::realtime.wal_rls;

            else
                output = jsonb_build_object(
                    'schema', wal ->> 'schema',
                    'table', wal ->> 'table',
                    'type', action,
                    'commit_timestamp', to_char(
                        ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                        'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
                    ),
                    'columns', (
                        select
                            jsonb_agg(
                                jsonb_build_object(
                                    'name', pa.attname,
                                    'type', pt.typname
                                )
                                order by pa.attnum asc
                            )
                        from
                            pg_attribute pa
                            join pg_type pt
                                on pa.atttypid = pt.oid
                        where
                            attrelid = entity_
                            and attnum > 0
                            and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
                    )
                )
                -- Add "record" key for insert and update
                || case
                    when action in ('INSERT', 'UPDATE') then
                        jsonb_build_object(
                            'record',
                            (
                                select
                                    jsonb_object_agg(
                                        -- if unchanged toast, get column name and value from old record
                                        coalesce((c).name, (oc).name),
                                        case
                                            when (c).name is null then (oc).value
                                            else (c).value
                                        end
                                    )
                                from
                                    unnest(columns) c
                                    full outer join unnest(old_columns) oc
                                        on (c).name = (oc).name
                                where
                                    coalesce((c).is_selectable, (oc).is_selectable)
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            )
                        )
                    else '{}'::jsonb
                end
                -- Add "old_record" key for update and delete
                || case
                    when action = 'UPDATE' then
                        jsonb_build_object(
                                'old_record',
                                (
                                    select jsonb_object_agg((c).name, (c).value)
                                    from unnest(old_columns) c
                                    where
                                        (c).is_selectable
                                        and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                )
                            )
                    when action = 'DELETE' then
                        jsonb_build_object(
                            'old_record',
                            (
                                select jsonb_object_agg((c).name, (c).value)
                                from unnest(old_columns) c
                                where
                                    (c).is_selectable
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                    and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                            )
                        )
                    else '{}'::jsonb
                end;

                -- Create the prepared statement
                if is_rls_enabled and action <> 'DELETE' then
                    if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                        deallocate walrus_rls_stmt;
                    end if;
                    execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
                end if;

                visible_to_subscription_ids = '{}';

                for subscription_id, claims in (
                        select
                            subs.subscription_id,
                            subs.claims
                        from
                            unnest(subscriptions) subs
                        where
                            subs.entity = entity_
                            and subs.claims_role = working_role
                            and (
                                realtime.is_visible_through_filters(columns, subs.filters)
                                or action = 'DELETE'
                            )
                ) loop

                    if not is_rls_enabled or action = 'DELETE' then
                        visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                    else
                        -- Check if RLS allows the role to see the record
                        perform
                            set_config('role', working_role::text, true),
                            set_config('request.jwt.claims', claims::text, true);

                        execute 'execute walrus_rls_stmt' into subscription_has_access;

                        if subscription_has_access then
                            visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                        end if;
                    end if;
                end loop;

                perform set_config('role', null, true);

                return next (
                    output,
                    is_rls_enabled,
                    visible_to_subscription_ids,
                    case
                        when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                        else '{}'
                    end
                )::realtime.wal_rls;

            end if;
        end loop;

        perform set_config('role', null, true);
    end;
    $$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 523 (class 1255 OID 29425)
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- TOC entry 524 (class 1255 OID 29426)
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- TOC entry 525 (class 1255 OID 29427)
-- Name: channel_name(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.channel_name() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.channel_name', true), '')::text;
$$;


ALTER FUNCTION realtime.channel_name() OWNER TO supabase_realtime_admin;

--
-- TOC entry 526 (class 1255 OID 29428)
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- TOC entry 527 (class 1255 OID 29429)
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- TOC entry 528 (class 1255 OID 29430)
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 529 (class 1255 OID 29431)
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- TOC entry 530 (class 1255 OID 29432)
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- TOC entry 531 (class 1255 OID 29433)
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- TOC entry 532 (class 1255 OID 29434)
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- TOC entry 533 (class 1255 OID 29435)
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 534 (class 1255 OID 29436)
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 535 (class 1255 OID 29437)
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 536 (class 1255 OID 29438)
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- TOC entry 537 (class 1255 OID 29439)
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 538 (class 1255 OID 29440)
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 539 (class 1255 OID 29441)
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 540 (class 1255 OID 29442)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- TOC entry 490 (class 1255 OID 29305)
-- Name: secrets_encrypt_secret_secret(); Type: FUNCTION; Schema: vault; Owner: supabase_admin
--

CREATE FUNCTION vault.secrets_encrypt_secret_secret() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
		BEGIN
		        new.secret = CASE WHEN new.secret IS NULL THEN NULL ELSE
			CASE WHEN new.key_id IS NULL THEN NULL ELSE pg_catalog.encode(
			  pgsodium.crypto_aead_det_encrypt(
				pg_catalog.convert_to(new.secret, 'utf8'),
				pg_catalog.convert_to((new.id::text || new.description::text || new.created_at::text || new.updated_at::text)::text, 'utf8'),
				new.key_id::uuid,
				new.nonce
			  ),
				'base64') END END;
		RETURN new;
		END;
		$$;


ALTER FUNCTION vault.secrets_encrypt_secret_secret() OWNER TO supabase_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 251 (class 1259 OID 29443)
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- TOC entry 4275 (class 0 OID 0)
-- Dependencies: 251
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- TOC entry 252 (class 1259 OID 29449)
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- TOC entry 4277 (class 0 OID 0)
-- Dependencies: 252
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- TOC entry 253 (class 1259 OID 29454)
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- TOC entry 4279 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- TOC entry 4280 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- TOC entry 254 (class 1259 OID 29461)
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- TOC entry 4282 (class 0 OID 0)
-- Dependencies: 254
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- TOC entry 255 (class 1259 OID 29466)
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- TOC entry 4284 (class 0 OID 0)
-- Dependencies: 255
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- TOC entry 256 (class 1259 OID 29471)
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- TOC entry 4286 (class 0 OID 0)
-- Dependencies: 256
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- TOC entry 257 (class 1259 OID 29476)
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- TOC entry 4288 (class 0 OID 0)
-- Dependencies: 257
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- TOC entry 258 (class 1259 OID 29481)
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 259 (class 1259 OID 29489)
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 4291 (class 0 OID 0)
-- Dependencies: 259
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- TOC entry 260 (class 1259 OID 29494)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- TOC entry 4293 (class 0 OID 0)
-- Dependencies: 260
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- TOC entry 261 (class 1259 OID 29495)
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4295 (class 0 OID 0)
-- Dependencies: 261
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- TOC entry 262 (class 1259 OID 29503)
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- TOC entry 4297 (class 0 OID 0)
-- Dependencies: 262
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- TOC entry 263 (class 1259 OID 29509)
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- TOC entry 4299 (class 0 OID 0)
-- Dependencies: 263
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- TOC entry 264 (class 1259 OID 29512)
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- TOC entry 4301 (class 0 OID 0)
-- Dependencies: 264
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- TOC entry 4302 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- TOC entry 265 (class 1259 OID 29517)
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- TOC entry 4304 (class 0 OID 0)
-- Dependencies: 265
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- TOC entry 266 (class 1259 OID 29523)
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4306 (class 0 OID 0)
-- Dependencies: 266
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- TOC entry 4307 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- TOC entry 267 (class 1259 OID 29529)
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- TOC entry 4309 (class 0 OID 0)
-- Dependencies: 267
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- TOC entry 4310 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


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
-- TOC entry 281 (class 1259 OID 29603)
-- Name: broadcasts; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.broadcasts (
    id bigint NOT NULL,
    channel_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE realtime.broadcasts OWNER TO supabase_realtime_admin;

--
-- TOC entry 282 (class 1259 OID 29606)
-- Name: broadcasts_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE SEQUENCE realtime.broadcasts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE realtime.broadcasts_id_seq OWNER TO supabase_realtime_admin;

--
-- TOC entry 4332 (class 0 OID 0)
-- Dependencies: 282
-- Name: broadcasts_id_seq; Type: SEQUENCE OWNED BY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER SEQUENCE realtime.broadcasts_id_seq OWNED BY realtime.broadcasts.id;


--
-- TOC entry 283 (class 1259 OID 29607)
-- Name: channels; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.channels (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE realtime.channels OWNER TO supabase_realtime_admin;

--
-- TOC entry 284 (class 1259 OID 29610)
-- Name: channels_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE SEQUENCE realtime.channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE realtime.channels_id_seq OWNER TO supabase_realtime_admin;

--
-- TOC entry 4335 (class 0 OID 0)
-- Dependencies: 284
-- Name: channels_id_seq; Type: SEQUENCE OWNED BY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER SEQUENCE realtime.channels_id_seq OWNED BY realtime.channels.id;


--
-- TOC entry 285 (class 1259 OID 29611)
-- Name: presences; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.presences (
    id bigint NOT NULL,
    channel_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE realtime.presences OWNER TO supabase_realtime_admin;

--
-- TOC entry 286 (class 1259 OID 29614)
-- Name: presences_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE SEQUENCE realtime.presences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE realtime.presences_id_seq OWNER TO supabase_realtime_admin;

--
-- TOC entry 4338 (class 0 OID 0)
-- Dependencies: 286
-- Name: presences_id_seq; Type: SEQUENCE OWNED BY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER SEQUENCE realtime.presences_id_seq OWNED BY realtime.presences.id;


--
-- TOC entry 287 (class 1259 OID 29615)
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- TOC entry 288 (class 1259 OID 29618)
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- TOC entry 289 (class 1259 OID 29626)
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 290 (class 1259 OID 29627)
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- TOC entry 4343 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 291 (class 1259 OID 29636)
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- TOC entry 292 (class 1259 OID 29640)
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- TOC entry 4346 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 293 (class 1259 OID 29650)
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- TOC entry 294 (class 1259 OID 29657)
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- TOC entry 247 (class 1259 OID 29301)
-- Name: decrypted_secrets; Type: VIEW; Schema: vault; Owner: supabase_admin
--

CREATE VIEW vault.decrypted_secrets AS
 SELECT secrets.id,
    secrets.name,
    secrets.description,
    secrets.secret,
        CASE
            WHEN (secrets.secret IS NULL) THEN NULL::text
            ELSE
            CASE
                WHEN (secrets.key_id IS NULL) THEN NULL::text
                ELSE convert_from(pgsodium.crypto_aead_det_decrypt(decode(secrets.secret, 'base64'::text), convert_to(((((secrets.id)::text || secrets.description) || (secrets.created_at)::text) || (secrets.updated_at)::text), 'utf8'::name), secrets.key_id, secrets.nonce), 'utf8'::name)
            END
        END AS decrypted_secret,
    secrets.key_id,
    secrets.nonce,
    secrets.created_at,
    secrets.updated_at
   FROM vault.secrets;


ALTER VIEW vault.decrypted_secrets OWNER TO supabase_admin;

--
-- TOC entry 3712 (class 2604 OID 29665)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 3739 (class 2604 OID 29666)
-- Name: broadcasts id; Type: DEFAULT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.broadcasts ALTER COLUMN id SET DEFAULT nextval('realtime.broadcasts_id_seq'::regclass);


--
-- TOC entry 3740 (class 2604 OID 29667)
-- Name: channels id; Type: DEFAULT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.channels ALTER COLUMN id SET DEFAULT nextval('realtime.channels_id_seq'::regclass);


--
-- TOC entry 3741 (class 2604 OID 29668)
-- Name: presences id; Type: DEFAULT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.presences ALTER COLUMN id SET DEFAULT nextval('realtime.presences_id_seq'::regclass);


--
-- TOC entry 4106 (class 0 OID 29443)
-- Dependencies: 251
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	155f01b1-05f9-41a3-bec1-971a1f91bb40	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"mail@foul.one","user_id":"f56b5292-03de-49cd-bc92-697a86e3b092","user_phone":""}}	2024-03-12 14:03:29.525936+00	
00000000-0000-0000-0000-000000000000	b5f6e986-0035-4f2a-aabe-ffe59b79db35	{"action":"login","actor_id":"f56b5292-03de-49cd-bc92-697a86e3b092","actor_username":"mail@foul.one","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2024-03-12 14:06:31.713043+00	
00000000-0000-0000-0000-000000000000	ab5a562a-4ef5-40bc-97ec-ac0eae83428e	{"action":"login","actor_id":"f56b5292-03de-49cd-bc92-697a86e3b092","actor_username":"mail@foul.one","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2024-03-12 14:07:03.045218+00	
00000000-0000-0000-0000-000000000000	5acb2f01-60a9-4370-b15c-9cd6d0faaa48	{"action":"logout","actor_id":"f56b5292-03de-49cd-bc92-697a86e3b092","actor_username":"mail@foul.one","actor_via_sso":false,"log_type":"account"}	2024-03-12 14:07:03.177741+00	
00000000-0000-0000-0000-000000000000	7e138183-6743-4bfb-9574-f84080ee7818	{"action":"user_repeated_signup","actor_id":"f56b5292-03de-49cd-bc92-697a86e3b092","actor_username":"mail@foul.one","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2024-03-12 14:11:07.98248+00	
00000000-0000-0000-0000-000000000000	b0c50bf0-134d-46dd-a1dc-33ee2b412f00	{"action":"user_repeated_signup","actor_id":"f56b5292-03de-49cd-bc92-697a86e3b092","actor_username":"mail@foul.one","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2024-03-12 14:13:52.640858+00	
\.


--
-- TOC entry 4107 (class 0 OID 29449)
-- Dependencies: 252
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- TOC entry 4108 (class 0 OID 29454)
-- Dependencies: 253
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
f56b5292-03de-49cd-bc92-697a86e3b092	f56b5292-03de-49cd-bc92-697a86e3b092	{"sub": "f56b5292-03de-49cd-bc92-697a86e3b092", "email": "mail@foul.one", "email_verified": false, "phone_verified": false}	email	2024-03-12 14:03:29.522844+00	2024-03-12 14:03:29.522912+00	2024-03-12 14:03:29.522912+00	0b77a149-3c9e-4adc-8047-a4d4ce8c6265
\.


--
-- TOC entry 4109 (class 0 OID 29461)
-- Dependencies: 254
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4110 (class 0 OID 29466)
-- Dependencies: 255
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- TOC entry 4111 (class 0 OID 29471)
-- Dependencies: 256
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address) FROM stdin;
\.


--
-- TOC entry 4112 (class 0 OID 29476)
-- Dependencies: 257
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret) FROM stdin;
\.


--
-- TOC entry 4113 (class 0 OID 29481)
-- Dependencies: 258
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4114 (class 0 OID 29489)
-- Dependencies: 259
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- TOC entry 4116 (class 0 OID 29495)
-- Dependencies: 261
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- TOC entry 4117 (class 0 OID 29503)
-- Dependencies: 262
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- TOC entry 4118 (class 0 OID 29509)
-- Dependencies: 263
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240314092811
20240306115329
20240427152123
\.


--
-- TOC entry 4119 (class 0 OID 29512)
-- Dependencies: 264
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
\.


--
-- TOC entry 4120 (class 0 OID 29517)
-- Dependencies: 265
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4121 (class 0 OID 29523)
-- Dependencies: 266
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4122 (class 0 OID 29529)
-- Dependencies: 267
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	f56b5292-03de-49cd-bc92-697a86e3b092	authenticated	authenticated	mail@foul.one	$2a$10$Qysw/36M.7PKa8nE2pK3RujONdTY79v2Fy8iEdBGBSb8NzdX6xCZq	2024-03-12 14:03:29.528038+00	\N		\N		\N			\N	2024-03-12 14:07:03.045896+00	{"provider": "email", "providers": ["email"]}	{}	\N	2024-03-12 14:03:29.516661+00	2024-03-12 14:07:03.047752+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- TOC entry 3692 (class 0 OID 29034)
-- Dependencies: 238
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--

COPY pgsodium.key (id, status, created, expires, key_type, key_id, key_context, name, associated_data, raw_key, raw_key_nonce, parent_key, comment, user_data) FROM stdin;
\.


--
-- TOC entry 4124 (class 0 OID 29558)
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
45	20	This is a comment on the post.	DISCUSSION	23	2024-05-29 06:01:18.522245+00	\N
46	23	This is a comment on post 1.	DISCUSSION	25	2024-05-29 06:13:40.411164+00	\N
47	23	This is a comment on post 2.	DISCUSSION	26	2024-05-29 06:13:40.411164+00	\N
48	24	Test Comment.	DISCUSSION	27	2024-05-29 06:20:52.892545+00	\N
\.


--
-- TOC entry 4127 (class 0 OID 29583)
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
-- TOC entry 4126 (class 0 OID 29565)
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
23	Post Title	This is the content of the post.	20	[]	0	1	0	2024-05-29 06:01:18.522245+00	\N
25	Post Title 1	This is the content of post 1.	23	[]	0	1	0	2024-05-29 06:13:40.411164+00	\N
26	Post Title 2	This is the content of post 2.	23	[]	0	1	0	2024-05-29 06:13:40.411164+00	\N
27	Test post	Test content.	24	[]	0	1	0	2024-05-29 06:20:52.892545+00	\N
21		<p>test</p>	6	[]	0	0	0	2024-05-26 05:13:17.507958+00	DISCUSSION
\.


--
-- TOC entry 4130 (class 0 OID 29595)
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
-- TOC entry 4123 (class 0 OID 29544)
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
-- TOC entry 4133 (class 0 OID 29603)
-- Dependencies: 281
-- Data for Name: broadcasts; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.broadcasts (id, channel_id, inserted_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4135 (class 0 OID 29607)
-- Dependencies: 283
-- Data for Name: channels; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.channels (id, name, inserted_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4137 (class 0 OID 29611)
-- Dependencies: 285
-- Data for Name: presences; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.presences (id, channel_id, inserted_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4139 (class 0 OID 29615)
-- Dependencies: 287
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2024-04-15 00:26:23
20211116045059	2024-04-15 00:26:23
20211116050929	2024-04-15 00:26:23
20211116051442	2024-04-15 00:26:23
20211116212300	2024-04-15 00:26:23
20211116213355	2024-04-15 00:26:23
20211116213934	2024-04-15 00:26:23
20211116214523	2024-04-15 00:26:23
20211122062447	2024-04-15 00:26:23
20211124070109	2024-04-15 00:26:23
20211202204204	2024-04-15 00:26:23
20211202204605	2024-04-15 00:26:23
20211210212804	2024-04-15 00:26:23
20211228014915	2024-04-15 00:26:23
20220107221237	2024-04-15 00:26:23
20220228202821	2024-04-15 00:26:23
20220312004840	2024-04-15 00:26:23
20220603231003	2024-04-15 00:26:24
20220603232444	2024-04-15 00:26:24
20220615214548	2024-04-15 00:26:24
20220712093339	2024-04-15 00:26:24
20220908172859	2024-04-15 00:26:24
20220916233421	2024-04-15 00:26:24
20230119133233	2024-04-15 00:26:24
20230128025114	2024-04-15 00:26:24
20230128025212	2024-04-15 00:26:24
20230227211149	2024-04-15 00:26:24
20230228184745	2024-04-15 00:26:24
20230308225145	2024-04-15 00:26:24
20230328144023	2024-04-15 00:26:24
20231018144023	2024-04-15 00:26:24
20231204144023	2024-04-15 00:26:24
20231204144024	2024-04-15 00:26:24
20231204144025	2024-04-15 00:26:24
20240108234812	2024-04-15 00:26:24
20240109165339	2024-04-15 00:26:24
20240227174441	2024-04-15 00:26:24
20240311171622	2024-04-15 00:26:24
20240321100241	2024-04-15 00:26:24
20240401105812	2024-04-15 00:26:24
20240418121054	2024-05-10 01:37:17
\.


--
-- TOC entry 4140 (class 0 OID 29618)
-- Dependencies: 288
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- TOC entry 4142 (class 0 OID 29627)
-- Dependencies: 290
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
store	store	\N	2024-03-10 11:57:04.904701+00	2024-03-10 11:57:04.904701+00	t	f	\N	\N	\N
\.


--
-- TOC entry 4143 (class 0 OID 29636)
-- Dependencies: 291
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2024-03-10 08:27:47.684709
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2024-03-10 08:27:47.735127
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2024-03-10 08:27:47.787415
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2024-03-10 08:27:47.811136
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2024-03-10 08:27:47.880844
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2024-03-10 08:27:47.931345
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2024-03-10 08:27:47.98315
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2024-03-10 08:27:48.034799
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2024-03-10 08:27:48.08683
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2024-03-10 08:27:48.138996
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2024-03-10 08:27:48.190805
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2024-03-10 08:27:48.242841
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2024-03-10 08:27:48.296981
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2024-03-10 08:27:48.346782
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2024-03-10 08:27:48.398694
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2024-03-10 08:27:48.427383
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2024-03-10 08:27:48.435904
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2024-03-10 08:27:48.486972
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2024-03-10 08:27:48.538874
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2024-03-10 08:27:48.590971
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2024-04-16 01:20:00.525521
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2024-04-16 01:20:00.601795
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2024-04-16 01:20:00.684781
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2024-04-16 01:20:00.809571
\.


--
-- TOC entry 4144 (class 0 OID 29640)
-- Dependencies: 292
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id) FROM stdin;
762b9a09-1761-426c-b7c5-2315df01be9c	store	default_avatar.svg	\N	2024-03-18 06:44:52.913027+00	2024-03-18 06:44:52.913027+00	2024-03-18 06:44:52.913027+00	{"eTag": "\\"103c19cfac9a4961e74dc8bf507f1edc\\"", "size": 711, "mimetype": "image/svg+xml", "cacheControl": "max-age=3600", "lastModified": "2024-03-18T06:44:53.000Z", "contentLength": 711, "httpStatusCode": 200}	660c4a6b-7de2-4b24-8b01-d5bb6ff00cbf	\N
e1904650-33f1-49ed-b804-e3ff9040b7fe	store	WhatsApp Image 2024-03-28 at 11.18.42 AM.jpeg	\N	2024-04-15 03:43:36.819425+00	2024-04-15 03:43:36.819425+00	2024-04-15 03:43:36.819425+00	{"eTag": "\\"bd0992e8a112797adddb81aa65d7da39\\"", "size": 85552, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-04-15T03:43:37.000Z", "contentLength": 85552, "httpStatusCode": 200}	3b5b3fb2-0ce3-4d3e-b8a9-a22a2d20964e	\N
3e0431d0-358d-4e62-bd35-6de3e161a950	store	img-1.jpg	\N	2024-03-24 10:19:46.992748+00	2024-03-24 10:19:46.992748+00	2024-03-24 10:19:46.992748+00	{"eTag": "\\"0877bb6a3a1b79f282698656c3eb657b\\"", "size": 58503, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-03-24T10:19:48.000Z", "contentLength": 58503, "httpStatusCode": 200}	e949fd06-f904-4992-99a6-f2be8fe28f0d	\N
a5d4bcab-4cd2-4a31-aedf-7a129186fdfc	store	upn-veteran-jakarta-gandeng-asosiasi-pengusaha-hutan-indonesia-K1uFsneCAx.jpeg	\N	2024-04-15 03:31:33.245747+00	2024-04-15 03:31:33.245747+00	2024-04-15 03:31:33.245747+00	{"eTag": "\\"52952746cc3b0f52a57551189c25d52a\\"", "size": 115946, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-04-15T03:31:34.000Z", "contentLength": 115946, "httpStatusCode": 200}	fef4856e-13e2-43ef-a700-436a80ea0f83	\N
42afd895-2344-424c-9551-6ee59ce20e02	store	5e97c962dd1dc.jpg	\N	2024-04-15 03:31:33.393778+00	2024-04-15 03:31:33.393778+00	2024-04-15 03:31:33.393778+00	{"eTag": "\\"4ad491a5958dfe0e490975e34ebc1fe9\\"", "size": 83077, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-04-15T03:31:34.000Z", "contentLength": 83077, "httpStatusCode": 200}	a21c813d-ce1b-4203-b1fa-c3e6e6ea9e97	\N
a5cf7f91-e7dd-4d83-b1ce-af2566c1d59d	store	eJDhv5G09z.jpg	\N	2024-04-15 03:31:33.551123+00	2024-04-15 03:31:33.551123+00	2024-04-15 03:31:33.551123+00	{"eTag": "\\"5cdf4de81458d0fa39b71caaf5dc87c5\\"", "size": 159804, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-04-15T03:31:34.000Z", "contentLength": 159804, "httpStatusCode": 200}	355b34a5-674b-42b2-90fc-e119021a5ef4	\N
c6e9a287-ee56-403d-b7c3-a5c0ddcf0343	store	DSC_1253 (2).jpg	\N	2024-04-15 03:31:34.136502+00	2024-04-15 03:31:34.136502+00	2024-04-15 03:31:34.136502+00	{"eTag": "\\"d0a309ac597d2881fde362d6543f2989\\"", "size": 2267444, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-04-15T03:31:34.000Z", "contentLength": 2267444, "httpStatusCode": 200}	49dbc2a2-3742-49a2-b5b6-9fe0165a43bf	\N
3825999c-dd99-4757-a304-337320a0918b	store	DSC_1174.jpg	\N	2024-04-15 03:31:35.573477+00	2024-04-15 03:31:35.573477+00	2024-04-15 03:31:35.573477+00	{"eTag": "\\"485da13876d01110219bf86834b727f4-2\\"", "size": 8491335, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-04-15T03:31:36.000Z", "contentLength": 8491335, "httpStatusCode": 200}	48a6d384-cef3-4e2d-8fec-d16f3df69024	\N
20bb7608-cf00-4491-894c-8f63795e6635	store	1-202441985547-avatar.png	\N	2024-04-19 01:55:48.006708+00	2024-04-19 01:55:48.006708+00	2024-04-19 01:55:48.006708+00	{"eTag": "\\"33f0a9dc1d044cfb53812232e2a2d125\\"", "size": 317062, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-04-19T01:55:48.000Z", "contentLength": 317062, "httpStatusCode": 200}	442a483f-e914-4f32-b63f-c1f5df53338f	\N
226873f5-b192-4b39-8c2b-058c4c402fc2	store	1-avatar.png	\N	2024-04-18 15:31:05.192071+00	2024-04-18 15:31:05.192071+00	2024-04-18 15:31:05.192071+00	{"eTag": "\\"45c62415c333a7fba9ad5ef3876260de\\"", "size": 609130, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-04-18T15:31:06.000Z", "contentLength": 609130, "httpStatusCode": 200}	4ae8ddab-ebb7-4b05-8231-51906c9ffe6a	\N
07b9ae62-1d9d-4e53-b00c-d6a23ecc16a9	store	1-202441913214-avatar.png	\N	2024-04-19 06:02:15.195573+00	2024-04-19 06:02:15.195573+00	2024-04-19 06:02:15.195573+00	{"eTag": "\\"65ad4394282cc67fb343548de88a0acb\\"", "size": 166994, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-04-19T06:02:16.000Z", "contentLength": 166994, "httpStatusCode": 200}	029aef79-1029-42cb-8e5a-156739911504	\N
83d884be-4ebd-4be0-a27a-e14145816a0d	store	1-202441981245-avatar.png	\N	2024-04-19 01:12:46.47489+00	2024-04-19 01:12:46.47489+00	2024-04-19 01:12:46.47489+00	{"eTag": "\\"33f0a9dc1d044cfb53812232e2a2d125\\"", "size": 317062, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-04-19T01:12:47.000Z", "contentLength": 317062, "httpStatusCode": 200}	0a455771-6c83-4f75-b373-e0ea727740e0	\N
3a470805-cab0-42c8-bc66-babd3b78b426	store	1-202441981517-avatar.png	\N	2024-04-19 01:15:18.49524+00	2024-04-19 01:15:18.49524+00	2024-04-19 01:15:18.49524+00	{"eTag": "\\"430c0725cc59b74f9fb0ed88b1eb4d3c\\"", "size": 319517, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-04-19T01:15:19.000Z", "contentLength": 319517, "httpStatusCode": 200}	c9e6e3ae-cc40-491c-8f1d-7db3d6ffaeed	\N
a99aa519-9651-4b1c-a0bf-05ef8ef6f5b8	store	1-202441981554-avatar.png	\N	2024-04-19 01:15:56.596329+00	2024-04-19 01:15:56.596329+00	2024-04-19 01:15:56.596329+00	{"eTag": "\\"eab0de2ad0755a47a0ccf0081f62235d\\"", "size": 3403232, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-04-19T01:15:57.000Z", "contentLength": 3403232, "httpStatusCode": 200}	e1adc7bb-ffde-46d4-be52-2df88f9bde0a	\N
3d935f36-d640-4aa5-a7e5-aa7e15510f78	store	2-2024419132711-avatar.png	\N	2024-04-19 06:27:14.453107+00	2024-04-19 06:27:14.453107+00	2024-04-19 06:27:14.453107+00	{"eTag": "\\"092aaefb256e4c970b41ec8543734d2d\\"", "size": 393677, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-04-19T06:27:15.000Z", "contentLength": 393677, "httpStatusCode": 200}	65f5b75c-d9e5-463b-a867-bb246edd402e	\N
b4da7d90-3cec-4549-bbd6-63e6d87e2ed2	store	1-20245713517-attachment.png	\N	2024-05-07 06:05:19.23276+00	2024-05-07 06:05:19.23276+00	2024-05-07 06:05:19.23276+00	{"eTag": "\\"db89fe730b0d571d9848016b4aa2135a\\"", "size": 269533, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-07T06:05:20.000Z", "contentLength": 269533, "httpStatusCode": 200}	7ac91556-bda5-486f-9fbd-d33502386b94	\N
8e25ad7c-fade-404d-a0ee-4168d86affe9	store	1-2024571362-attachment.png	\N	2024-05-07 06:06:03.805264+00	2024-05-07 06:06:03.805264+00	2024-05-07 06:06:03.805264+00	{"eTag": "\\"d1004d2a28b8af2b4d74b938b9db9d7c\\"", "size": 482434, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-07T06:06:04.000Z", "contentLength": 482434, "httpStatusCode": 200}	ab8a493f-e326-4602-8bba-12afef71ad17	\N
a9f9cc0e-7201-470b-9c8a-3fd177ad60e2	store	1-202457131342-avatar.png	\N	2024-05-07 06:13:43.73089+00	2024-05-07 06:13:43.73089+00	2024-05-07 06:13:43.73089+00	{"eTag": "\\"db89fe730b0d571d9848016b4aa2135a\\"", "size": 269533, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-07T06:13:44.000Z", "contentLength": 269533, "httpStatusCode": 200}	b1f6cf3a-cd7b-4b94-9ec7-539d034cae87	\N
e66ca88c-a7cc-4452-ab5f-219a26a50425	store	1-202457133849-avatar.png	\N	2024-05-07 06:38:51.619779+00	2024-05-07 06:38:51.619779+00	2024-05-07 06:38:51.619779+00	{"eTag": "\\"031dbaeda01ba8a3222f51099efcfb3f\\"", "size": 3192952, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-07T06:38:52.000Z", "contentLength": 3192952, "httpStatusCode": 200}	d784b9b6-52c7-481d-9b4c-ea5f18b315c5	\N
173841fd-ee43-4a6e-b49f-432fec45619b	store	1-202457134234-avatar.png	\N	2024-05-07 06:42:36.125119+00	2024-05-07 06:42:36.125119+00	2024-05-07 06:42:36.125119+00	{"eTag": "\\"75f49f94e56701f53da46e323b59b6af\\"", "size": 807293, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-07T06:42:36.000Z", "contentLength": 807293, "httpStatusCode": 200}	c3690908-8a9e-4553-b2d3-a7a8dd7c212a	\N
d2eeef41-9226-4ac9-ae57-3ffa843810b9	store	1-202457211652-avatar.png	\N	2024-05-07 14:16:54.764042+00	2024-05-07 14:16:54.764042+00	2024-05-07 14:16:54.764042+00	{"eTag": "\\"e70f7b837ffe096d74168e559e9bd600\\"", "size": 1965460, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-07T14:16:55.000Z", "contentLength": 1965460, "httpStatusCode": 200}	fbe2f649-8371-48a5-80ca-ff3312ca6464	\N
6710c82b-c92c-4720-a944-845e323cab64	store	1-20245894657-avatar.png	\N	2024-05-08 02:46:58.767669+00	2024-05-08 02:46:58.767669+00	2024-05-08 02:46:58.767669+00	{"eTag": "\\"87ed9b149341aeec130e1ff3e4a0a187\\"", "size": 2378458, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-08T02:46:59.000Z", "contentLength": 2378458, "httpStatusCode": 200}	b1888fd8-9b7c-4d15-866f-7ab7fc16056e	\N
43673457-5d8b-4b7a-a3c9-2a93b6839dfa	store	1-202458115522-avatar.png	\N	2024-05-08 04:55:23.787725+00	2024-05-08 04:55:23.787725+00	2024-05-08 04:55:23.787725+00	{"eTag": "\\"342f049961e3b1c83a91c18b06e52e5e\\"", "size": 299826, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-08T04:55:24.000Z", "contentLength": 299826, "httpStatusCode": 200}	15c7a104-b896-44e8-9dff-ce0cd47fd36a	\N
25e7fda7-1f08-4f38-b1c4-07087100f145	store	DSC_47421.jpg	\N	2024-05-10 01:38:51.226016+00	2024-05-10 01:38:51.226016+00	2024-05-10 01:38:51.226016+00	{"eTag": "\\"31263ffedca2a5f1c854e37c31886027\\"", "size": 593215, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-05-10T01:38:52.000Z", "contentLength": 593215, "httpStatusCode": 200}	0d7ea56a-aaed-421b-be3c-0f1642a88157	\N
41fe6b4a-65c9-4883-8bc8-47aaadcaf28f	store	mahasiswa-upn-veteran-jakarta-meminta-penjelasan-rektorat-fo-bcn5.jpg	\N	2024-05-10 01:40:03.666573+00	2024-05-10 01:40:03.666573+00	2024-05-10 01:40:03.666573+00	{"eTag": "\\"cdc57b302e9656b759f35d8f5d17d1b1\\"", "size": 61947, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-05-10T01:40:04.000Z", "contentLength": 61947, "httpStatusCode": 200}	f03701df-2587-41e1-8ae0-dbed3441e2ab	\N
a51c1cc2-c8d9-43ac-9b33-1fe148c822c9	store	mahasiswa-upn-veteran-jakarta-meminta-penjelasan-rektorat-fo-bcn5 (1).jpg	\N	2024-05-10 01:40:08.936065+00	2024-05-10 01:40:08.936065+00	2024-05-10 01:40:08.936065+00	{"eTag": "\\"cdc57b302e9656b759f35d8f5d17d1b1\\"", "size": 61947, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-05-10T01:40:09.000Z", "contentLength": 61947, "httpStatusCode": 200}	205cf208-d92f-42f4-80e9-3b597f6b9910	\N
f6d8fccc-94d2-4a22-936f-91cd98d519c0	store	PKS-dengan-UPN-Veteran-3.jpg	\N	2024-05-10 01:42:58.822221+00	2024-05-10 01:42:58.822221+00	2024-05-10 01:42:58.822221+00	{"eTag": "\\"48854e50a1db98519065ce304c562aef\\"", "size": 594767, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-05-10T01:42:59.000Z", "contentLength": 594767, "httpStatusCode": 200}	26933fae-a4c0-49f0-ac16-ff1ecf6c8ce7	\N
ee1b7186-b63b-4bcc-adef-e64cd19a8fd7	store	PKS-dengan-UPN-Veteran-3 (1).jpg	\N	2024-05-10 01:43:06.828421+00	2024-05-10 01:43:06.828421+00	2024-05-10 01:43:06.828421+00	{"eTag": "\\"48854e50a1db98519065ce304c562aef\\"", "size": 594767, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-05-10T01:43:07.000Z", "contentLength": 594767, "httpStatusCode": 200}	2ab8d669-7112-41e0-8f24-086faf2a4842	\N
824fba2c-0e9e-4a0a-9be5-d86897fdd37f	store	fisip-upn-veteran-jakarta-gelar-seminar-internasional-1_169.jpeg	\N	2024-05-10 01:45:49.137258+00	2024-05-10 01:45:49.137258+00	2024-05-10 01:45:49.137258+00	{"eTag": "\\"fb9e81300ecca30a9cf33e823e483690\\"", "size": 70167, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-05-10T01:45:50.000Z", "contentLength": 70167, "httpStatusCode": 200}	c63ee540-85cd-4ea9-896d-f552cbe1c0c7	\N
85636f7a-ab5e-4a1d-84ae-50adfba402a0	store	1-20245101600-attachment.png	\N	2024-05-10 09:00:02.778073+00	2024-05-10 09:00:02.778073+00	2024-05-10 09:00:02.778073+00	{"eTag": "\\"7c955a1fac0c01ae1a2a4f934ee9a1dc\\"", "size": 625918, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-10T09:00:03.000Z", "contentLength": 625918, "httpStatusCode": 200}	f00374b4-f861-4ec7-bc9f-aec94f3c482c	\N
291fe217-f473-4bbb-868b-0a226fc941d8	store	1-202451016454-attachment.png	\N	2024-05-10 09:04:55.664833+00	2024-05-10 09:04:55.664833+00	2024-05-10 09:04:55.664833+00	{"eTag": "\\"c574356482bf3909ec9c979316303b15\\"", "size": 227611, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-10T09:04:56.000Z", "contentLength": 227611, "httpStatusCode": 200}	250ea0a3-b51d-4736-9c51-7b25949a2a9e	\N
431eac14-de99-4af0-ab0a-7ab6f8406482	store	1-202451113311-attachment.png	\N	2024-05-11 06:31:02.671111+00	2024-05-11 06:31:02.671111+00	2024-05-11 06:31:02.671111+00	{"eTag": "\\"7c955a1fac0c01ae1a2a4f934ee9a1dc\\"", "size": 625918, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-11T06:31:03.000Z", "contentLength": 625918, "httpStatusCode": 200}	2c51e868-3772-4f90-ad32-50ada9fc994b	\N
593e56e4-d710-4420-ad76-800f0d08d021	store	1-202451216246-attachment0.png	\N	2024-05-12 09:24:07.748617+00	2024-05-12 09:24:07.748617+00	2024-05-12 09:24:07.748617+00	{"eTag": "\\"5da52bed2a0b6b935f5b4acaec347fc5\\"", "size": 30869, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-12T09:24:08.000Z", "contentLength": 30869, "httpStatusCode": 200}	8a8779a9-5557-490e-a301-ac4f6ec102f6	\N
90f8d5f0-16f2-403f-888a-a41d4f355cae	store	1-2024512164613-avatar.png	\N	2024-05-12 09:46:14.237826+00	2024-05-12 09:46:14.237826+00	2024-05-12 09:46:14.237826+00	{"eTag": "\\"484ecca1adf57655b6c16c528842c306\\"", "size": 259442, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-12T09:46:15.000Z", "contentLength": 259442, "httpStatusCode": 200}	54eaa271-8e3e-4721-9609-029171a0d977	\N
926c75d4-161a-4cdd-a2d2-efb1ce9128a2	store	1-202451313385-avatar.png	\N	2024-05-13 06:38:07.639671+00	2024-05-13 06:38:07.639671+00	2024-05-13 06:38:07.639671+00	{"eTag": "\\"2d3311dd3b4f46d74b433bcde973d78f\\"", "size": 242393, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-13T06:38:08.000Z", "contentLength": 242393, "httpStatusCode": 200}	79a9f0d5-3769-4502-84fa-54d8c0e77ac9	\N
13424bc7-724d-4f0e-9860-ed68adc41250	store	1-20245132076-attachment0.png	\N	2024-05-13 13:07:07.691901+00	2024-05-13 13:07:07.691901+00	2024-05-13 13:07:07.691901+00	{"eTag": "\\"5da52bed2a0b6b935f5b4acaec347fc5\\"", "size": 30869, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-13T13:07:08.000Z", "contentLength": 30869, "httpStatusCode": 200}	c11e9afa-528e-4a89-a0f0-0a1e8d0e78b4	\N
ff933501-7c9a-4b34-b4e4-671836db1eb0	store	1-202451320910-attachment0.png	\N	2024-05-13 13:09:11.90855+00	2024-05-13 13:09:11.90855+00	2024-05-13 13:09:11.90855+00	{"eTag": "\\"ab6920c01f1727652f68f5dbabbf32e2\\"", "size": 144838, "mimetype": "image/jpeg", "cacheControl": "max-age=0", "lastModified": "2024-05-13T13:09:12.000Z", "contentLength": 144838, "httpStatusCode": 200}	2f36f4d8-3fad-4f4c-adb2-785a0d5d0e9b	\N
8c4e7a3b-4c09-485d-bfc7-a6baa8ec6529	store	1-2024513202226-attachment0.png	\N	2024-05-13 13:22:26.862343+00	2024-05-13 13:22:26.862343+00	2024-05-13 13:22:26.862343+00	{"eTag": "\\"c4ad664bb91652f99a112517d0370fa5\\"", "size": 722614, "mimetype": "image/jpeg", "cacheControl": "max-age=0", "lastModified": "2024-05-13T13:22:27.000Z", "contentLength": 722614, "httpStatusCode": 200}	fd8cf202-33ea-472c-bdf6-1eacc0bdde01	\N
5817744a-fd7f-4287-9e15-d18f0a02cb8d	store	1-2024516105030-attachment0.png	\N	2024-05-16 03:50:33.228475+00	2024-05-16 03:50:33.228475+00	2024-05-16 03:50:33.228475+00	{"eTag": "\\"5da52bed2a0b6b935f5b4acaec347fc5\\"", "size": 30869, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-16T03:50:34.000Z", "contentLength": 30869, "httpStatusCode": 200}	6c769269-35a3-44a2-8ad1-5c8bfc277c10	\N
477f9a15-2297-4590-9bd7-7127df8f146a	store	1-2024516105143-avatar.png	\N	2024-05-16 03:51:47.478207+00	2024-05-16 03:51:47.478207+00	2024-05-16 03:51:47.478207+00	{"eTag": "\\"29e032d6829c8b10663ae1e913bd88a1\\"", "size": 3794121, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-16T03:51:48.000Z", "contentLength": 3794121, "httpStatusCode": 200}	52b9e040-6f85-4058-811a-ec7328d519ff	\N
26bf718a-1fb2-41e4-b34c-1930b23326a8	store	1-202452010126-avatar.png	\N	2024-05-20 03:12:07.836138+00	2024-05-20 03:12:07.836138+00	2024-05-20 03:12:07.836138+00	{"eTag": "\\"8285ac15b473741baadf955ee07a23dd\\"", "size": 214192, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-20T03:12:08.000Z", "contentLength": 214192, "httpStatusCode": 200}	aa1e2427-b6a2-4608-b0f3-fb925a24650e	\N
453fa5ec-127c-4650-8bbc-3104985c63b6	store	1-202452010141-attachment.png	\N	2024-05-20 03:14:02.845068+00	2024-05-20 03:14:02.845068+00	2024-05-20 03:14:02.845068+00	{"eTag": "\\"daa3382238c75560dd8f37b64339372e\\"", "size": 53754, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-20T03:14:03.000Z", "contentLength": 53754, "httpStatusCode": 200}	1a4ffe52-5f90-4bbe-8b5f-29194219dd44	\N
535e76cd-3cff-4243-91dc-7f04b4f234e9	store	original-a3c7656c746c207995eba8db27460e1c.png	\N	2024-05-20 13:51:01.014978+00	2024-05-20 13:51:01.014978+00	2024-05-20 13:51:01.014978+00	{"eTag": "\\"1a4a172cab3d75ad94c510615368109c\\"", "size": 1146900, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-05-20T13:51:01.000Z", "contentLength": 1146900, "httpStatusCode": 200}	d9fc18ca-3c8e-4658-bfaa-a817f226dddd	\N
91be3557-bd43-4055-9654-27d5a9ea00b8	store	maxresdefault.jpg	\N	2024-05-20 13:53:04.844562+00	2024-05-20 13:53:04.844562+00	2024-05-20 13:53:04.844562+00	{"eTag": "\\"19a7a0dc80fa8ed2b219dc0621f4ba2b\\"", "size": 110146, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-05-20T13:53:05.000Z", "contentLength": 110146, "httpStatusCode": 200}	ba5f7728-d10a-4fe6-a509-aaa551af6229	\N
602ad9e9-e544-48ed-9a22-ba4a5c2c6da5	store	maxresdefault (1).jpg	\N	2024-05-20 13:54:52.119729+00	2024-05-20 13:54:52.119729+00	2024-05-20 13:54:52.119729+00	{"eTag": "\\"1eba3dde5f259bdc54237f8ac62edb61\\"", "size": 84846, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-05-20T13:54:52.000Z", "contentLength": 84846, "httpStatusCode": 200}	9290fbd8-b0bf-4b4c-921e-a78f2e4af413	\N
f8d648d3-e672-43f4-902e-92eea0d9e1da	store	WhatsApp-Image-2023-11-19-at-15.10.36.jpeg	\N	2024-05-20 15:07:50.41922+00	2024-05-20 15:07:50.41922+00	2024-05-20 15:07:50.41922+00	{"eTag": "\\"c6594d5ef3aa08feabf0e6f0ed3ca903\\"", "size": 311191, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-05-20T15:07:51.000Z", "contentLength": 311191, "httpStatusCode": 200}	c962ab73-e596-4766-a6cd-b95bf33db038	\N
8ecac1c7-700f-4667-aa38-f982de92fb4e	store	maxresdefault (2).jpg	\N	2024-05-21 03:05:33.70396+00	2024-05-21 03:05:33.70396+00	2024-05-21 03:05:33.70396+00	{"eTag": "\\"321f181c6bf6bd839ae111c817ceca75\\"", "size": 193782, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-05-21T03:05:34.000Z", "contentLength": 193782, "httpStatusCode": 200}	644189fa-330f-4d6d-8710-bc34a1e3019c	\N
6205dd72-17ba-41c1-b8f3-f5bab56d06ad	store	BlogWhat-is-Userflow-in-UX-Design_.jpg	\N	2024-05-21 04:50:32.772443+00	2024-05-21 04:50:32.772443+00	2024-05-21 04:50:32.772443+00	{"eTag": "\\"5f0f54b22771e477e530cdad22d0eb3b\\"", "size": 547588, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-05-21T04:50:33.000Z", "contentLength": 547588, "httpStatusCode": 200}	e2ebee4d-3a99-4e03-85b0-fa8684bc5dba	\N
a6171a0f-acfb-4ebb-b556-2974dafb85a7	store	1-2024523113621-avatar.png	\N	2024-05-23 04:36:23.825317+00	2024-05-23 04:36:23.825317+00	2024-05-23 04:36:23.825317+00	{"eTag": "\\"bd695290030ed01397af897256870e93\\"", "size": 4859889, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-23T04:36:24.000Z", "contentLength": 4859889, "httpStatusCode": 200}	b2094cc1-69b2-45da-b3bc-b3e4e38510ca	\N
b4f490f9-fa9f-496e-a4e8-c323194d1c7a	store	1-2024523113834-attachment0.png	\N	2024-05-23 04:38:35.3585+00	2024-05-23 04:38:35.3585+00	2024-05-23 04:38:35.3585+00	{"eTag": "\\"9c405168e72438051d76e6146498c9e5\\"", "size": 326308, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-23T04:38:36.000Z", "contentLength": 326308, "httpStatusCode": 200}	6b6ba3c5-791c-45c9-9de6-fd8856be133d	\N
6cc270f0-041b-4f3a-9b03-1bb4fccadc31	store	1-2024523113834-attachment1.png	\N	2024-05-23 04:38:36.298858+00	2024-05-23 04:38:36.298858+00	2024-05-23 04:38:36.298858+00	{"eTag": "\\"f180654ee133c0474a918fb874bd9f7e\\"", "size": 56050, "mimetype": "image/jpeg", "cacheControl": "max-age=0", "lastModified": "2024-05-23T04:38:37.000Z", "contentLength": 56050, "httpStatusCode": 200}	a1f73ee4-c7fe-475d-9fdd-31cdcadade51	\N
ae85834b-0949-4094-a144-9f38dc1b0785	store	1-202452311579-avatar.png	\N	2024-05-23 04:57:10.719903+00	2024-05-23 04:57:10.719903+00	2024-05-23 04:57:10.719903+00	{"eTag": "\\"eb315ade7173ae84490e8e99152de141\\"", "size": 181910, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-23T04:57:11.000Z", "contentLength": 181910, "httpStatusCode": 200}	9b9c60d0-c00f-4c83-9af5-9b057acea535	\N
ae025120-c6df-48f5-93fc-9c62cde04b15	store	1-2024526103650-avatar.png	\N	2024-05-26 03:36:51.565303+00	2024-05-26 03:36:51.565303+00	2024-05-26 03:36:51.565303+00	{"eTag": "\\"f9dcc50555fae3c2d0c3dc088d1b3af3\\"", "size": 158754, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-26T03:36:52.000Z", "contentLength": 158754, "httpStatusCode": 200}	dcf37711-d29c-4951-80e6-eaea3e78eb37	\N
296a7971-2e72-458d-adad-60008e92bc45	store	12-202452825543-avatar.png	\N	2024-05-28 02:55:45.579054+00	2024-05-28 02:55:45.579054+00	2024-05-28 02:55:45.579054+00	{"eTag": "\\"fb7422e6bc41aaee40d1a25cdb81fb20\\"", "size": 193385, "mimetype": "image/png", "cacheControl": "max-age=0", "lastModified": "2024-05-28T02:55:46.000Z", "contentLength": 193385, "httpStatusCode": 200}	6be659ca-a4f6-425c-b92e-1eb5c3abd1cd	\N
\.


--
-- TOC entry 4145 (class 0 OID 29650)
-- Dependencies: 293
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at) FROM stdin;
\.


--
-- TOC entry 4146 (class 0 OID 29657)
-- Dependencies: 294
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- TOC entry 3694 (class 0 OID 29282)
-- Dependencies: 246
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4350 (class 0 OID 0)
-- Dependencies: 260
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 2, true);


--
-- TOC entry 4351 (class 0 OID 0)
-- Dependencies: 237
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('pgsodium.key_key_id_seq', 1, false);


--
-- TOC entry 4352 (class 0 OID 0)
-- Dependencies: 271
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 48, true);


--
-- TOC entry 4353 (class 0 OID 0)
-- Dependencies: 276
-- Name: podcasts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.podcasts_id_seq', 2, true);


--
-- TOC entry 4354 (class 0 OID 0)
-- Dependencies: 277
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 27, true);


--
-- TOC entry 4355 (class 0 OID 0)
-- Dependencies: 279
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settings_id_seq', 8, true);


--
-- TOC entry 4356 (class 0 OID 0)
-- Dependencies: 280
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 25, true);


--
-- TOC entry 4357 (class 0 OID 0)
-- Dependencies: 282
-- Name: broadcasts_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_realtime_admin
--

SELECT pg_catalog.setval('realtime.broadcasts_id_seq', 1, false);


--
-- TOC entry 4358 (class 0 OID 0)
-- Dependencies: 284
-- Name: channels_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_realtime_admin
--

SELECT pg_catalog.setval('realtime.channels_id_seq', 1, false);


--
-- TOC entry 4359 (class 0 OID 0)
-- Dependencies: 286
-- Name: presences_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_realtime_admin
--

SELECT pg_catalog.setval('realtime.presences_id_seq', 1, false);


--
-- TOC entry 4360 (class 0 OID 0)
-- Dependencies: 289
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- TOC entry 3797 (class 2606 OID 29670)
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- TOC entry 3781 (class 2606 OID 29672)
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 3785 (class 2606 OID 29674)
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- TOC entry 3790 (class 2606 OID 29676)
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- TOC entry 3792 (class 2606 OID 29678)
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- TOC entry 3795 (class 2606 OID 29680)
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- TOC entry 3799 (class 2606 OID 29682)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- TOC entry 3802 (class 2606 OID 29684)
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 3805 (class 2606 OID 29686)
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- TOC entry 3809 (class 2606 OID 29688)
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3817 (class 2606 OID 29690)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3820 (class 2606 OID 29692)
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- TOC entry 3823 (class 2606 OID 29694)
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- TOC entry 3825 (class 2606 OID 29696)
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3830 (class 2606 OID 29698)
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- TOC entry 3833 (class 2606 OID 29700)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3836 (class 2606 OID 29702)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 3841 (class 2606 OID 29704)
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 3844 (class 2606 OID 29706)
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3856 (class 2606 OID 29708)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 3858 (class 2606 OID 29710)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3864 (class 2606 OID 29712)
-- Name: comments comments_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_id_key UNIQUE (id);


--
-- TOC entry 3866 (class 2606 OID 29714)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 3870 (class 2606 OID 29716)
-- Name: podcasts podcasts_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.podcasts
    ADD CONSTRAINT podcasts_id_key UNIQUE (id);


--
-- TOC entry 3872 (class 2606 OID 29718)
-- Name: podcasts podcasts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.podcasts
    ADD CONSTRAINT podcasts_pkey PRIMARY KEY (id);


--
-- TOC entry 3868 (class 2606 OID 29720)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 3874 (class 2606 OID 29722)
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- TOC entry 3860 (class 2606 OID 29724)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3862 (class 2606 OID 29726)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3877 (class 2606 OID 29728)
-- Name: broadcasts broadcasts_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.broadcasts
    ADD CONSTRAINT broadcasts_pkey PRIMARY KEY (id);


--
-- TOC entry 3880 (class 2606 OID 29730)
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- TOC entry 3888 (class 2606 OID 29732)
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- TOC entry 3883 (class 2606 OID 29734)
-- Name: presences presences_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.presences
    ADD CONSTRAINT presences_pkey PRIMARY KEY (id);


--
-- TOC entry 3885 (class 2606 OID 29736)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3892 (class 2606 OID 29738)
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- TOC entry 3894 (class 2606 OID 29740)
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- TOC entry 3896 (class 2606 OID 29742)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3901 (class 2606 OID 29744)
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- TOC entry 3906 (class 2606 OID 29746)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 3904 (class 2606 OID 29748)
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- TOC entry 3782 (class 1259 OID 29749)
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- TOC entry 3846 (class 1259 OID 29750)
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3847 (class 1259 OID 29751)
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3848 (class 1259 OID 29752)
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3803 (class 1259 OID 29753)
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- TOC entry 3783 (class 1259 OID 29754)
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- TOC entry 3788 (class 1259 OID 29755)
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- TOC entry 4361 (class 0 OID 0)
-- Dependencies: 3788
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- TOC entry 3793 (class 1259 OID 29756)
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- TOC entry 3786 (class 1259 OID 29757)
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- TOC entry 3787 (class 1259 OID 29758)
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- TOC entry 3800 (class 1259 OID 29759)
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- TOC entry 3806 (class 1259 OID 29760)
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- TOC entry 3807 (class 1259 OID 29761)
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- TOC entry 3810 (class 1259 OID 29762)
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- TOC entry 3811 (class 1259 OID 29763)
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- TOC entry 3812 (class 1259 OID 29764)
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- TOC entry 3849 (class 1259 OID 29765)
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3850 (class 1259 OID 29766)
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3813 (class 1259 OID 29767)
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- TOC entry 3814 (class 1259 OID 29768)
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- TOC entry 3815 (class 1259 OID 29769)
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- TOC entry 3818 (class 1259 OID 29770)
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- TOC entry 3821 (class 1259 OID 29771)
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- TOC entry 3826 (class 1259 OID 29772)
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- TOC entry 3827 (class 1259 OID 29773)
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- TOC entry 3828 (class 1259 OID 29774)
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- TOC entry 3831 (class 1259 OID 29775)
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- TOC entry 3834 (class 1259 OID 29776)
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- TOC entry 3837 (class 1259 OID 29777)
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- TOC entry 3839 (class 1259 OID 29778)
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- TOC entry 3842 (class 1259 OID 29779)
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- TOC entry 3845 (class 1259 OID 29780)
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- TOC entry 3838 (class 1259 OID 29781)
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- TOC entry 3851 (class 1259 OID 29782)
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- TOC entry 4362 (class 0 OID 0)
-- Dependencies: 3851
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- TOC entry 3852 (class 1259 OID 29783)
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- TOC entry 3853 (class 1259 OID 29784)
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- TOC entry 3854 (class 1259 OID 29785)
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- TOC entry 3875 (class 1259 OID 29786)
-- Name: broadcasts_channel_id_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE UNIQUE INDEX broadcasts_channel_id_index ON realtime.broadcasts USING btree (channel_id);


--
-- TOC entry 3878 (class 1259 OID 29787)
-- Name: channels_name_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE UNIQUE INDEX channels_name_index ON realtime.channels USING btree (name);


--
-- TOC entry 3886 (class 1259 OID 29788)
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING hash (entity);


--
-- TOC entry 3881 (class 1259 OID 29789)
-- Name: presences_channel_id_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE UNIQUE INDEX presences_channel_id_index ON realtime.presences USING btree (channel_id);


--
-- TOC entry 3889 (class 1259 OID 29790)
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- TOC entry 3890 (class 1259 OID 29791)
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- TOC entry 3897 (class 1259 OID 29792)
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- TOC entry 3902 (class 1259 OID 29793)
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- TOC entry 3898 (class 1259 OID 29794)
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- TOC entry 3899 (class 1259 OID 29795)
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- TOC entry 3930 (class 2620 OID 29796)
-- Name: comments commentsdelete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER commentsdelete AFTER DELETE ON public.comments FOR EACH ROW EXECUTE FUNCTION public.delcomment();


--
-- TOC entry 3931 (class 2620 OID 29797)
-- Name: comments commentsinsert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER commentsinsert AFTER INSERT ON public.comments FOR EACH ROW EXECUTE FUNCTION public.addcomment();


--
-- TOC entry 3933 (class 2620 OID 29798)
-- Name: podcasts insertpermission; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER insertpermission BEFORE INSERT ON public.podcasts FOR EACH ROW EXECUTE FUNCTION public.checkpermission();


--
-- TOC entry 3932 (class 2620 OID 29799)
-- Name: comments trg_update_comment_type; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_update_comment_type BEFORE UPDATE ON public.comments FOR EACH ROW EXECUTE FUNCTION public.update_comment_type();


--
-- TOC entry 3934 (class 2620 OID 29800)
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- TOC entry 3935 (class 2620 OID 29801)
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- TOC entry 3907 (class 2606 OID 29802)
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 3908 (class 2606 OID 29807)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 3909 (class 2606 OID 29812)
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- TOC entry 3910 (class 2606 OID 29817)
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 3911 (class 2606 OID 29822)
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 3912 (class 2606 OID 29827)
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 3913 (class 2606 OID 29832)
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 3914 (class 2606 OID 29837)
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- TOC entry 3915 (class 2606 OID 29842)
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 3916 (class 2606 OID 29847)
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 3917 (class 2606 OID 29852)
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 3918 (class 2606 OID 29857)
-- Name: comments comments_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_author_fkey FOREIGN KEY (author) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3919 (class 2606 OID 29862)
-- Name: comments comments_podcastid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_podcastid_fkey FOREIGN KEY (podcastid) REFERENCES public.podcasts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3920 (class 2606 OID 29867)
-- Name: comments comments_postid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_postid_fkey FOREIGN KEY (postid) REFERENCES public.posts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3921 (class 2606 OID 29872)
-- Name: posts posts_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_author_fkey FOREIGN KEY (author) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3922 (class 2606 OID 29877)
-- Name: podcasts public_podcasts_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.podcasts
    ADD CONSTRAINT public_podcasts_author_fkey FOREIGN KEY (author) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3923 (class 2606 OID 29882)
-- Name: settings settings_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3924 (class 2606 OID 29887)
-- Name: broadcasts broadcasts_channel_id_fkey; Type: FK CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.broadcasts
    ADD CONSTRAINT broadcasts_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES realtime.channels(id) ON DELETE CASCADE;


--
-- TOC entry 3925 (class 2606 OID 29892)
-- Name: presences presences_channel_id_fkey; Type: FK CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.presences
    ADD CONSTRAINT presences_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES realtime.channels(id) ON DELETE CASCADE;


--
-- TOC entry 3926 (class 2606 OID 29897)
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 3927 (class 2606 OID 29902)
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 3928 (class 2606 OID 29907)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 3929 (class 2606 OID 29912)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- TOC entry 4089 (class 0 OID 29558)
-- Dependencies: 270
-- Name: comments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.comments ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4091 (class 0 OID 29583)
-- Dependencies: 275
-- Name: podcasts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.podcasts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4090 (class 0 OID 29565)
-- Dependencies: 272
-- Name: posts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4092 (class 0 OID 29595)
-- Dependencies: 278
-- Name: settings; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.settings ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4088 (class 0 OID 29544)
-- Dependencies: 268
-- Name: users; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4093 (class 0 OID 29603)
-- Dependencies: 281
-- Name: broadcasts; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.broadcasts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4094 (class 0 OID 29607)
-- Dependencies: 283
-- Name: channels; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.channels ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4095 (class 0 OID 29611)
-- Dependencies: 285
-- Name: presences; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.presences ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4101 (class 3256 OID 29917)
-- Name: objects allow all 1tcrtt_0; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "allow all 1tcrtt_0" ON storage.objects FOR SELECT USING ((bucket_id = 'store'::text));


--
-- TOC entry 4102 (class 3256 OID 29918)
-- Name: objects allow all 1tcrtt_1; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "allow all 1tcrtt_1" ON storage.objects FOR INSERT WITH CHECK ((bucket_id = 'store'::text));


--
-- TOC entry 4103 (class 3256 OID 29919)
-- Name: objects allow all 1tcrtt_2; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "allow all 1tcrtt_2" ON storage.objects FOR UPDATE USING ((bucket_id = 'store'::text));


--
-- TOC entry 4104 (class 3256 OID 29920)
-- Name: objects allow all 1tcrtt_3; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "allow all 1tcrtt_3" ON storage.objects FOR DELETE USING ((bucket_id = 'store'::text));


--
-- TOC entry 4096 (class 0 OID 29627)
-- Dependencies: 290
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4097 (class 0 OID 29636)
-- Dependencies: 291
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4098 (class 0 OID 29640)
-- Dependencies: 292
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4099 (class 0 OID 29650)
-- Dependencies: 293
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4100 (class 0 OID 29657)
-- Dependencies: 294
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4105 (class 6104 OID 29921)
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- TOC entry 4152 (class 0 OID 0)
-- Dependencies: 12
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT ALL ON SCHEMA auth TO postgres;


--
-- TOC entry 4153 (class 0 OID 0)
-- Dependencies: 21
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- TOC entry 4155 (class 0 OID 0)
-- Dependencies: 20
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 4156 (class 0 OID 0)
-- Dependencies: 14
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- TOC entry 4157 (class 0 OID 0)
-- Dependencies: 22
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT ALL ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- TOC entry 4165 (class 0 OID 0)
-- Dependencies: 503
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;
GRANT ALL ON FUNCTION auth.email() TO postgres;


--
-- TOC entry 4166 (class 0 OID 0)
-- Dependencies: 504
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- TOC entry 4168 (class 0 OID 0)
-- Dependencies: 505
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;
GRANT ALL ON FUNCTION auth.role() TO postgres;


--
-- TOC entry 4170 (class 0 OID 0)
-- Dependencies: 506
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;
GRANT ALL ON FUNCTION auth.uid() TO postgres;


--
-- TOC entry 4171 (class 0 OID 0)
-- Dependencies: 486
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 4172 (class 0 OID 0)
-- Dependencies: 480
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- TOC entry 4173 (class 0 OID 0)
-- Dependencies: 481
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- TOC entry 4174 (class 0 OID 0)
-- Dependencies: 452
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- TOC entry 4175 (class 0 OID 0)
-- Dependencies: 482
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- TOC entry 4176 (class 0 OID 0)
-- Dependencies: 456
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4177 (class 0 OID 0)
-- Dependencies: 458
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4178 (class 0 OID 0)
-- Dependencies: 449
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- TOC entry 4179 (class 0 OID 0)
-- Dependencies: 448
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- TOC entry 4180 (class 0 OID 0)
-- Dependencies: 455
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4181 (class 0 OID 0)
-- Dependencies: 457
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4182 (class 0 OID 0)
-- Dependencies: 459
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- TOC entry 4183 (class 0 OID 0)
-- Dependencies: 460
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- TOC entry 4184 (class 0 OID 0)
-- Dependencies: 453
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- TOC entry 4185 (class 0 OID 0)
-- Dependencies: 454
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- TOC entry 4187 (class 0 OID 0)
-- Dependencies: 507
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- TOC entry 4189 (class 0 OID 0)
-- Dependencies: 508
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4191 (class 0 OID 0)
-- Dependencies: 509
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- TOC entry 4192 (class 0 OID 0)
-- Dependencies: 451
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4193 (class 0 OID 0)
-- Dependencies: 450
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- TOC entry 4194 (class 0 OID 0)
-- Dependencies: 447
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- TOC entry 4195 (class 0 OID 0)
-- Dependencies: 446
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- TOC entry 4196 (class 0 OID 0)
-- Dependencies: 445
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- TOC entry 4197 (class 0 OID 0)
-- Dependencies: 483
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- TOC entry 4198 (class 0 OID 0)
-- Dependencies: 479
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- TOC entry 4199 (class 0 OID 0)
-- Dependencies: 473
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4200 (class 0 OID 0)
-- Dependencies: 475
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4201 (class 0 OID 0)
-- Dependencies: 477
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4202 (class 0 OID 0)
-- Dependencies: 474
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4203 (class 0 OID 0)
-- Dependencies: 476
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4204 (class 0 OID 0)
-- Dependencies: 478
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4205 (class 0 OID 0)
-- Dependencies: 469
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- TOC entry 4206 (class 0 OID 0)
-- Dependencies: 471
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- TOC entry 4207 (class 0 OID 0)
-- Dependencies: 470
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4208 (class 0 OID 0)
-- Dependencies: 472
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4209 (class 0 OID 0)
-- Dependencies: 465
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- TOC entry 4210 (class 0 OID 0)
-- Dependencies: 467
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4211 (class 0 OID 0)
-- Dependencies: 466
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4212 (class 0 OID 0)
-- Dependencies: 468
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4213 (class 0 OID 0)
-- Dependencies: 461
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- TOC entry 4214 (class 0 OID 0)
-- Dependencies: 463
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- TOC entry 4215 (class 0 OID 0)
-- Dependencies: 462
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4216 (class 0 OID 0)
-- Dependencies: 464
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4217 (class 0 OID 0)
-- Dependencies: 510
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4218 (class 0 OID 0)
-- Dependencies: 511
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4220 (class 0 OID 0)
-- Dependencies: 512
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4221 (class 0 OID 0)
-- Dependencies: 487
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 4222 (class 0 OID 0)
-- Dependencies: 489
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;


--
-- TOC entry 4223 (class 0 OID 0)
-- Dependencies: 485
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;


--
-- TOC entry 4224 (class 0 OID 0)
-- Dependencies: 484
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;


--
-- TOC entry 4225 (class 0 OID 0)
-- Dependencies: 498
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- TOC entry 4226 (class 0 OID 0)
-- Dependencies: 499
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- TOC entry 4227 (class 0 OID 0)
-- Dependencies: 500
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4228 (class 0 OID 0)
-- Dependencies: 501
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- TOC entry 4229 (class 0 OID 0)
-- Dependencies: 502
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4230 (class 0 OID 0)
-- Dependencies: 493
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- TOC entry 4231 (class 0 OID 0)
-- Dependencies: 494
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- TOC entry 4232 (class 0 OID 0)
-- Dependencies: 496
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- TOC entry 4233 (class 0 OID 0)
-- Dependencies: 495
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- TOC entry 4234 (class 0 OID 0)
-- Dependencies: 497
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- TOC entry 4235 (class 0 OID 0)
-- Dependencies: 488
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 4236 (class 0 OID 0)
-- Dependencies: 545
-- Name: FUNCTION comment_directive(comment_ text); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO postgres;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO anon;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO authenticated;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO service_role;


--
-- TOC entry 4237 (class 0 OID 0)
-- Dependencies: 544
-- Name: FUNCTION exception(message text); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.exception(message text) TO postgres;
GRANT ALL ON FUNCTION graphql.exception(message text) TO anon;
GRANT ALL ON FUNCTION graphql.exception(message text) TO authenticated;
GRANT ALL ON FUNCTION graphql.exception(message text) TO service_role;


--
-- TOC entry 4238 (class 0 OID 0)
-- Dependencies: 547
-- Name: FUNCTION get_schema_version(); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.get_schema_version() TO postgres;
GRANT ALL ON FUNCTION graphql.get_schema_version() TO anon;
GRANT ALL ON FUNCTION graphql.get_schema_version() TO authenticated;
GRANT ALL ON FUNCTION graphql.get_schema_version() TO service_role;


--
-- TOC entry 4239 (class 0 OID 0)
-- Dependencies: 546
-- Name: FUNCTION increment_schema_version(); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.increment_schema_version() TO postgres;
GRANT ALL ON FUNCTION graphql.increment_schema_version() TO anon;
GRANT ALL ON FUNCTION graphql.increment_schema_version() TO authenticated;
GRANT ALL ON FUNCTION graphql.increment_schema_version() TO service_role;


--
-- TOC entry 4240 (class 0 OID 0)
-- Dependencies: 543
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- TOC entry 4241 (class 0 OID 0)
-- Dependencies: 297
-- Name: FUNCTION lo_export(oid, text); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_export(oid, text) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_export(oid, text) TO supabase_admin;


--
-- TOC entry 4242 (class 0 OID 0)
-- Dependencies: 296
-- Name: FUNCTION lo_import(text); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_import(text) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_import(text) TO supabase_admin;


--
-- TOC entry 4243 (class 0 OID 0)
-- Dependencies: 298
-- Name: FUNCTION lo_import(text, oid); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_import(text, oid) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_import(text, oid) TO supabase_admin;


--
-- TOC entry 4244 (class 0 OID 0)
-- Dependencies: 513
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: postgres
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- TOC entry 4245 (class 0 OID 0)
-- Dependencies: 412
-- Name: FUNCTION crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- TOC entry 4246 (class 0 OID 0)
-- Dependencies: 411
-- Name: FUNCTION crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- TOC entry 4247 (class 0 OID 0)
-- Dependencies: 394
-- Name: FUNCTION crypto_aead_det_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_keygen() TO service_role;


--
-- TOC entry 4248 (class 0 OID 0)
-- Dependencies: 514
-- Name: FUNCTION addcomment(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.addcomment() TO anon;
GRANT ALL ON FUNCTION public.addcomment() TO authenticated;
GRANT ALL ON FUNCTION public.addcomment() TO service_role;


--
-- TOC entry 4249 (class 0 OID 0)
-- Dependencies: 515
-- Name: FUNCTION checkpermission(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.checkpermission() TO anon;
GRANT ALL ON FUNCTION public.checkpermission() TO authenticated;
GRANT ALL ON FUNCTION public.checkpermission() TO service_role;


--
-- TOC entry 4250 (class 0 OID 0)
-- Dependencies: 516
-- Name: FUNCTION create_user_post_comment(p_email character varying, p_username character varying, p_name character varying, p_password character varying, p_post_title character varying, p_post_content text, p_comment_content text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.create_user_post_comment(p_email character varying, p_username character varying, p_name character varying, p_password character varying, p_post_title character varying, p_post_content text, p_comment_content text) TO anon;
GRANT ALL ON FUNCTION public.create_user_post_comment(p_email character varying, p_username character varying, p_name character varying, p_password character varying, p_post_title character varying, p_post_content text, p_comment_content text) TO authenticated;
GRANT ALL ON FUNCTION public.create_user_post_comment(p_email character varying, p_username character varying, p_name character varying, p_password character varying, p_post_title character varying, p_post_content text, p_comment_content text) TO service_role;


--
-- TOC entry 4251 (class 0 OID 0)
-- Dependencies: 517
-- Name: PROCEDURE create_user_with_post_and_comment(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_title character varying, IN p_post_content text, IN p_comment_content text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.create_user_with_post_and_comment(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_title character varying, IN p_post_content text, IN p_comment_content text) TO anon;
GRANT ALL ON PROCEDURE public.create_user_with_post_and_comment(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_title character varying, IN p_post_content text, IN p_comment_content text) TO authenticated;
GRANT ALL ON PROCEDURE public.create_user_with_post_and_comment(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_title character varying, IN p_post_content text, IN p_comment_content text) TO service_role;


--
-- TOC entry 4252 (class 0 OID 0)
-- Dependencies: 518
-- Name: PROCEDURE create_user_with_posts_and_comments(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_titles text[], IN p_post_contents text[], IN p_comment_contents text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.create_user_with_posts_and_comments(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_titles text[], IN p_post_contents text[], IN p_comment_contents text[]) TO anon;
GRANT ALL ON PROCEDURE public.create_user_with_posts_and_comments(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_titles text[], IN p_post_contents text[], IN p_comment_contents text[]) TO authenticated;
GRANT ALL ON PROCEDURE public.create_user_with_posts_and_comments(IN p_email character varying, IN p_username character varying, IN p_name character varying, IN p_password character varying, IN p_post_titles text[], IN p_post_contents text[], IN p_comment_contents text[]) TO service_role;


--
-- TOC entry 4253 (class 0 OID 0)
-- Dependencies: 519
-- Name: FUNCTION delcomment(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delcomment() TO anon;
GRANT ALL ON FUNCTION public.delcomment() TO authenticated;
GRANT ALL ON FUNCTION public.delcomment() TO service_role;


--
-- TOC entry 4254 (class 0 OID 0)
-- Dependencies: 520
-- Name: FUNCTION update_comment_type(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_comment_type() TO anon;
GRANT ALL ON FUNCTION public.update_comment_type() TO authenticated;
GRANT ALL ON FUNCTION public.update_comment_type() TO service_role;


--
-- TOC entry 4255 (class 0 OID 0)
-- Dependencies: 521
-- Name: PROCEDURE update_user_profile_pictures(IN new_profile_picture character varying); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.update_user_profile_pictures(IN new_profile_picture character varying) TO anon;
GRANT ALL ON PROCEDURE public.update_user_profile_pictures(IN new_profile_picture character varying) TO authenticated;
GRANT ALL ON PROCEDURE public.update_user_profile_pictures(IN new_profile_picture character varying) TO service_role;


--
-- TOC entry 4256 (class 0 OID 0)
-- Dependencies: 522
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4257 (class 0 OID 0)
-- Dependencies: 523
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- TOC entry 4258 (class 0 OID 0)
-- Dependencies: 524
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- TOC entry 4259 (class 0 OID 0)
-- Dependencies: 525
-- Name: FUNCTION channel_name(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.channel_name() TO postgres;
GRANT ALL ON FUNCTION realtime.channel_name() TO dashboard_user;


--
-- TOC entry 4260 (class 0 OID 0)
-- Dependencies: 526
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- TOC entry 4261 (class 0 OID 0)
-- Dependencies: 527
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- TOC entry 4262 (class 0 OID 0)
-- Dependencies: 528
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4263 (class 0 OID 0)
-- Dependencies: 529
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- TOC entry 4264 (class 0 OID 0)
-- Dependencies: 530
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- TOC entry 4265 (class 0 OID 0)
-- Dependencies: 531
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- TOC entry 4266 (class 0 OID 0)
-- Dependencies: 532
-- Name: FUNCTION can_insert_object(bucketid text, name text, owner uuid, metadata jsonb); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) TO postgres;


--
-- TOC entry 4267 (class 0 OID 0)
-- Dependencies: 533
-- Name: FUNCTION extension(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.extension(name text) TO postgres;


--
-- TOC entry 4268 (class 0 OID 0)
-- Dependencies: 534
-- Name: FUNCTION filename(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.filename(name text) TO postgres;


--
-- TOC entry 4269 (class 0 OID 0)
-- Dependencies: 535
-- Name: FUNCTION foldername(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.foldername(name text) TO postgres;


--
-- TOC entry 4270 (class 0 OID 0)
-- Dependencies: 536
-- Name: FUNCTION get_size_by_bucket(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.get_size_by_bucket() TO postgres;


--
-- TOC entry 4271 (class 0 OID 0)
-- Dependencies: 537
-- Name: FUNCTION list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) TO postgres;


--
-- TOC entry 4272 (class 0 OID 0)
-- Dependencies: 538
-- Name: FUNCTION list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) TO postgres;


--
-- TOC entry 4273 (class 0 OID 0)
-- Dependencies: 539
-- Name: FUNCTION search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) TO postgres;


--
-- TOC entry 4274 (class 0 OID 0)
-- Dependencies: 540
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.update_updated_at_column() TO postgres;


--
-- TOC entry 4276 (class 0 OID 0)
-- Dependencies: 251
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT ALL ON TABLE auth.audit_log_entries TO postgres;


--
-- TOC entry 4278 (class 0 OID 0)
-- Dependencies: 252
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.flow_state TO postgres;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- TOC entry 4281 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.identities TO postgres;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- TOC entry 4283 (class 0 OID 0)
-- Dependencies: 254
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT ALL ON TABLE auth.instances TO postgres;


--
-- TOC entry 4285 (class 0 OID 0)
-- Dependencies: 255
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.mfa_amr_claims TO postgres;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- TOC entry 4287 (class 0 OID 0)
-- Dependencies: 256
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.mfa_challenges TO postgres;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- TOC entry 4289 (class 0 OID 0)
-- Dependencies: 257
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.mfa_factors TO postgres;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- TOC entry 4290 (class 0 OID 0)
-- Dependencies: 258
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.one_time_tokens TO postgres;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- TOC entry 4292 (class 0 OID 0)
-- Dependencies: 259
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT ALL ON TABLE auth.refresh_tokens TO postgres;


--
-- TOC entry 4294 (class 0 OID 0)
-- Dependencies: 260
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- TOC entry 4296 (class 0 OID 0)
-- Dependencies: 261
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.saml_providers TO postgres;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- TOC entry 4298 (class 0 OID 0)
-- Dependencies: 262
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.saml_relay_states TO postgres;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- TOC entry 4300 (class 0 OID 0)
-- Dependencies: 263
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.schema_migrations TO dashboard_user;
GRANT ALL ON TABLE auth.schema_migrations TO postgres;


--
-- TOC entry 4303 (class 0 OID 0)
-- Dependencies: 264
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.sessions TO postgres;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- TOC entry 4305 (class 0 OID 0)
-- Dependencies: 265
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.sso_domains TO postgres;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- TOC entry 4308 (class 0 OID 0)
-- Dependencies: 266
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.sso_providers TO postgres;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- TOC entry 4311 (class 0 OID 0)
-- Dependencies: 267
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT ALL ON TABLE auth.users TO postgres;


--
-- TOC entry 4312 (class 0 OID 0)
-- Dependencies: 245
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- TOC entry 4313 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- TOC entry 4314 (class 0 OID 0)
-- Dependencies: 295
-- Name: SEQUENCE seq_schema_version; Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE graphql.seq_schema_version TO postgres;
GRANT ALL ON SEQUENCE graphql.seq_schema_version TO anon;
GRANT ALL ON SEQUENCE graphql.seq_schema_version TO authenticated;
GRANT ALL ON SEQUENCE graphql.seq_schema_version TO service_role;


--
-- TOC entry 4315 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE decrypted_key; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.decrypted_key TO pgsodium_keyholder;


--
-- TOC entry 4316 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE masking_rule; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.masking_rule TO pgsodium_keyholder;


--
-- TOC entry 4317 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE mask_columns; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.mask_columns TO pgsodium_keyholder;


--
-- TOC entry 4318 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO anon;
GRANT ALL ON TABLE public.users TO authenticated;
GRANT ALL ON TABLE public.users TO service_role;


--
-- TOC entry 4319 (class 0 OID 0)
-- Dependencies: 269
-- Name: TABLE admins; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.admins TO anon;
GRANT ALL ON TABLE public.admins TO authenticated;
GRANT ALL ON TABLE public.admins TO service_role;


--
-- TOC entry 4320 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE comments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.comments TO anon;
GRANT ALL ON TABLE public.comments TO authenticated;
GRANT ALL ON TABLE public.comments TO service_role;


--
-- TOC entry 4321 (class 0 OID 0)
-- Dependencies: 271
-- Name: SEQUENCE comments_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.comments_id_seq TO anon;
GRANT ALL ON SEQUENCE public.comments_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.comments_id_seq TO service_role;


--
-- TOC entry 4322 (class 0 OID 0)
-- Dependencies: 272
-- Name: TABLE posts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.posts TO anon;
GRANT ALL ON TABLE public.posts TO authenticated;
GRANT ALL ON TABLE public.posts TO service_role;


--
-- TOC entry 4323 (class 0 OID 0)
-- Dependencies: 273
-- Name: TABLE discussions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.discussions TO anon;
GRANT ALL ON TABLE public.discussions TO authenticated;
GRANT ALL ON TABLE public.discussions TO service_role;


--
-- TOC entry 4324 (class 0 OID 0)
-- Dependencies: 274
-- Name: TABLE news; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.news TO anon;
GRANT ALL ON TABLE public.news TO authenticated;
GRANT ALL ON TABLE public.news TO service_role;


--
-- TOC entry 4325 (class 0 OID 0)
-- Dependencies: 275
-- Name: TABLE podcasts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.podcasts TO anon;
GRANT ALL ON TABLE public.podcasts TO authenticated;
GRANT ALL ON TABLE public.podcasts TO service_role;


--
-- TOC entry 4326 (class 0 OID 0)
-- Dependencies: 276
-- Name: SEQUENCE podcasts_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.podcasts_id_seq TO anon;
GRANT ALL ON SEQUENCE public.podcasts_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.podcasts_id_seq TO service_role;


--
-- TOC entry 4327 (class 0 OID 0)
-- Dependencies: 277
-- Name: SEQUENCE posts_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.posts_id_seq TO anon;
GRANT ALL ON SEQUENCE public.posts_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.posts_id_seq TO service_role;


--
-- TOC entry 4328 (class 0 OID 0)
-- Dependencies: 278
-- Name: TABLE settings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.settings TO anon;
GRANT ALL ON TABLE public.settings TO authenticated;
GRANT ALL ON TABLE public.settings TO service_role;


--
-- TOC entry 4329 (class 0 OID 0)
-- Dependencies: 279
-- Name: SEQUENCE settings_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.settings_id_seq TO anon;
GRANT ALL ON SEQUENCE public.settings_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.settings_id_seq TO service_role;


--
-- TOC entry 4330 (class 0 OID 0)
-- Dependencies: 280
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.users_id_seq TO anon;
GRANT ALL ON SEQUENCE public.users_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.users_id_seq TO service_role;


--
-- TOC entry 4331 (class 0 OID 0)
-- Dependencies: 281
-- Name: TABLE broadcasts; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.broadcasts TO postgres;
GRANT ALL ON TABLE realtime.broadcasts TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.broadcasts TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.broadcasts TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.broadcasts TO service_role;


--
-- TOC entry 4333 (class 0 OID 0)
-- Dependencies: 282
-- Name: SEQUENCE broadcasts_id_seq; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON SEQUENCE realtime.broadcasts_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.broadcasts_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.broadcasts_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.broadcasts_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.broadcasts_id_seq TO service_role;


--
-- TOC entry 4334 (class 0 OID 0)
-- Dependencies: 283
-- Name: TABLE channels; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.channels TO postgres;
GRANT ALL ON TABLE realtime.channels TO dashboard_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE realtime.channels TO anon;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE realtime.channels TO authenticated;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE realtime.channels TO service_role;


--
-- TOC entry 4336 (class 0 OID 0)
-- Dependencies: 284
-- Name: SEQUENCE channels_id_seq; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON SEQUENCE realtime.channels_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.channels_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.channels_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.channels_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.channels_id_seq TO service_role;


--
-- TOC entry 4337 (class 0 OID 0)
-- Dependencies: 285
-- Name: TABLE presences; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.presences TO postgres;
GRANT ALL ON TABLE realtime.presences TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.presences TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.presences TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.presences TO service_role;


--
-- TOC entry 4339 (class 0 OID 0)
-- Dependencies: 286
-- Name: SEQUENCE presences_id_seq; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON SEQUENCE realtime.presences_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.presences_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.presences_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.presences_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.presences_id_seq TO service_role;


--
-- TOC entry 4340 (class 0 OID 0)
-- Dependencies: 287
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- TOC entry 4341 (class 0 OID 0)
-- Dependencies: 288
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- TOC entry 4342 (class 0 OID 0)
-- Dependencies: 289
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- TOC entry 4344 (class 0 OID 0)
-- Dependencies: 290
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres;


--
-- TOC entry 4345 (class 0 OID 0)
-- Dependencies: 291
-- Name: TABLE migrations; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.migrations TO anon;
GRANT ALL ON TABLE storage.migrations TO authenticated;
GRANT ALL ON TABLE storage.migrations TO service_role;
GRANT ALL ON TABLE storage.migrations TO postgres;


--
-- TOC entry 4347 (class 0 OID 0)
-- Dependencies: 292
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres;


--
-- TOC entry 4348 (class 0 OID 0)
-- Dependencies: 293
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;
GRANT ALL ON TABLE storage.s3_multipart_uploads TO postgres;


--
-- TOC entry 4349 (class 0 OID 0)
-- Dependencies: 294
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;
GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO postgres;


--
-- TOC entry 2547 (class 826 OID 29928)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2548 (class 826 OID 29929)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2546 (class 826 OID 29930)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 2568 (class 826 OID 29931)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2567 (class 826 OID 29932)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- TOC entry 2565 (class 826 OID 29933)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2572 (class 826 OID 29934)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2571 (class 826 OID 29935)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2570 (class 826 OID 29936)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2558 (class 826 OID 29937)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2561 (class 826 OID 29938)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2559 (class 826 OID 29939)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2552 (class 826 OID 29083)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON SEQUENCES TO pgsodium_keyholder;


--
-- TOC entry 2553 (class 826 OID 29082)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON TABLES TO pgsodium_keyholder;


--
-- TOC entry 2554 (class 826 OID 29080)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON SEQUENCES TO pgsodium_keyiduser;


--
-- TOC entry 2555 (class 826 OID 29081)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON FUNCTIONS TO pgsodium_keyiduser;


--
-- TOC entry 2556 (class 826 OID 29079)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON TABLES TO pgsodium_keyiduser;


--
-- TOC entry 2557 (class 826 OID 29940)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2560 (class 826 OID 29941)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2562 (class 826 OID 29942)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2563 (class 826 OID 29943)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2564 (class 826 OID 29944)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2566 (class 826 OID 29945)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2550 (class 826 OID 29946)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2551 (class 826 OID 29947)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2549 (class 826 OID 29948)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 2569 (class 826 OID 29949)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2544 (class 826 OID 29950)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2545 (class 826 OID 29951)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 3686 (class 3466 OID 29964)
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- TOC entry 3691 (class 3466 OID 30002)
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- TOC entry 3685 (class 3466 OID 29963)
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- TOC entry 3684 (class 3466 OID 29955)
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO postgres;

--
-- TOC entry 3687 (class 3466 OID 29965)
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- TOC entry 3688 (class 3466 OID 29966)
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

-- Completed on 2024-06-10 08:33:59

--
-- PostgreSQL database dump complete
--

