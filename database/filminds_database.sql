--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.2

-- Started on 2019-06-06 18:55:18 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 227 (class 1259 OID 17005)
-- Name: app_collectedmovie; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.app_collectedmovie (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    type character varying(2) NOT NULL,
    movie_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.app_collectedmovie OWNER TO filminds;

--
-- TOC entry 226 (class 1259 OID 17003)
-- Name: app_collectedmovie_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.app_collectedmovie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_collectedmovie_id_seq OWNER TO filminds;

--
-- TOC entry 3387 (class 0 OID 0)
-- Dependencies: 226
-- Name: app_collectedmovie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.app_collectedmovie_id_seq OWNED BY public.app_collectedmovie.id;


--
-- TOC entry 229 (class 1259 OID 17025)
-- Name: app_expertpickmovie; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.app_expertpickmovie (
    id integer NOT NULL,
    "order" integer NOT NULL,
    category_id integer NOT NULL,
    movie_id integer NOT NULL
);


ALTER TABLE public.app_expertpickmovie OWNER TO filminds;

--
-- TOC entry 228 (class 1259 OID 17023)
-- Name: app_expertpickmovie_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.app_expertpickmovie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_expertpickmovie_id_seq OWNER TO filminds;

--
-- TOC entry 3388 (class 0 OID 0)
-- Dependencies: 228
-- Name: app_expertpickmovie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.app_expertpickmovie_id_seq OWNED BY public.app_expertpickmovie.id;


--
-- TOC entry 223 (class 1259 OID 16971)
-- Name: app_expertpickscategory; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.app_expertpickscategory (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    expert_id integer
);


ALTER TABLE public.app_expertpickscategory OWNER TO filminds;

--
-- TOC entry 222 (class 1259 OID 16969)
-- Name: app_expertpickscategory_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.app_expertpickscategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_expertpickscategory_id_seq OWNER TO filminds;

--
-- TOC entry 3389 (class 0 OID 0)
-- Dependencies: 222
-- Name: app_expertpickscategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.app_expertpickscategory_id_seq OWNED BY public.app_expertpickscategory.id;


--
-- TOC entry 217 (class 1259 OID 16922)
-- Name: app_message; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.app_message (
    id integer NOT NULL,
    sender_type character varying(1) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    content jsonb NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.app_message OWNER TO filminds;

--
-- TOC entry 216 (class 1259 OID 16920)
-- Name: app_message_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.app_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_message_id_seq OWNER TO filminds;

--
-- TOC entry 3390 (class 0 OID 0)
-- Dependencies: 216
-- Name: app_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.app_message_id_seq OWNED BY public.app_message.id;


--
-- TOC entry 219 (class 1259 OID 16942)
-- Name: app_movie; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.app_movie (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    description character varying(300) NOT NULL,
    rating numeric(3,1) NOT NULL,
    release_date date NOT NULL,
    trailer character varying(70),
    backdrop character varying(50),
    poster character varying(50)
);


ALTER TABLE public.app_movie OWNER TO filminds;

--
-- TOC entry 221 (class 1259 OID 16949)
-- Name: app_movie_genres; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.app_movie_genres (
    id integer NOT NULL,
    movie_id integer NOT NULL,
    moviegenre_id integer NOT NULL
);


ALTER TABLE public.app_movie_genres OWNER TO filminds;

--
-- TOC entry 220 (class 1259 OID 16947)
-- Name: app_movie_genres_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.app_movie_genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_movie_genres_id_seq OWNER TO filminds;

--
-- TOC entry 3391 (class 0 OID 0)
-- Dependencies: 220
-- Name: app_movie_genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.app_movie_genres_id_seq OWNED BY public.app_movie_genres.id;


--
-- TOC entry 218 (class 1259 OID 16937)
-- Name: app_moviegenre; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.app_moviegenre (
    id integer NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.app_moviegenre OWNER TO filminds;

--
-- TOC entry 225 (class 1259 OID 16985)
-- Name: app_searchedmovie; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.app_searchedmovie (
    id integer NOT NULL,
    count integer NOT NULL,
    movie_id integer NOT NULL,
    user_id integer
);


ALTER TABLE public.app_searchedmovie OWNER TO filminds;

--
-- TOC entry 224 (class 1259 OID 16983)
-- Name: app_searchedmovie_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.app_searchedmovie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_searchedmovie_id_seq OWNER TO filminds;

--
-- TOC entry 3392 (class 0 OID 0)
-- Dependencies: 224
-- Name: app_searchedmovie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.app_searchedmovie_id_seq OWNED BY public.app_searchedmovie.id;


--
-- TOC entry 215 (class 1259 OID 16907)
-- Name: app_user; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.app_user (
    id integer NOT NULL,
    type character varying(1) NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.app_user OWNER TO filminds;

--
-- TOC entry 214 (class 1259 OID 16905)
-- Name: app_user_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.app_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_user_id_seq OWNER TO filminds;

--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 214
-- Name: app_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.app_user_id_seq OWNED BY public.app_user.id;


--
-- TOC entry 203 (class 1259 OID 16787)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO filminds;

--
-- TOC entry 202 (class 1259 OID 16785)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO filminds;

--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 202
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- TOC entry 205 (class 1259 OID 16797)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO filminds;

--
-- TOC entry 204 (class 1259 OID 16795)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO filminds;

--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 204
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- TOC entry 201 (class 1259 OID 16779)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO filminds;

--
-- TOC entry 200 (class 1259 OID 16777)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO filminds;

--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 200
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- TOC entry 207 (class 1259 OID 16805)
-- Name: auth_user; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO filminds;

--
-- TOC entry 209 (class 1259 OID 16815)
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO filminds;

--
-- TOC entry 208 (class 1259 OID 16813)
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO filminds;

--
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 208
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- TOC entry 206 (class 1259 OID 16803)
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO filminds;

--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 206
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- TOC entry 211 (class 1259 OID 16823)
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO filminds;

--
-- TOC entry 210 (class 1259 OID 16821)
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO filminds;

--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 210
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- TOC entry 213 (class 1259 OID 16883)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO filminds;

--
-- TOC entry 212 (class 1259 OID 16881)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO filminds;

--
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 212
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- TOC entry 199 (class 1259 OID 16769)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO filminds;

--
-- TOC entry 198 (class 1259 OID 16767)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO filminds;

--
-- TOC entry 3401 (class 0 OID 0)
-- Dependencies: 198
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- TOC entry 197 (class 1259 OID 16758)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO filminds;

--
-- TOC entry 196 (class 1259 OID 16756)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: filminds
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO filminds;

--
-- TOC entry 3402 (class 0 OID 0)
-- Dependencies: 196
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: filminds
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- TOC entry 230 (class 1259 OID 17067)
-- Name: django_session; Type: TABLE; Schema: public; Owner: filminds
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO filminds;

--
-- TOC entry 3125 (class 2604 OID 17008)
-- Name: app_collectedmovie id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_collectedmovie ALTER COLUMN id SET DEFAULT nextval('public.app_collectedmovie_id_seq'::regclass);


--
-- TOC entry 3126 (class 2604 OID 17028)
-- Name: app_expertpickmovie id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_expertpickmovie ALTER COLUMN id SET DEFAULT nextval('public.app_expertpickmovie_id_seq'::regclass);


--
-- TOC entry 3123 (class 2604 OID 16974)
-- Name: app_expertpickscategory id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_expertpickscategory ALTER COLUMN id SET DEFAULT nextval('public.app_expertpickscategory_id_seq'::regclass);


--
-- TOC entry 3121 (class 2604 OID 16925)
-- Name: app_message id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_message ALTER COLUMN id SET DEFAULT nextval('public.app_message_id_seq'::regclass);


--
-- TOC entry 3122 (class 2604 OID 16952)
-- Name: app_movie_genres id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_movie_genres ALTER COLUMN id SET DEFAULT nextval('public.app_movie_genres_id_seq'::regclass);


--
-- TOC entry 3124 (class 2604 OID 16988)
-- Name: app_searchedmovie id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_searchedmovie ALTER COLUMN id SET DEFAULT nextval('public.app_searchedmovie_id_seq'::regclass);


--
-- TOC entry 3120 (class 2604 OID 16910)
-- Name: app_user id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_user ALTER COLUMN id SET DEFAULT nextval('public.app_user_id_seq'::regclass);


--
-- TOC entry 3113 (class 2604 OID 16790)
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- TOC entry 3114 (class 2604 OID 16800)
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- TOC entry 3112 (class 2604 OID 16782)
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- TOC entry 3115 (class 2604 OID 16808)
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- TOC entry 3116 (class 2604 OID 16818)
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- TOC entry 3117 (class 2604 OID 16826)
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- TOC entry 3118 (class 2604 OID 16886)
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- TOC entry 3111 (class 2604 OID 16772)
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- TOC entry 3110 (class 2604 OID 16761)
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- TOC entry 3378 (class 0 OID 17005)
-- Dependencies: 227
-- Data for Name: app_collectedmovie; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.app_collectedmovie (id, date, type, movie_id, user_id) FROM stdin;
2	2019-06-04 22:31:56.742821+02	WA	504608	9
3	2019-06-04 22:32:00.077718+02	WI	438650	9
4	2019-06-04 22:32:35.758498+02	WI	529962	9
5	2019-06-04 22:33:36.744008+02	WI	245891	9
6	2019-06-04 22:33:40.249833+02	WA	87101	9
7	2019-06-04 22:33:42.063666+02	WI	177572	9
8	2019-06-04 22:33:44.362074+02	WI	150540	9
9	2019-06-04 22:35:50.206826+02	WI	299537	10
10	2019-06-04 22:35:51.82069+02	WI	458156	10
11	2019-06-04 22:35:53.144917+02	WI	299534	10
12	2019-06-04 22:35:54.369819+02	WI	529983	10
13	2019-06-04 22:36:13.339581+02	WI	412117	10
14	2019-06-04 22:36:19.199338+02	WA	447404	10
15	2019-06-04 22:36:43.081371+02	WI	18785	10
16	2019-06-04 22:37:00.307995+02	WA	813	10
17	2019-06-04 22:37:02.269018+02	WA	41154	10
18	2019-06-04 22:38:08.89267+02	WI	578	11
19	2019-06-04 22:38:17.207911+02	WA	2668	11
20	2019-06-04 22:38:39.687517+02	WA	420817	11
21	2019-06-04 22:38:47.175723+02	WI	299537	11
22	2019-06-04 22:38:49.255598+02	WI	412117	11
23	2019-06-04 22:38:51.651618+02	WI	299536	11
24	2019-06-04 22:38:52.738459+02	WI	287947	11
25	2019-06-04 22:39:59.527679+02	WI	15144	12
26	2019-06-04 22:40:06.443739+02	WI	11130	12
27	2019-06-04 22:40:30.122081+02	WI	412117	12
28	2019-06-04 22:40:37.031551+02	WI	920	12
29	2019-06-04 22:40:38.571314+02	WA	513576	12
30	2019-06-04 22:40:47.450188+02	WA	535581	12
31	2019-06-04 22:40:49.599045+02	WI	324857	12
1	2019-06-06 18:52:22.281134+02	WA	420817	9
32	2019-06-06 18:52:35.11947+02	WA	420817	10
33	2019-06-06 18:53:06.177566+02	WA	447404	12
\.


--
-- TOC entry 3380 (class 0 OID 17025)
-- Dependencies: 229
-- Data for Name: app_expertpickmovie; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.app_expertpickmovie (id, "order", category_id, movie_id) FROM stdin;
11	1	4	603
12	2	4	627
13	3	4	562
14	4	4	680
15	5	4	607
26	1	1	420817
27	2	1	299534
28	3	1	447404
29	4	1	529983
30	5	1	373571
46	1	3	238
47	2	3	770
48	3	3	289
49	4	3	164
50	5	3	439
51	6	3	654
62	1	2	426426
63	2	2	375262
64	3	2	324857
65	4	2	465914
66	5	2	429197
\.


--
-- TOC entry 3374 (class 0 OID 16971)
-- Dependencies: 223
-- Data for Name: app_expertpickscategory; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.app_expertpickscategory (id, name, expert_id) FROM stdin;
4	90's picks	5
1	Best of 2019	6
3	Classics	7
2	Oscar picks	8
5	Best picture	\N
6	Trending	\N
\.


--
-- TOC entry 3368 (class 0 OID 16922)
-- Dependencies: 217
-- Data for Name: app_message; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.app_message (id, sender_type, "timestamp", content, user_id) FROM stdin;
1	U	2019-06-04 21:25:40.070383+02	{"messages": [{"type": "text", "content": "Recommend me a movie released from 1990 to 2000"}]}	5
2	B	2019-06-04 21:25:42.247458+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 603, "title": "The Matrix", "backdrop": "https://image.tmdb.org/t/p/w400/icmmSD4vTTDKOq2vvdulafOGw93.jpg", "overview": "Set in the 22nd century, The Matrix tells the story of a computer hacker who joins a group of underground insurgents fighting the vast and powerful computers who now rule the earth."}, {"id": 627, "title": "Trainspotting", "backdrop": "https://image.tmdb.org/t/p/w400/Aw0z8bUhGljT0ots6udf1MTLEMi.jpg", "overview": "Mark Renton, deeply immersed in the Edinburgh drug scene, tries to clean up and get out, despite the allure of the drugs and influence of friends."}, {"id": 8392, "title": "My Neighbor Totoro", "backdrop": "https://image.tmdb.org/t/p/w400/fYU3ckVE1zECs42ZO0uSoJpwlXi.jpg", "overview": "Two sisters move to the country with their father in order to be closer to their hospitalized mother, and discover the surrounding trees are inhabited by Totoros, magical spirits of the forest. When the youngest runs away from home, the older sister seeks help from the spirits to find her."}, {"id": 710, "title": "GoldenEye", "backdrop": "https://image.tmdb.org/t/p/w400/dA9I0Vd9OZzRQ2GyGcsFXdKGMz3.jpg", "overview": "James Bond must unmask the mysterious head of the Janus Syndicate and prevent the leader from utilizing the GoldenEye weapons system to inflict devastating revenge on Britain."}, {"id": 562, "title": "Die Hard", "backdrop": "https://image.tmdb.org/t/p/w400/eg049B1TJdWuKuyKowNmhZxNToc.jpg", "overview": "NYPD cop John McClane's plan to reconcile with his estranged wife is thrown for a serious loop when, minutes after he arrives at her office, the entire building is overtaken by a group of terrorists."}, {"id": 11, "title": "Star Wars", "backdrop": "https://image.tmdb.org/t/p/w400/4iJfYYoQzZcONB9hNzg0J0wWyPH.jpg", "overview": "Princess Leia is captured and held hostage by the evil Imperial forces in their effort to take over the galactic Empire."}, {"id": 607, "title": "Men in Black", "backdrop": "https://image.tmdb.org/t/p/w400/agCihVGrXk3hmmwMIgsn2ao1eEa.jpg", "overview": "After a police chase with an otherworldly being, a New York City cop is recruited as an agent in a top-secret organization established to monitor and police alien activity on Earth: the Men in Black."}, {"id": 364, "title": "Batman Returns", "backdrop": "https://image.tmdb.org/t/p/w400/wNIE5dpkiHU2csDRptMutFjAGiV.jpg", "overview": "Having defeated the Joker, Batman now faces the Penguin - a warped and deformed individual who is intent on being accepted into Gotham society. Crooked businessman Max Schreck is coerced into helping him become Mayor of Gotham and they both attempt to expose Batman in a different light."}, {"id": 680, "title": "Pulp Fiction", "backdrop": "https://image.tmdb.org/t/p/w400/4cDFJr4HnXN5AdPw4AKrmLlMWdO.jpg", "overview": "A burger-loving hit man, his philosophical partner, a drug-addled gangster's moll and a washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories that ingeniously trip back and forth in time."}]}]}	5
3	U	2019-06-04 21:31:18.342543+02	{"messages": [{"type": "text", "content": "Recommend me movie released in 2019"}]}	6
4	B	2019-06-04 21:31:19.60044+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 420817, "title": "Aladdin", "backdrop": "https://image.tmdb.org/t/p/w400/v4yVTbbl8dE1UP2dWu5CLyaXOku.jpg", "overview": "A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecracking genie while a power-hungry Grand Vizier vies for the same lamp that has the power to make their deepest wishes come true."}, {"id": 299537, "title": "Captain Marvel", "backdrop": "https://image.tmdb.org/t/p/w400/iNUuGUIHeeGsvOPxMRBnytpxxlz.jpg", "overview": "The story follows Carol Danvers as she becomes one of the universe’s most powerful heroes when Earth is caught in the middle of a galactic war between two alien races."}, {"id": 458156, "title": "John Wick: Chapter 3 – Parabellum", "backdrop": "https://image.tmdb.org/t/p/w400/vVpEOvdxVBP2aV166j5Xlvb5Cdc.jpg", "overview": "Super-assassin John Wick returns with a $14 million price tag on his head and an army of bounty-hunting killers on his trail."}, {"id": 373571, "title": "Godzilla: King of the Monsters", "backdrop": "https://image.tmdb.org/t/p/w400/mzRJpkWPjXdXak0WCc8ZxVH4hug.jpg", "overview": "The new story follows the heroic efforts of the crypto-zoological agency Monarch as its members face off against a battery of god-sized monsters, including the mighty Godzilla, who collides with Mothra, Rodan, and his ultimate nemesis, the three-headed King Ghidorah."}, {"id": 299534, "title": "Avengers: Endgame", "backdrop": "https://image.tmdb.org/t/p/w400/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg", "overview": "After the devastating events of Avengers: Infinity War, the universe is in ruins due to the efforts of the Mad Titan, Thanos."}, {"id": 529983, "title": "The Poison Rose", "backdrop": "https://image.tmdb.org/t/p/w400/3foyl4i78mZoeBb8EQ0RR5axu01.jpg", "overview": "A down-on-his-luck PI is hired by his old flame to investigate a murder. But while the case at first appears routine, it slowly reveals itself to be a complex interwoven web of crimes, suspects and dead bodies."}, {"id": 412117, "title": "The Secret Life of Pets 2", "backdrop": "https://image.tmdb.org/t/p/w400/etaok7q2E5tV36oXe7GQzhUQ4fX.jpg", "overview": "What happens with our pets when we’re not home? This movie continues the original movie with Max and his friends."}, {"id": 287947, "title": "Shazam!", "backdrop": "https://image.tmdb.org/t/p/w400/bi4jh0Kt0uuZGsGJoUUfqmbrjQg.jpg", "overview": "A boy is given the ability to become an adult superhero in times of need with a single magic word."}, {"id": 447404, "title": "Pokémon Detective Pikachu", "backdrop": "https://image.tmdb.org/t/p/w400/nDP33LmQwNsnPv29GQazz59HjJI.jpg", "overview": "In a world where people collect pocket-size monsters (Pokémon) to do battle, a boy comes across an intelligent monster who seeks to be a detective."}]}]}	6
5	U	2019-06-04 21:49:18.561084+02	{"messages": [{"type": "text", "content": "Recommend me movies from 2018 to 2019"}]}	8
6	B	2019-06-04 21:49:20.003245+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 420817, "title": "Aladdin", "backdrop": "https://image.tmdb.org/t/p/w400/v4yVTbbl8dE1UP2dWu5CLyaXOku.jpg", "overview": "A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecracking genie while a power-hungry Grand Vizier vies for the same lamp that has the power to make their deepest wishes come true."}, {"id": 299537, "title": "Captain Marvel", "backdrop": "https://image.tmdb.org/t/p/w400/iNUuGUIHeeGsvOPxMRBnytpxxlz.jpg", "overview": "The story follows Carol Danvers as she becomes one of the universe’s most powerful heroes when Earth is caught in the middle of a galactic war between two alien races."}, {"id": 458156, "title": "John Wick: Chapter 3 – Parabellum", "backdrop": "https://image.tmdb.org/t/p/w400/vVpEOvdxVBP2aV166j5Xlvb5Cdc.jpg", "overview": "Super-assassin John Wick returns with a $14 million price tag on his head and an army of bounty-hunting killers on his trail."}, {"id": 373571, "title": "Godzilla: King of the Monsters", "backdrop": "https://image.tmdb.org/t/p/w400/mzRJpkWPjXdXak0WCc8ZxVH4hug.jpg", "overview": "The new story follows the heroic efforts of the crypto-zoological agency Monarch as its members face off against a battery of god-sized monsters, including the mighty Godzilla, who collides with Mothra, Rodan, and his ultimate nemesis, the three-headed King Ghidorah."}, {"id": 299534, "title": "Avengers: Endgame", "backdrop": "https://image.tmdb.org/t/p/w400/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg", "overview": "After the devastating events of Avengers: Infinity War, the universe is in ruins due to the efforts of the Mad Titan, Thanos."}, {"id": 529983, "title": "The Poison Rose", "backdrop": "https://image.tmdb.org/t/p/w400/3foyl4i78mZoeBb8EQ0RR5axu01.jpg", "overview": "A down-on-his-luck PI is hired by his old flame to investigate a murder. But while the case at first appears routine, it slowly reveals itself to be a complex interwoven web of crimes, suspects and dead bodies."}, {"id": 412117, "title": "The Secret Life of Pets 2", "backdrop": "https://image.tmdb.org/t/p/w400/etaok7q2E5tV36oXe7GQzhUQ4fX.jpg", "overview": "What happens with our pets when we’re not home? This movie continues the original movie with Max and his friends."}, {"id": 299536, "title": "Avengers: Infinity War", "backdrop": "https://image.tmdb.org/t/p/w400/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg", "overview": "As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos."}, {"id": 287947, "title": "Shazam!", "backdrop": "https://image.tmdb.org/t/p/w400/bi4jh0Kt0uuZGsGJoUUfqmbrjQg.jpg", "overview": "A boy is given the ability to become an adult superhero in times of need with a single magic word."}]}]}	8
7	U	2019-06-04 21:49:35.302588+02	{"messages": [{"type": "text", "content": "Recommend me drama"}]}	8
8	B	2019-06-04 21:49:36.49736+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 531309, "title": "Brightburn", "backdrop": "https://image.tmdb.org/t/p/w400/uHEI6v8ApQusjbaRZ8o7WcLYeWb.jpg", "overview": "What if a child from another world crash-landed on Earth, but instead of becoming a hero to mankind, he proved to be something far more sinister?"}, {"id": 504608, "title": "Rocketman", "backdrop": "https://image.tmdb.org/t/p/w400/oAr5bgf49vxga9etWoQpAeRMvhp.jpg", "overview": "The story of Elton John's life, from his years as a prodigy at the Royal Academy of Music through his influential and enduring musical partnership with Bernie Taupin."}, {"id": 438650, "title": "Cold Pursuit", "backdrop": "https://image.tmdb.org/t/p/w400/aiM3XxYE2JvW1vJ4AC6cI1RjAoT.jpg", "overview": "The quiet family life of Nels Coxman, a snowplow driver, is upended after his son's murder. Nels begins a vengeful hunt for Viking, the drug lord he holds responsible for the killing, eliminating Viking's associates one by one."}, {"id": 529962, "title": "The Perfection", "backdrop": "https://image.tmdb.org/t/p/w400/99LvuMDXJ6A6I7FW61OvjDjvvAx.jpg", "overview": "When troubled musical prodigy Charlotte seeks out Elizabeth, the new star pupil of her former school, the encounter sends both musicians down a sinister path with shocking consequences."}, {"id": 566555, "title": "Detective Conan: The Fist of Blue Sapphire", "backdrop": "https://image.tmdb.org/t/p/w400/wf6VDSi4aFCZfuD8sX8JAKLfJ5m.jpg", "overview": "23rd Detective Conan Movie."}, {"id": 450465, "title": "Glass", "backdrop": "https://image.tmdb.org/t/p/w400/rL1ITQuX0lmSNPu52pRRHUyim5N.jpg", "overview": "In a series of escalating encounters, security guard David Dunn uses his supernatural abilities to track Kevin Wendell Crumb, a disturbed man who has twenty-four personalities. Meanwhile, the shadowy presence of Elijah Price emerges as an orchestrator who holds secrets critical to both men."}, {"id": 537915, "title": "After", "backdrop": "https://image.tmdb.org/t/p/w400/997ToEZvF2Obp9zNZbY5ELVnmrW.jpg", "overview": "A young woman falls for a guy with a dark secret and the two embark on a rocky relationship."}, {"id": 505600, "title": "Booksmart", "backdrop": "https://image.tmdb.org/t/p/w400/wcAqndL2MkIjPrCrYeuE794weNE.jpg", "overview": "Two academic teenage superstars realize, on the eve of their high school graduation, that they should have worked less and played more. Determined to never fall short of their peers, the girls set out on a mission to cram four years of fun into one night."}, {"id": 124905, "title": "Godzilla", "backdrop": "https://image.tmdb.org/t/p/w400/2WKcxQbTVkLUgoS5kPnHlecbj02.jpg", "overview": "Ford Brody, a Navy bomb expert, has just reunited with his family in San Francisco when he is forced to go to Japan to help his estranged father, Joe."}]}]}	8
9	U	2019-06-04 22:30:05.908742+02	{"messages": [{"type": "text", "content": "Recommend me a comedy"}]}	9
10	B	2019-06-04 22:30:07.319122+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 420817, "title": "Aladdin", "backdrop": "https://image.tmdb.org/t/p/w400/v4yVTbbl8dE1UP2dWu5CLyaXOku.jpg", "overview": "A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecracking genie while a power-hungry Grand Vizier vies for the same lamp that has the power to make their deepest wishes come true."}, {"id": 412117, "title": "The Secret Life of Pets 2", "backdrop": "https://image.tmdb.org/t/p/w400/etaok7q2E5tV36oXe7GQzhUQ4fX.jpg", "overview": "What happens with our pets when we’re not home? This movie continues the original movie with Max and his friends."}, {"id": 287947, "title": "Shazam!", "backdrop": "https://image.tmdb.org/t/p/w400/bi4jh0Kt0uuZGsGJoUUfqmbrjQg.jpg", "overview": "A boy is given the ability to become an adult superhero in times of need with a single magic word."}, {"id": 447404, "title": "Pokémon Detective Pikachu", "backdrop": "https://image.tmdb.org/t/p/w400/nDP33LmQwNsnPv29GQazz59HjJI.jpg", "overview": "In a world where people collect pocket-size monsters (Pokémon) to do battle, a boy comes across an intelligent monster who seeks to be a detective."}, {"id": 920, "title": "Cars", "backdrop": "https://image.tmdb.org/t/p/w400/a1MlbLBk5Sy6YvMbSuKfwGlDVlb.jpg", "overview": "Lightning McQueen, a hotshot rookie race car driven to succeed, discovers that life is about the journey, not the finish line, when he finds himself unexpectedly detoured in the sleepy Route 66 town of Radiator Springs."}, {"id": 513576, "title": "Always Be My Maybe", "backdrop": "https://image.tmdb.org/t/p/w400/gacFeoGjwAJAsbrd90hD5ptcjoe.jpg", "overview": "Reunited after 15 years, famous chef Sasha and hometown musician Marcus feel the old sparks of attraction but struggle to adapt to each other's worlds."}, {"id": 535581, "title": "The Dead Don't Die", "backdrop": "https://image.tmdb.org/t/p/w400/cXyfAViYly0Lk2CVpEKgYbt9wKQ.jpg", "overview": "In a small peaceful town, zombies suddenly rise to terrorize the town. Now three bespectacled police officers and a strange Scottish morgue expert must band together to defeat the undead."}, {"id": 324857, "title": "Spider-Man: Into the Spider-Verse", "backdrop": "https://image.tmdb.org/t/p/w400/uUiId6cG32JSRI6RyBQSvQtLjz2.jpg", "overview": "Miles Morales is juggling his life between being a high school student and being a spider-man. When Wilson \\"Kingpin\\" Fisk uses a super collider, others from across the Spider-Verse are transported to this dimension."}, {"id": 566555, "title": "Detective Conan: The Fist of Blue Sapphire", "backdrop": "https://image.tmdb.org/t/p/w400/wf6VDSi4aFCZfuD8sX8JAKLfJ5m.jpg", "overview": "23rd Detective Conan Movie."}]}]}	9
11	U	2019-06-04 22:31:50.005464+02	{"messages": [{"type": "text", "content": "Recommend me a drama"}]}	9
12	B	2019-06-04 22:31:51.249883+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 531309, "title": "Brightburn", "backdrop": "https://image.tmdb.org/t/p/w400/uHEI6v8ApQusjbaRZ8o7WcLYeWb.jpg", "overview": "What if a child from another world crash-landed on Earth, but instead of becoming a hero to mankind, he proved to be something far more sinister?"}, {"id": 504608, "title": "Rocketman", "backdrop": "https://image.tmdb.org/t/p/w400/oAr5bgf49vxga9etWoQpAeRMvhp.jpg", "overview": "The story of Elton John's life, from his years as a prodigy at the Royal Academy of Music through his influential and enduring musical partnership with Bernie Taupin."}, {"id": 438650, "title": "Cold Pursuit", "backdrop": "https://image.tmdb.org/t/p/w400/aiM3XxYE2JvW1vJ4AC6cI1RjAoT.jpg", "overview": "The quiet family life of Nels Coxman, a snowplow driver, is upended after his son's murder. Nels begins a vengeful hunt for Viking, the drug lord he holds responsible for the killing, eliminating Viking's associates one by one."}, {"id": 529962, "title": "The Perfection", "backdrop": "https://image.tmdb.org/t/p/w400/99LvuMDXJ6A6I7FW61OvjDjvvAx.jpg", "overview": "When troubled musical prodigy Charlotte seeks out Elizabeth, the new star pupil of her former school, the encounter sends both musicians down a sinister path with shocking consequences."}, {"id": 566555, "title": "Detective Conan: The Fist of Blue Sapphire", "backdrop": "https://image.tmdb.org/t/p/w400/wf6VDSi4aFCZfuD8sX8JAKLfJ5m.jpg", "overview": "23rd Detective Conan Movie."}, {"id": 450465, "title": "Glass", "backdrop": "https://image.tmdb.org/t/p/w400/rL1ITQuX0lmSNPu52pRRHUyim5N.jpg", "overview": "In a series of escalating encounters, security guard David Dunn uses his supernatural abilities to track Kevin Wendell Crumb, a disturbed man who has twenty-four personalities. Meanwhile, the shadowy presence of Elijah Price emerges as an orchestrator who holds secrets critical to both men."}, {"id": 537915, "title": "After", "backdrop": "https://image.tmdb.org/t/p/w400/997ToEZvF2Obp9zNZbY5ELVnmrW.jpg", "overview": "A young woman falls for a guy with a dark secret and the two embark on a rocky relationship."}, {"id": 505600, "title": "Booksmart", "backdrop": "https://image.tmdb.org/t/p/w400/wcAqndL2MkIjPrCrYeuE794weNE.jpg", "overview": "Two academic teenage superstars realize, on the eve of their high school graduation, that they should have worked less and played more. Determined to never fall short of their peers, the girls set out on a mission to cram four years of fun into one night."}, {"id": 124905, "title": "Godzilla", "backdrop": "https://image.tmdb.org/t/p/w400/2WKcxQbTVkLUgoS5kPnHlecbj02.jpg", "overview": "Ford Brody, a Navy bomb expert, has just reunited with his family in San Francisco when he is forced to go to Japan to help his estranged father, Joe."}]}]}	9
13	U	2019-06-04 22:33:10.574242+02	{"messages": [{"type": "text", "content": "Help"}]}	9
14	B	2019-06-04 22:33:11.224136+02	{"messages": [{"type": "text", "content": "Type something..."}]}	9
15	U	2019-06-04 22:33:29.027501+02	{"messages": [{"type": "text", "content": "Recommend me a movie released in 2015"}]}	9
16	B	2019-06-04 22:33:30.093682+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 245891, "title": "John Wick", "backdrop": "https://image.tmdb.org/t/p/w400/mFb0ygcue4ITixDkdr7wm1Tdarx.jpg", "overview": "Ex-hitman John Wick comes out of retirement to track down the gangsters that took everything from him."}, {"id": 118340, "title": "Guardians of the Galaxy", "backdrop": "https://image.tmdb.org/t/p/w400/bHarw8xrmQeqf3t8HpuMY7zoK4x.jpg", "overview": "Light years from Earth, 26 years after being abducted, Peter Quill finds himself the prime target of a manhunt after discovering an orb wanted by Ronan the Accuser."}, {"id": 99861, "title": "Avengers: Age of Ultron", "backdrop": "https://image.tmdb.org/t/p/w400/rFtsE7Lhlc2jRWF7SRAU0fvrveQ.jpg", "overview": "When Tony Stark tries to jumpstart a dormant peacekeeping program, things go awry and Earth’s Mightiest Heroes are put to the ultimate test as the fate of the planet hangs in the balance."}, {"id": 122917, "title": "The Hobbit: The Battle of the Five Armies", "backdrop": "https://image.tmdb.org/t/p/w400/qhH3GyIfAnGv1pjdV3mw03qAilg.jpg", "overview": "Immediately after the events of The Desolation of Smaug, Bilbo and the dwarves try to defend Erebor's mountain of treasure from others who claim it: the men of the ruined Laketown and the elves of Mirkwood."}, {"id": 87101, "title": "Terminator Genisys", "backdrop": "https://image.tmdb.org/t/p/w400/bIlYH4l2AyYvEysmS2AOfjO7Dn8.jpg", "overview": "The year is 2029. John Connor, leader of the resistance continues the war against the machines."}, {"id": 177572, "title": "Big Hero 6", "backdrop": "https://image.tmdb.org/t/p/w400/2BXd0t9JdVqCp9sKf6kzMkr7QjB.jpg", "overview": "The special bond that develops between plus-sized inflatable robot Baymax, and prodigy Hiro Hamada, who team up with a group of friends to form a band of high-tech heroes."}, {"id": 150540, "title": "Inside Out", "backdrop": "https://image.tmdb.org/t/p/w400/gPZi2ivLO3C6YffwOVapzKrSBzx.jpg", "overview": "Growing up can be a bumpy road, and it's no exception for Riley, who is uprooted from her Midwest life when her father starts a new job in San Francisco. Like all of us, Riley is guided by her emotions - Joy, Fear, Anger, Disgust and Sadness."}, {"id": 102899, "title": "Ant-Man", "backdrop": "https://image.tmdb.org/t/p/w400/kvXLZqY0Ngl1XSw7EaMQO0C1CCj.jpg", "overview": "Armed with the astonishing ability to shrink in scale but increase in strength, master thief Scott Lang must embrace his inner-hero and help his mentor, Doctor Hank Pym, protect the secret behind his spectacular Ant-Man suit from a new generation of towering threats."}, {"id": 157336, "title": "Interstellar", "backdrop": "https://image.tmdb.org/t/p/w400/xu9zaAevzQ5nnrsXN6JcahLnG4i.jpg", "overview": "Interstellar chronicles the adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage."}]}]}	9
17	U	2019-06-04 22:35:31.640513+02	{"messages": [{"type": "text", "content": "Recommend me popular"}]}	10
18	B	2019-06-04 22:35:33.240967+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 420817, "title": "Aladdin", "backdrop": "https://image.tmdb.org/t/p/w400/v4yVTbbl8dE1UP2dWu5CLyaXOku.jpg", "overview": "A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecracking genie while a power-hungry Grand Vizier vies for the same lamp that has the power to make their deepest wishes come true."}, {"id": 299537, "title": "Captain Marvel", "backdrop": "https://image.tmdb.org/t/p/w400/iNUuGUIHeeGsvOPxMRBnytpxxlz.jpg", "overview": "The story follows Carol Danvers as she becomes one of the universe’s most powerful heroes when Earth is caught in the middle of a galactic war between two alien races."}, {"id": 458156, "title": "John Wick: Chapter 3 – Parabellum", "backdrop": "https://image.tmdb.org/t/p/w400/vVpEOvdxVBP2aV166j5Xlvb5Cdc.jpg", "overview": "Super-assassin John Wick returns with a $14 million price tag on his head and an army of bounty-hunting killers on his trail."}, {"id": 373571, "title": "Godzilla: King of the Monsters", "backdrop": "https://image.tmdb.org/t/p/w400/mzRJpkWPjXdXak0WCc8ZxVH4hug.jpg", "overview": "The new story follows the heroic efforts of the crypto-zoological agency Monarch as its members face off against a battery of god-sized monsters, including the mighty Godzilla, who collides with Mothra, Rodan, and his ultimate nemesis, the three-headed King Ghidorah."}, {"id": 299534, "title": "Avengers: Endgame", "backdrop": "https://image.tmdb.org/t/p/w400/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg", "overview": "After the devastating events of Avengers: Infinity War, the universe is in ruins due to the efforts of the Mad Titan, Thanos."}, {"id": 529983, "title": "The Poison Rose", "backdrop": "https://image.tmdb.org/t/p/w400/3foyl4i78mZoeBb8EQ0RR5axu01.jpg", "overview": "A down-on-his-luck PI is hired by his old flame to investigate a murder. But while the case at first appears routine, it slowly reveals itself to be a complex interwoven web of crimes, suspects and dead bodies."}, {"id": 412117, "title": "The Secret Life of Pets 2", "backdrop": "https://image.tmdb.org/t/p/w400/etaok7q2E5tV36oXe7GQzhUQ4fX.jpg", "overview": "What happens with our pets when we’re not home? This movie continues the original movie with Max and his friends."}, {"id": 299536, "title": "Avengers: Infinity War", "backdrop": "https://image.tmdb.org/t/p/w400/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg", "overview": "As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos."}, {"id": 287947, "title": "Shazam!", "backdrop": "https://image.tmdb.org/t/p/w400/bi4jh0Kt0uuZGsGJoUUfqmbrjQg.jpg", "overview": "A boy is given the ability to become an adult superhero in times of need with a single magic word."}]}]}	10
19	U	2019-06-04 22:36:02.765726+02	{"messages": [{"type": "text", "content": "Recommend me popular comedy"}]}	10
20	B	2019-06-04 22:36:03.884298+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 420817, "title": "Aladdin", "backdrop": "https://image.tmdb.org/t/p/w400/v4yVTbbl8dE1UP2dWu5CLyaXOku.jpg", "overview": "A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecracking genie while a power-hungry Grand Vizier vies for the same lamp that has the power to make their deepest wishes come true."}, {"id": 412117, "title": "The Secret Life of Pets 2", "backdrop": "https://image.tmdb.org/t/p/w400/etaok7q2E5tV36oXe7GQzhUQ4fX.jpg", "overview": "What happens with our pets when we’re not home? This movie continues the original movie with Max and his friends."}, {"id": 287947, "title": "Shazam!", "backdrop": "https://image.tmdb.org/t/p/w400/bi4jh0Kt0uuZGsGJoUUfqmbrjQg.jpg", "overview": "A boy is given the ability to become an adult superhero in times of need with a single magic word."}, {"id": 447404, "title": "Pokémon Detective Pikachu", "backdrop": "https://image.tmdb.org/t/p/w400/nDP33LmQwNsnPv29GQazz59HjJI.jpg", "overview": "In a world where people collect pocket-size monsters (Pokémon) to do battle, a boy comes across an intelligent monster who seeks to be a detective."}, {"id": 920, "title": "Cars", "backdrop": "https://image.tmdb.org/t/p/w400/a1MlbLBk5Sy6YvMbSuKfwGlDVlb.jpg", "overview": "Lightning McQueen, a hotshot rookie race car driven to succeed, discovers that life is about the journey, not the finish line, when he finds himself unexpectedly detoured in the sleepy Route 66 town of Radiator Springs."}, {"id": 513576, "title": "Always Be My Maybe", "backdrop": "https://image.tmdb.org/t/p/w400/gacFeoGjwAJAsbrd90hD5ptcjoe.jpg", "overview": "Reunited after 15 years, famous chef Sasha and hometown musician Marcus feel the old sparks of attraction but struggle to adapt to each other's worlds."}, {"id": 535581, "title": "The Dead Don't Die", "backdrop": "https://image.tmdb.org/t/p/w400/cXyfAViYly0Lk2CVpEKgYbt9wKQ.jpg", "overview": "In a small peaceful town, zombies suddenly rise to terrorize the town. Now three bespectacled police officers and a strange Scottish morgue expert must band together to defeat the undead."}, {"id": 324857, "title": "Spider-Man: Into the Spider-Verse", "backdrop": "https://image.tmdb.org/t/p/w400/uUiId6cG32JSRI6RyBQSvQtLjz2.jpg", "overview": "Miles Morales is juggling his life between being a high school student and being a spider-man. When Wilson \\"Kingpin\\" Fisk uses a super collider, others from across the Spider-Verse are transported to this dimension."}, {"id": 566555, "title": "Detective Conan: The Fist of Blue Sapphire", "backdrop": "https://image.tmdb.org/t/p/w400/wf6VDSi4aFCZfuD8sX8JAKLfJ5m.jpg", "overview": "23rd Detective Conan Movie."}]}]}	10
21	U	2019-06-04 22:36:34.322538+02	{"messages": [{"type": "text", "content": "Recommend me popular comedy released in 2012"}]}	10
22	B	2019-06-04 22:36:36.527783+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 18785, "title": "The Hangover", "backdrop": "https://image.tmdb.org/t/p/w400/xxKd56iFbMeRQARUosTGgxKxrnF.jpg", "overview": "When three friends finally come to after a raucous night of bachelor-party revelry, they find a baby in the closet and a tiger in the bathroom. But they can't seem to locate their best friend, Doug – who's supposed to be tying the knot."}, {"id": 62177, "title": "Brave", "backdrop": "https://image.tmdb.org/t/p/w400/sfRCA9g3CunpnZO3QurHSIRcsUq.jpg", "overview": "Brave is set in the mystical Scottish Highlands, where Mérida is the princess of a kingdom ruled by King Fergus and Queen Elinor. An unruly daughter and an accomplished archer, Mérida one day defies a sacred custom of the land and inadvertently brings turmoil to the kingdom."}, {"id": 13, "title": "Forrest Gump", "backdrop": "https://image.tmdb.org/t/p/w400/wMgbnUVS9wbRGAdki8fqxKU1O0N.jpg", "overview": "A man with a low IQ has accomplished great things in his life and been present during significant historic events—in each case, far exceeding what anyone imagined he could do. But despite all he has achieved, his one true love eludes him."}, {"id": 10193, "title": "Toy Story 3", "backdrop": "https://image.tmdb.org/t/p/w400/y2qAjM37QgatWeG84DDtwsZuMW.jpg", "overview": "Woody, Buzz, and the rest of Andy's toys haven't been played with in years. With Andy about to go to college, the gang find themselves accidentally left at a nefarious day care center. The toys must band together to escape and return home to Andy."}, {"id": 762, "title": "Monty Python and the Holy Grail", "backdrop": "https://image.tmdb.org/t/p/w400/6fqmcCVci3cSBCgJw8NGXE4ST8G.jpg", "overview": "King Arthur, accompanied by his squire, recruits his Knights of the Round Table, including Sir Bedevere the Wise, Sir Lancelot the Brave, Sir Robin the Not-Quite-So-Brave-As-Sir-Lancelot and Sir Galahad the Pure."}, {"id": 813, "title": "Airplane!", "backdrop": "https://image.tmdb.org/t/p/w400/tFPvOmz0uNmfp1sq2ebYAeUCLQ4.jpg", "overview": "Alcoholic pilot, Ted Striker has developed a fear of flying due to wartime trauma, but nevertheless boards a passenger jet in an attempt to woo back his stewardess girlfriend."}, {"id": 41154, "title": "Men in Black 3", "backdrop": "https://image.tmdb.org/t/p/w400/mhokitPCejvcZb0r3SHURZDp7OO.jpg", "overview": "Agents J and K are back...in time. J has seen some inexplicable things in his 15 years with the Men in Black, but nothing, not even aliens, perplexes him as much as his wry, reticent partner."}, {"id": 71552, "title": "American Reunion", "backdrop": "https://image.tmdb.org/t/p/w400/1o7zeskzyKI7VkoPpusMLd6dLgO.jpg", "overview": "The characters we met a little more than a decade ago return to East Great Falls for their high-school reunion. In one long-overdue weekend, they will discover what has changed, who hasn’t, and that time and distance can’t break the bonds of friendship."}, {"id": 15144, "title": "Sixteen Candles", "backdrop": "https://image.tmdb.org/t/p/w400/xCIgY4mUmO4tbDVlntym9PdZ9H8.jpg", "overview": "A teenage girls deals with her parents forgetting her birthday and a crush on her high school's heartthrob."}]}]}	10
23	U	2019-06-04 22:37:59.110131+02	{"messages": [{"type": "text", "content": "Recommend me horror released in 2000"}]}	11
24	B	2019-06-04 22:38:00.692444+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 578, "title": "Jaws", "backdrop": "https://image.tmdb.org/t/p/w400/uTVuKo6OTGiead1ncsfH2klqYHC.jpg", "overview": "An insatiable great white shark terrorizes the townspeople of Amity Island, The police chief, an oceanographer and a grizzled shark hunter seek to destroy the bloodthirsty beast."}, {"id": 8078, "title": "Alien Resurrection", "backdrop": "https://image.tmdb.org/t/p/w400/1F8KilfgVwWTB1tIzfwoKUvPqpl.jpg", "overview": "Two hundred years after Lt. Ripley died, a group of scientists clone her, hoping to breed the ultimate weapon. But the new Ripley is full of surprises … as are the new aliens. Ripley must team with a band of smugglers to keep the creatures from reaching Earth."}, {"id": 948, "title": "Halloween", "backdrop": "https://image.tmdb.org/t/p/w400/nGvbpwepspCxiA7AFEGKpQw5z9Z.jpg", "overview": "Fifteen years after murdering his sister on Halloween Night 1963, Michael Myers escapes from a mental hospital and returns to the small town of Haddonfield, Illinois to kill again."}, {"id": 36647, "title": "Blade", "backdrop": "https://image.tmdb.org/t/p/w400/dGnDGHD5vmaRow4BzAiuJaGwIz3.jpg", "overview": "When Blade's mother was bitten by a vampire during pregnancy, she did not know that she gave her son a special gift while dying—all the good vampire attributes in combination with the best human skills."}, {"id": 8413, "title": "Event Horizon", "backdrop": "https://image.tmdb.org/t/p/w400/5dfmxhR8VTYkddKOtP1XFgMstbm.jpg", "overview": "In 2047 a group of astronauts are sent to investigate and salvage the starship 'Event Horizon' which disappeared mysteriously 7 years before on its maiden voyage."}, {"id": 2668, "title": "Sleepy Hollow", "backdrop": "https://image.tmdb.org/t/p/w400/3p5YkOrajk3DVYrGwX64p8ervti.jpg", "overview": "New York detective Ichabod Crane is sent to Sleepy Hollow to investigate a series of mysterious deaths in which the victims are found beheaded. But the locals believe the culprit to be none other than the ghost of the legendary Headless Horseman."}, {"id": 622, "title": "The Ninth Gate", "backdrop": "https://image.tmdb.org/t/p/w400/7ikpBrx2YZyVZxFS5YTZUZoyIJu.jpg", "overview": "An all-expenses-paid international search for a rare copy of the book, 'The Nine Gates of the Shadow Kingdom' brings an unscrupulous book dealer deep into a world of murder, double-dealing and satanic worship."}, {"id": 9946, "title": "End of Days", "backdrop": "https://image.tmdb.org/t/p/w400/q5KcZBMc4Vs5SQelnSdY3ICm56M.jpg", "overview": "On 28 December 1999, the citizens of New York City are getting ready for the turn of the millennium. However, the Devil decides to crash the party by coming to the city, inhabiting a man's body, and searching for his chosen bride—a 20-year-old woman named Christine York."}, {"id": 8843, "title": "The Cell", "backdrop": "https://image.tmdb.org/t/p/w400/46aAskiXtvdtAR9ryEOXJPazKpL.jpg", "overview": "A psychotherapist journeys inside a comatose serial killer in the hopes of saving his latest victim."}]}]}	11
25	U	2019-06-04 22:38:27.50648+02	{"messages": [{"type": "text", "content": "Recommend popular"}]}	11
26	B	2019-06-04 22:38:28.707925+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 420817, "title": "Aladdin", "backdrop": "https://image.tmdb.org/t/p/w400/v4yVTbbl8dE1UP2dWu5CLyaXOku.jpg", "overview": "A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecracking genie while a power-hungry Grand Vizier vies for the same lamp that has the power to make their deepest wishes come true."}, {"id": 299537, "title": "Captain Marvel", "backdrop": "https://image.tmdb.org/t/p/w400/iNUuGUIHeeGsvOPxMRBnytpxxlz.jpg", "overview": "The story follows Carol Danvers as she becomes one of the universe’s most powerful heroes when Earth is caught in the middle of a galactic war between two alien races."}, {"id": 458156, "title": "John Wick: Chapter 3 – Parabellum", "backdrop": "https://image.tmdb.org/t/p/w400/vVpEOvdxVBP2aV166j5Xlvb5Cdc.jpg", "overview": "Super-assassin John Wick returns with a $14 million price tag on his head and an army of bounty-hunting killers on his trail."}, {"id": 373571, "title": "Godzilla: King of the Monsters", "backdrop": "https://image.tmdb.org/t/p/w400/mzRJpkWPjXdXak0WCc8ZxVH4hug.jpg", "overview": "The new story follows the heroic efforts of the crypto-zoological agency Monarch as its members face off against a battery of god-sized monsters, including the mighty Godzilla, who collides with Mothra, Rodan, and his ultimate nemesis, the three-headed King Ghidorah."}, {"id": 299534, "title": "Avengers: Endgame", "backdrop": "https://image.tmdb.org/t/p/w400/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg", "overview": "After the devastating events of Avengers: Infinity War, the universe is in ruins due to the efforts of the Mad Titan, Thanos."}, {"id": 529983, "title": "The Poison Rose", "backdrop": "https://image.tmdb.org/t/p/w400/3foyl4i78mZoeBb8EQ0RR5axu01.jpg", "overview": "A down-on-his-luck PI is hired by his old flame to investigate a murder. But while the case at first appears routine, it slowly reveals itself to be a complex interwoven web of crimes, suspects and dead bodies."}, {"id": 412117, "title": "The Secret Life of Pets 2", "backdrop": "https://image.tmdb.org/t/p/w400/etaok7q2E5tV36oXe7GQzhUQ4fX.jpg", "overview": "What happens with our pets when we’re not home? This movie continues the original movie with Max and his friends."}, {"id": 299536, "title": "Avengers: Infinity War", "backdrop": "https://image.tmdb.org/t/p/w400/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg", "overview": "As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos."}, {"id": 287947, "title": "Shazam!", "backdrop": "https://image.tmdb.org/t/p/w400/bi4jh0Kt0uuZGsGJoUUfqmbrjQg.jpg", "overview": "A boy is given the ability to become an adult superhero in times of need with a single magic word."}]}]}	11
27	U	2019-06-04 22:39:54.549333+02	{"messages": [{"type": "text", "content": "Recommend me romance released in 2005"}]}	12
28	B	2019-06-04 22:39:55.77958+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 13, "title": "Forrest Gump", "backdrop": "https://image.tmdb.org/t/p/w400/wMgbnUVS9wbRGAdki8fqxKU1O0N.jpg", "overview": "A man with a low IQ has accomplished great things in his life and been present during significant historic events—in each case, far exceeding what anyone imagined he could do. But despite all he has achieved, his one true love eludes him."}, {"id": 15144, "title": "Sixteen Candles", "backdrop": "https://image.tmdb.org/t/p/w400/xCIgY4mUmO4tbDVlntym9PdZ9H8.jpg", "overview": "A teenage girls deals with her parents forgetting her birthday and a crush on her high school's heartthrob."}, {"id": 11130, "title": "The Princess Diaries 2: Royal Engagement", "backdrop": "https://image.tmdb.org/t/p/w400/f0frE29Bds70oHdYwnfRoAWAUM7.jpg", "overview": "Mia Thermopolis is now a college graduate and on her way to Genovia to take up her duties as princess. Her best friend Lilly also joins her for the summer. Mia continues her 'princess lessons'- riding horses side-saddle, archery, and other royal."}, {"id": 15969, "title": "The Return of Jafar", "backdrop": "https://image.tmdb.org/t/p/w400/sLF3zgqfFC6Vev84h9aK4U88M2C.jpg", "overview": "The evil Jafar escapes from the magic lamp as an all-powerful genie, ready to plot his revenge against Aladdin."}, {"id": 2105, "title": "American Pie", "backdrop": "https://image.tmdb.org/t/p/w400/udTWgfwAzUxdztoyKSReoSrjBU7.jpg", "overview": "At a high-school party, four friends find that losing their collective virginity isn't as easy as they had thought. But they still believe that they need to do so before college. To motivate themselves, they enter a pact to all \\"score.\\" by their senior prom."}, {"id": 11224, "title": "Cinderella", "backdrop": "https://image.tmdb.org/t/p/w400/xSN1cpugrzi8DjpVxtHeRRlbB6Q.jpg", "overview": "Cinderella has faith her dreams of a better life will come true. With help from her loyal mice friends and a wave of her Fairy Godmother's wand, Cinderella's rags are magically turned into a glorious gown and off she goes to the Royal Ball."}, {"id": 38, "title": "Eternal Sunshine of the Spotless Mind", "backdrop": "https://image.tmdb.org/t/p/w400/1dXTsaFxHoF9cas08UjAqE8NqOW.jpg", "overview": "Joel Barish, heartbroken that his girlfriend underwent a procedure to erase him from her memory, decides to do the same. However, as he watches his memories of her fade away, he realises that he still loves her, and may be too late to correct his mistake."}, {"id": 10591, "title": "The Girl Next Door", "backdrop": "https://image.tmdb.org/t/p/w400/uPLe50Gi6h1nxHucIherq0kTqoY.jpg", "overview": "Exceptionally ambitious high schooler Matthew has aspirations for a career in politics when he falls in love with his gorgeous 19-year-old neighbor, Danielle. But Matthew's bright future is jeopardized when he finds Danielle was once a porn star."}, {"id": 1966, "title": "Alexander", "backdrop": "https://image.tmdb.org/t/p/w400/cLOekK7EmHB1beYUYEXIlcr6mpS.jpg", "overview": "Alexander, the King of Macedonia, leads his legions against the giant Persian Empire. After defeating the Persians, he leads his army across the then known world, venturing farther than any westerner had ever gone, all the way to India."}]}]}	12
29	U	2019-06-04 22:40:25.999573+02	{"messages": [{"type": "text", "content": "Recommend popular comedy"}]}	12
30	B	2019-06-04 22:40:27.332711+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 420817, "title": "Aladdin", "backdrop": "https://image.tmdb.org/t/p/w400/v4yVTbbl8dE1UP2dWu5CLyaXOku.jpg", "overview": "A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecracking genie while a power-hungry Grand Vizier vies for the same lamp that has the power to make their deepest wishes come true."}, {"id": 412117, "title": "The Secret Life of Pets 2", "backdrop": "https://image.tmdb.org/t/p/w400/etaok7q2E5tV36oXe7GQzhUQ4fX.jpg", "overview": "What happens with our pets when we’re not home? This movie continues the original movie with Max and his friends."}, {"id": 287947, "title": "Shazam!", "backdrop": "https://image.tmdb.org/t/p/w400/bi4jh0Kt0uuZGsGJoUUfqmbrjQg.jpg", "overview": "A boy is given the ability to become an adult superhero in times of need with a single magic word."}, {"id": 447404, "title": "Pokémon Detective Pikachu", "backdrop": "https://image.tmdb.org/t/p/w400/nDP33LmQwNsnPv29GQazz59HjJI.jpg", "overview": "In a world where people collect pocket-size monsters (Pokémon) to do battle, a boy comes across an intelligent monster who seeks to be a detective."}, {"id": 920, "title": "Cars", "backdrop": "https://image.tmdb.org/t/p/w400/a1MlbLBk5Sy6YvMbSuKfwGlDVlb.jpg", "overview": "Lightning McQueen, a hotshot rookie race car driven to succeed, discovers that life is about the journey, not the finish line, when he finds himself unexpectedly detoured in the sleepy Route 66 town of Radiator Springs."}, {"id": 513576, "title": "Always Be My Maybe", "backdrop": "https://image.tmdb.org/t/p/w400/gacFeoGjwAJAsbrd90hD5ptcjoe.jpg", "overview": "Reunited after 15 years, famous chef Sasha and hometown musician Marcus feel the old sparks of attraction but struggle to adapt to each other's worlds."}, {"id": 535581, "title": "The Dead Don't Die", "backdrop": "https://image.tmdb.org/t/p/w400/cXyfAViYly0Lk2CVpEKgYbt9wKQ.jpg", "overview": "In a small peaceful town, zombies suddenly rise to terrorize the town. Now three bespectacled police officers and a strange Scottish morgue expert must band together to defeat the undead."}, {"id": 324857, "title": "Spider-Man: Into the Spider-Verse", "backdrop": "https://image.tmdb.org/t/p/w400/uUiId6cG32JSRI6RyBQSvQtLjz2.jpg", "overview": "Miles Morales is juggling his life between being a high school student and being a spider-man. When Wilson \\"Kingpin\\" Fisk uses a super collider, others from across the Spider-Verse are transported to this dimension."}, {"id": 566555, "title": "Detective Conan: The Fist of Blue Sapphire", "backdrop": "https://image.tmdb.org/t/p/w400/wf6VDSi4aFCZfuD8sX8JAKLfJ5m.jpg", "overview": "23rd Detective Conan Movie."}]}]}	12
31	U	2019-06-04 22:41:24.064821+02	{"messages": [{"type": "text", "content": "Hello"}]}	1
32	B	2019-06-04 22:41:24.629395+02	{"messages": [{"type": "text", "content": "Hello, how can I help you?"}]}	1
33	U	2019-06-04 22:41:30.287071+02	{"messages": [{"type": "text", "content": "Recommend popular"}]}	1
34	B	2019-06-04 22:41:31.82658+02	{"messages": [{"type": "text", "content": "Here are my picks for you"}, {"type": "movies", "content": [{"id": 420817, "title": "Aladdin", "backdrop": "https://image.tmdb.org/t/p/w400/v4yVTbbl8dE1UP2dWu5CLyaXOku.jpg", "overview": "A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecracking genie while a power-hungry Grand Vizier vies for the same lamp that has the power to make their deepest wishes come true."}, {"id": 299537, "title": "Captain Marvel", "backdrop": "https://image.tmdb.org/t/p/w400/iNUuGUIHeeGsvOPxMRBnytpxxlz.jpg", "overview": "The story follows Carol Danvers as she becomes one of the universe’s most powerful heroes when Earth is caught in the middle of a galactic war between two alien races."}, {"id": 458156, "title": "John Wick: Chapter 3 – Parabellum", "backdrop": "https://image.tmdb.org/t/p/w400/vVpEOvdxVBP2aV166j5Xlvb5Cdc.jpg", "overview": "Super-assassin John Wick returns with a $14 million price tag on his head and an army of bounty-hunting killers on his trail."}, {"id": 373571, "title": "Godzilla: King of the Monsters", "backdrop": "https://image.tmdb.org/t/p/w400/mzRJpkWPjXdXak0WCc8ZxVH4hug.jpg", "overview": "The new story follows the heroic efforts of the crypto-zoological agency Monarch as its members face off against a battery of god-sized monsters, including the mighty Godzilla, who collides with Mothra, Rodan, and his ultimate nemesis, the three-headed King Ghidorah."}, {"id": 299534, "title": "Avengers: Endgame", "backdrop": "https://image.tmdb.org/t/p/w400/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg", "overview": "After the devastating events of Avengers: Infinity War, the universe is in ruins due to the efforts of the Mad Titan, Thanos."}, {"id": 529983, "title": "The Poison Rose", "backdrop": "https://image.tmdb.org/t/p/w400/3foyl4i78mZoeBb8EQ0RR5axu01.jpg", "overview": "A down-on-his-luck PI is hired by his old flame to investigate a murder. But while the case at first appears routine, it slowly reveals itself to be a complex interwoven web of crimes, suspects and dead bodies."}, {"id": 412117, "title": "The Secret Life of Pets 2", "backdrop": "https://image.tmdb.org/t/p/w400/etaok7q2E5tV36oXe7GQzhUQ4fX.jpg", "overview": "What happens with our pets when we’re not home? This movie continues the original movie with Max and his friends."}, {"id": 299536, "title": "Avengers: Infinity War", "backdrop": "https://image.tmdb.org/t/p/w400/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg", "overview": "As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos."}, {"id": 287947, "title": "Shazam!", "backdrop": "https://image.tmdb.org/t/p/w400/bi4jh0Kt0uuZGsGJoUUfqmbrjQg.jpg", "overview": "A boy is given the ability to become an adult superhero in times of need with a single magic word."}]}]}	1
\.


--
-- TOC entry 3370 (class 0 OID 16942)
-- Dependencies: 219
-- Data for Name: app_movie; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.app_movie (id, title, description, rating, release_date, trailer, backdrop, poster) FROM stdin;
603	The Matrix	Set in the 22nd century, The Matrix tells the story of a computer hacker who joins a group of underground insurgents fighting the vast and powerful computers who now rule the earth.	8.1	1999-03-30	m8e-FF8MsqU	/icmmSD4vTTDKOq2vvdulafOGw93.jpg	/hEpWvX6Bp79eLxY1kX5ZZJcme5U.jpg
627	Trainspotting	Mark Renton, deeply immersed in the Edinburgh drug scene, tries to clean up and get out, despite the allure of the drugs and influence of friends.	8.0	1996-02-23	GmQqhuKmECc	/Aw0z8bUhGljT0ots6udf1MTLEMi.jpg	/p1O3eFsdb0GEIYu87xlwV7P4jM1.jpg
562	Die Hard	NYPD cop John McClane's plan to reconcile with his estranged wife is thrown for a serious loop when, minutes after he arrives at her office, the entire building is overtaken by a group of terrorists.	7.7	1988-07-15	2TQ-pOvI6Xo	/eg049B1TJdWuKuyKowNmhZxNToc.jpg	/mc7MubOLcIw3MDvnuQFrO9psfCa.jpg
680	Pulp Fiction	A burger-loving hit man, his philosophical partner, a drug-addled gangster's moll and a washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories that ingeniously trip back and forth in time.	8.4	1994-09-10	s7EdQ4FqbhY	/4cDFJr4HnXN5AdPw4AKrmLlMWdO.jpg	/dM2w364MScsjFf8pfMbaWUcWrR.jpg
607	Men in Black	After a police chase with an otherworldly being, a New York City cop is recruited as an agent in a top-secret organization established to monitor and police alien activity on Earth: the Men in Black.	7.1	1997-07-02	HYUd7AOw_lk	/agCihVGrXk3hmmwMIgsn2ao1eEa.jpg	/f24UVKq3UiQWLqGWdqjwkzgB8j8.jpg
420817	Aladdin	A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecracking genie while a power-hungry Grand Vizier vies for the same lamp that has the power to make their deepest wishes come true.	7.3	2019-05-22	foyufD52aog	/v4yVTbbl8dE1UP2dWu5CLyaXOku.jpg	/3iYQTLGoy7QnjcUYRJy4YrAgGvp.jpg
299534	Avengers: Endgame	After the devastating events of Avengers: Infinity War, the universe is in ruins due to the efforts of the Mad Titan, Thanos.	8.5	2019-04-24	hA6hldpSTF8	/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg	/or06FN3Dka5tukK1e9sl16pB3iy.jpg
447404	Pokémon Detective Pikachu	In a world where people collect pocket-size monsters (Pokémon) to do battle, a boy comes across an intelligent monster who seeks to be a detective.	7.0	2019-05-03	1roy4o4tqQM	/nDP33LmQwNsnPv29GQazz59HjJI.jpg	/wgQ7APnFpf1TuviKHXeEe3KnsTV.jpg
529983	The Poison Rose	A down-on-his-luck PI is hired by his old flame to investigate a murder. But while the case at first appears routine, it slowly reveals itself to be a complex interwoven web of crimes, suspects and dead bodies.	5.1	2019-05-23	a-EiwzB_DBg	/3foyl4i78mZoeBb8EQ0RR5axu01.jpg	/gSzyUmg719TgAxarFZYWjLLMqvS.jpg
373571	Godzilla: King of the Monsters	The new story follows the heroic efforts of the crypto-zoological agency Monarch as its members face off against a battery of god-sized monsters, including the mighty Godzilla, who collides with Mothra, Rodan, and his ultimate nemesis, the three-headed King Ghidorah.	6.6	2019-05-29	wVDtmouV9kM	/mzRJpkWPjXdXak0WCc8ZxVH4hug.jpg	/pU3bnutJU91u3b4IeRPQTOP8jhV.jpg
238	The Godfather	Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family.	8.6	1972-03-14	_IqFJLdV13o	/6xKCYgH16UuwEGAyroLU6p8HLIn.jpg	/rPdtLWNsZmAtoZl9PK7S2wE3qiS.jpg
770	Gone with the Wind	The spoiled daughter of a well-to-do plantation owner is forced to use every means at her disposal to claw her way out of poverty, following Maj. Gen. William Sherman's destructive "March to the Sea,” during the American Civil War.	7.9	1939-12-15	0dTsfsr6-X8	/bGRUMgSvs6wzYQRqehY4Fsup4f1.jpg	/4o1yeosjSFMaI9pe1rOkYcZ6hHO.jpg
289	Casablanca	In Casablanca, Morocco in December 1941, a cynical American expatriate meets a former lover, with unforeseen complications.	8.1	1942-11-26	BkL9l7qovsE	/5tE7iKSpBrc4z6LqF5kHutMm6KQ.jpg	/wOBKAoUJZb5qTsWv5XXvVV2vUzz.jpg
164	Breakfast at Tiffany's	Fortune hunter Holly Golightly finds herself captivated by aspiring writer Paul Varjak, who's moved into her building on a wealthy woman's dime. As romance blooms between Paul and Holly, Doc Golightly shows up on the scene, revealing Holly's past.	7.7	1961-10-05	urQVzgEO_w8	/vABwESShzjlSynkyGjLihTUieMJ.jpg	/c95lbDwL5WT8PV9DZsdSvRtXKNA.jpg
439	La Dolce Vita	Episodic journey of an Italian journalist scouring Rome in search of love.	8.1	1960-02-05	PHL2jTCjQLY	/b3ofp0vhkbKsrz2V44DimBRKkxf.jpg	/mZJ25Th65B2KXM57uIiEzO3Aw81.jpg
654	On the Waterfront	Terry Malloy dreams about being a prize fighter, while tending his pigeons and running errands at the docks for Johnny Friendly, the corrupt boss of the dockers union. Terry witnesses a murder by two of Johnny's thugs, and later meets the dead man's sister and feels responsible for his death.	8.1	1954-06-22	PAUysPs8NjA	/zXp2ydvhO9qGzpIsb1CWeKnn5yg.jpg	/2AKM5RxGoerG5v1x4TWu36MDxqT.jpg
426426	Roma	In 1970s Mexico City, two domestic workers help a mother of four while her husband is away for an extended period of time.	7.8	2018-08-25	6BS27ngZtxg	/zl9uqCl5iUSb50sTk2BPzw6bJnU.jpg	/dtIIyQyALk57ko5bjac7hi01YQ.jpg
375262	The Favourite	England, early 18th century. The close relationship between Queen Anne and Sarah Churchill is threatened by the arrival of Sarah's cousin, Abigail Hill, resulting in a bitter rivalry between the two cousins to be the Queen's favourite.	7.7	2018-11-23	SYb-wkehT1g	/ekWMoBZ4B9rM60INZEh5FAD2HFR.jpg	/cwBq0onfmeilU5xgqNNjJAMPfpw.jpg
324857	Spider-Man: Into the Spider-Verse	Miles Morales is juggling his life between being a high school student and being a spider-man. When Wilson "Kingpin" Fisk uses a super collider, others from across the Spider-Verse are transported to this dimension.	8.4	2018-12-07	g4Hbz2jLxvQ	/uUiId6cG32JSRI6RyBQSvQtLjz2.jpg	/iiZZdoQBEYBv6id8su7ImL0oCbD.jpg
465914	If Beale Street Could Talk	After her fiance is falsely imprisoned, a pregnant African-American woman sets out to clear his name and prove his innocence.	7.1	2018-12-14	N4m3t3G3Zqc	/1BeMxME8SPuJgCTmyEBzGWSZrAR.jpg	/qhUIOTSi3kr4290tKrVyeriyvrv.jpg
429197	Vice	George W. Bush picks Dick Cheney, the CEO of Halliburton Co., to be his Republican running mate in the 2000 presidential election. No stranger to politics, Cheney's impressive résumé includes stints as White House chief of staff, House Minority Whip and defense secretary.	7.1	2018-12-25	g09a9laLh0k	/7TTlvADXSxg0yzlGTZFExmw4TSC.jpg	/1gCab6rNv1r6V64cwsU4oEr649Y.jpg
504608	Rocketman	The story of Elton John's life, from his years as a prodigy at the Royal Academy of Music through his influential and enduring musical partnership with Bernie Taupin.	7.7	2019-05-22	S3vO8E2e6G0	/oAr5bgf49vxga9etWoQpAeRMvhp.jpg	/f4FF18ia7yTvHf2izNrHqBmgH8U.jpg
438650	Cold Pursuit	The quiet family life of Nels Coxman, a snowplow driver, is upended after his son's murder. Nels begins a vengeful hunt for Viking, the drug lord he holds responsible for the killing, eliminating Viking's associates one by one.	5.3	2019-02-07	0phuNQQ_gHI	/aiM3XxYE2JvW1vJ4AC6cI1RjAoT.jpg	/hXgmWPd1SuujRZ4QnKLzrj79PAw.jpg
529962	The Perfection	When troubled musical prodigy Charlotte seeks out Elizabeth, the new star pupil of her former school, the encounter sends both musicians down a sinister path with shocking consequences.	6.7	2018-09-20	q57D6kF5B1k	/99LvuMDXJ6A6I7FW61OvjDjvvAx.jpg	/tPDe68PDsgIGMs6wdJLtcwVVxA7.jpg
245891	John Wick	Ex-hitman John Wick comes out of retirement to track down the gangsters that took everything from him.	7.2	2014-10-22	2AUmvWm5ZDQ	/mFb0ygcue4ITixDkdr7wm1Tdarx.jpg	/b9uYMMbm87IBFOq59pppvkkkgNg.jpg
87101	Terminator Genisys	The year is 2029. John Connor, leader of the resistance continues the war against the machines.	5.9	2015-06-23	rGSxss7gWak	/bIlYH4l2AyYvEysmS2AOfjO7Dn8.jpg	/5JU9ytZJyR3zmClGmVm9q4Geqbd.jpg
177572	Big Hero 6	The special bond that develops between plus-sized inflatable robot Baymax, and prodigy Hiro Hamada, who team up with a group of friends to form a band of high-tech heroes.	7.8	2014-10-24	OvgyXKDXdZY	/2BXd0t9JdVqCp9sKf6kzMkr7QjB.jpg	/9gLu47Zw5ertuFTZaxXOvNfy78T.jpg
150540	Inside Out	Growing up can be a bumpy road, and it's no exception for Riley, who is uprooted from her Midwest life when her father starts a new job in San Francisco. Like all of us, Riley is guided by her emotions - Joy, Fear, Anger, Disgust and Sadness.	8.0	2015-06-09	yRUAzGQ3nSY	/gPZi2ivLO3C6YffwOVapzKrSBzx.jpg	/aAmfIX3TT40zUHGcCKrlOZRKC7u.jpg
99861	Avengers: Age of Ultron	When Tony Stark tries to jumpstart a dormant peacekeeping program, things go awry and Earth’s Mightiest Heroes are put to the ultimate test as the fate of the planet hangs in the balance.	7.3	2015-04-22	MZoO8QVMxkk	/rFtsE7Lhlc2jRWF7SRAU0fvrveQ.jpg	/t90Y3G8UGQp0f0DrP60wRu9gfrH.jpg
299537	Captain Marvel	The story follows Carol Danvers as she becomes one of the universe’s most powerful heroes when Earth is caught in the middle of a galactic war between two alien races.	7.1	2019-03-06	Z1BCujX3pw8	/iNUuGUIHeeGsvOPxMRBnytpxxlz.jpg	/AtsgWhDnHTq68L0lLsUrCnM7TjG.jpg
458156	John Wick: Chapter 3 – Parabellum	Super-assassin John Wick returns with a $14 million price tag on his head and an army of bounty-hunting killers on his trail.	7.3	2019-05-15	M7XM597XO94	/vVpEOvdxVBP2aV166j5Xlvb5Cdc.jpg	/ziEuG1essDuWuC5lpWUaw1uXY2O.jpg
412117	The Secret Life of Pets 2	What happens with our pets when we’re not home? This movie continues the original movie with Max and his friends.	6.2	2019-05-24	pKLGUuJftl0	/etaok7q2E5tV36oXe7GQzhUQ4fX.jpg	/q3mKnSkzp1doIsCye6ap4KIUAbu.jpg
287947	Shazam!	A boy is given the ability to become an adult superhero in times of need with a single magic word.	7.1	2019-03-23	go6GEIrcvFY	/bi4jh0Kt0uuZGsGJoUUfqmbrjQg.jpg	/xnopI5Xtky18MPhK40cZAGAOVeV.jpg
18785	The Hangover	When three friends finally come to after a raucous night of bachelor-party revelry, they find a baby in the closet and a tiger in the bathroom. But they can't seem to locate their best friend, Doug – who's supposed to be tying the knot.	7.3	2009-06-02	jj6wcUes1no	/xxKd56iFbMeRQARUosTGgxKxrnF.jpg	/uluhlXubGu1VxU63X9VHCLWDAYP.jpg
813	Airplane!	Alcoholic pilot, Ted Striker has developed a fear of flying due to wartime trauma, but nevertheless boards a passenger jet in an attempt to woo back his stewardess girlfriend.	7.2	1980-07-02	HMnVs287AJ4	/tFPvOmz0uNmfp1sq2ebYAeUCLQ4.jpg	/b4sAWNIbfXw4WTdc1wiVRBk2Vko.jpg
41154	Men in Black 3	Agents J and K are back...in time. J has seen some inexplicable things in his 15 years with the Men in Black, but nothing, not even aliens, perplexes him as much as his wry, reticent partner.	6.4	2012-05-23	IyaFEBI_L24	/mhokitPCejvcZb0r3SHURZDp7OO.jpg	/l9hrvXyGq19f6jPRZhSVRibTMwW.jpg
578	Jaws	An insatiable great white shark terrorizes the townspeople of Amity Island, The police chief, an oceanographer and a grizzled shark hunter seek to destroy the bloodthirsty beast.	7.6	1975-06-18	U1fu_sA7XhE	/uTVuKo6OTGiead1ncsfH2klqYHC.jpg	/l1yltvzILaZcx2jYvc5sEMkM7Eh.jpg
2668	Sleepy Hollow	New York detective Ichabod Crane is sent to Sleepy Hollow to investigate a series of mysterious deaths in which the victims are found beheaded. But the locals believe the culprit to be none other than the ghost of the legendary Headless Horseman.	7.1	1999-11-18	nYHt8SdUj-U	/3p5YkOrajk3DVYrGwX64p8ervti.jpg	/2UDsmTvWSxVvuGoRQyV3zVaIRyu.jpg
8413	Event Horizon	In 2047 a group of astronauts are sent to investigate and salvage the starship 'Event Horizon' which disappeared mysteriously 7 years before on its maiden voyage.	6.4	1997-08-15	Ix9CHnOo94k	/5dfmxhR8VTYkddKOtP1XFgMstbm.jpg	/vo02iJLsem3VCJ2TNvSzRiJMpAE.jpg
299536	Avengers: Infinity War	As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos.	8.3	2018-04-25	6ZfuNTqbHE8	/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg	/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg
15144	Sixteen Candles	A teenage girls deals with her parents forgetting her birthday and a crush on her high school's heartthrob.	6.8	1984-05-04	WcKqtzj8LAg	/xCIgY4mUmO4tbDVlntym9PdZ9H8.jpg	/rzTrRQg5ek47Yl0Vfenc69r9gOd.jpg
11130	The Princess Diaries 2: Royal Engagement	Mia Thermopolis is now a college graduate and on her way to Genovia to take up her duties as princess. Her best friend Lilly also joins her for the summer. Mia continues her 'princess lessons'- riding horses side-saddle, archery, and other royal.	6.4	2004-08-06	iemU7EUQgmo	/f0frE29Bds70oHdYwnfRoAWAUM7.jpg	/n98DlNl0DIDAn6tYYqt51bSy5KV.jpg
15969	The Return of Jafar	The evil Jafar escapes from the magic lamp as an all-powerful genie, ready to plot his revenge against Aladdin.	5.8	1994-12-15	4BimOXmpW3k	/sLF3zgqfFC6Vev84h9aK4U88M2C.jpg	/sC4wDVBMPMxmn5JJqPalMOhQ35U.jpg
920	Cars	Lightning McQueen, a hotshot rookie race car driven to succeed, discovers that life is about the journey, not the finish line, when he finds himself unexpectedly detoured in the sleepy Route 66 town of Radiator Springs.	6.7	2006-06-08	SbXIj2T-_uk	/a1MlbLBk5Sy6YvMbSuKfwGlDVlb.jpg	/5damnMcRFKSjhCirgX3CMa88MBj.jpg
513576	Always Be My Maybe	Reunited after 15 years, famous chef Sasha and hometown musician Marcus feel the old sparks of attraction but struggle to adapt to each other's worlds.	7.0	2019-05-31	iHBcWHY9lN4	/gacFeoGjwAJAsbrd90hD5ptcjoe.jpg	/3BO6pPa7qDcpPYct061Luh9fvst.jpg
535581	The Dead Don't Die	In a small peaceful town, zombies suddenly rise to terrorize the town. Now three bespectacled police officers and a strange Scottish morgue expert must band together to defeat the undead.	5.8	2019-05-15	bs5ZOcU6Bnw	/cXyfAViYly0Lk2CVpEKgYbt9wKQ.jpg	/ycMSfP8KRFsVUWfbSxSFpD97QfD.jpg
\.


--
-- TOC entry 3372 (class 0 OID 16949)
-- Dependencies: 221
-- Data for Name: app_movie_genres; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.app_movie_genres (id, movie_id, moviegenre_id) FROM stdin;
1	603	28
2	603	878
3	627	18
4	627	80
5	562	28
6	562	53
7	680	53
8	680	80
9	607	28
10	607	12
11	607	35
12	607	878
13	420817	12
14	420817	14
15	420817	10749
16	420817	35
17	420817	10751
18	299534	12
19	299534	878
20	299534	28
21	447404	9648
22	447404	10751
23	447404	35
24	447404	878
25	447404	28
26	447404	12
27	529983	80
28	529983	9648
29	373571	878
30	373571	53
31	373571	28
32	238	18
33	238	80
34	770	18
35	770	10749
36	770	10752
37	289	18
38	289	10749
39	164	35
40	164	18
41	164	10749
42	439	35
43	439	18
44	654	80
45	654	18
46	426426	18
47	375262	18
48	375262	36
49	375262	35
50	324857	28
51	324857	12
52	324857	16
53	324857	878
54	324857	35
55	465914	18
56	465914	10749
57	465914	80
58	429197	18
59	429197	36
60	429197	35
61	504608	10402
62	504608	18
63	438650	28
64	438650	18
65	438650	53
66	438650	80
67	529962	18
68	529962	27
69	529962	53
70	245891	28
71	245891	53
72	87101	878
73	87101	28
74	87101	53
75	87101	12
76	177572	12
77	177572	10751
78	177572	16
79	177572	28
80	177572	35
81	150540	18
82	150540	35
83	150540	16
84	150540	10751
85	99861	28
86	99861	12
87	99861	878
88	299537	28
89	299537	12
90	299537	878
91	458156	80
92	458156	28
93	458156	53
94	412117	12
95	412117	16
96	412117	35
97	412117	10751
98	287947	28
99	287947	12
100	287947	35
101	287947	14
102	18785	35
103	813	35
104	41154	28
105	41154	35
106	41154	878
107	578	27
108	578	53
109	578	12
110	2668	18
111	2668	14
112	2668	53
113	2668	9648
114	2668	27
115	8413	27
116	8413	878
117	8413	9648
118	299536	12
119	299536	28
120	299536	14
121	15144	35
122	15144	10749
123	11130	35
124	11130	18
125	11130	10751
126	11130	10749
127	15969	10751
128	15969	12
129	15969	16
130	15969	10749
131	920	16
132	920	12
133	920	35
134	920	10751
135	513576	10749
136	513576	35
137	535581	35
138	535581	27
\.


--
-- TOC entry 3369 (class 0 OID 16937)
-- Dependencies: 218
-- Data for Name: app_moviegenre; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.app_moviegenre (id, name) FROM stdin;
28	Action
12	Adventure
16	Animation
35	Comedy
80	Crime
99	Documentary
18	Drama
10751	Family
14	Fantasy
36	History
27	Horror
10402	Music
9648	Mystery
10749	Romance
878	Science Fiction
10770	TV Movie
53	Thriller
10752	War
37	Western
\.


--
-- TOC entry 3376 (class 0 OID 16985)
-- Dependencies: 225
-- Data for Name: app_searchedmovie; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.app_searchedmovie (id, count, movie_id, user_id) FROM stdin;
1	1	603	5
2	1	627	5
3	1	420817	9
4	1	529962	9
5	1	99861	9
7	1	299537	10
6	2	420817	10
8	1	287947	10
9	1	18785	10
10	1	578	11
11	1	8413	11
12	1	458156	11
13	1	420817	11
14	1	15969	12
15	1	420817	12
16	1	535581	12
17	1	299537	1
18	1	299534	1
19	1	412117	1
\.


--
-- TOC entry 3366 (class 0 OID 16907)
-- Dependencies: 215
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.app_user (id, type, user_id) FROM stdin;
9	R	9
10	R	10
12	R	12
1	A	1
7	E	7
8	E	8
11	R	11
4	A	4
2	A	2
3	A	3
5	E	5
6	E	6
\.


--
-- TOC entry 3354 (class 0 OID 16787)
-- Dependencies: 203
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- TOC entry 3356 (class 0 OID 16797)
-- Dependencies: 205
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- TOC entry 3352 (class 0 OID 16779)
-- Dependencies: 201
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add user	1	add_user
2	Can change user	1	change_user
3	Can delete user	1	delete_user
4	Can view user	1	view_user
5	Can add message	2	add_message
6	Can change message	2	change_message
7	Can delete message	2	delete_message
8	Can view message	2	view_message
9	Can add movie genre	3	add_moviegenre
10	Can change movie genre	3	change_moviegenre
11	Can delete movie genre	3	delete_moviegenre
12	Can view movie genre	3	view_moviegenre
13	Can add movie	4	add_movie
14	Can change movie	4	change_movie
15	Can delete movie	4	delete_movie
16	Can view movie	4	view_movie
17	Can add expert picks category	5	add_expertpickscategory
18	Can change expert picks category	5	change_expertpickscategory
19	Can delete expert picks category	5	delete_expertpickscategory
20	Can view expert picks category	5	view_expertpickscategory
21	Can add searched movie	6	add_searchedmovie
22	Can change searched movie	6	change_searchedmovie
23	Can delete searched movie	6	delete_searchedmovie
24	Can view searched movie	6	view_searchedmovie
25	Can add collected movie	7	add_collectedmovie
26	Can change collected movie	7	change_collectedmovie
27	Can delete collected movie	7	delete_collectedmovie
28	Can view collected movie	7	view_collectedmovie
29	Can add expert pick movie	8	add_expertpickmovie
30	Can change expert pick movie	8	change_expertpickmovie
31	Can delete expert pick movie	8	delete_expertpickmovie
32	Can view expert pick movie	8	view_expertpickmovie
33	Can add log entry	9	add_logentry
34	Can change log entry	9	change_logentry
35	Can delete log entry	9	delete_logentry
36	Can view log entry	9	view_logentry
37	Can add permission	10	add_permission
38	Can change permission	10	change_permission
39	Can delete permission	10	delete_permission
40	Can view permission	10	view_permission
41	Can add group	11	add_group
42	Can change group	11	change_group
43	Can delete group	11	delete_group
44	Can view group	11	view_group
45	Can add user	12	add_user
46	Can change user	12	change_user
47	Can delete user	12	delete_user
48	Can view user	12	view_user
49	Can add content type	13	add_contenttype
50	Can change content type	13	change_contenttype
51	Can delete content type	13	delete_contenttype
52	Can view content type	13	view_contenttype
53	Can add session	14	add_session
54	Can change session	14	change_session
55	Can delete session	14	delete_session
56	Can view session	14	view_session
\.


--
-- TOC entry 3358 (class 0 OID 16805)
-- Dependencies: 207
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$150000$HOOZirawGqfH$gt2984OHLmoTjvEXEO40cgb4l0pDe3YF+TwbDl19mOc=	2019-06-04 21:23:24+02	t	admin2			admin2@gmail.com	t	t	2019-05-29 13:42:42+02
3	pbkdf2_sha256$150000$WVawocxjtLr8$aJEGcEQIpeOgPiOZ/re8b5F55I0RwidwtmD2ac35Au8=	2019-06-04 22:43:18+02	t	admin3			admin3@gmail.com	t	t	2019-05-29 10:02:23+02
5	pbkdf2_sha256$150000$liSdBFpGdrA8$fXia2kJZ+AA8pmeyas1o2JCHthlqIrfeciupNtDP4Ik=	2019-06-04 21:42:45+02	f	ekspert1	Ana	Milanovic	ana@gmail.com	f	t	2019-06-03 21:16:29+02
6	pbkdf2_sha256$150000$JtUpLDfGRPbU$+ECM8lGCRQQ3xubTx00ayQfCAZSoSiJt2taha6Go3mk=	2019-06-04 21:43:06+02	f	ekspert2	Sanja	Mijović	sanja@gmail.com	f	t	2019-06-02 21:21:58+02
9	pbkdf2_sha256$150000$qEBGAgOevVGv$qL/Hp7tC+Fr4FSI00SktI9EMnZCGI38yy9chdQEtHo8=	2019-06-06 18:52:11.733314+02	f	korisnik1	Petar	Petrovic	petar@gmail.com	f	t	2019-06-04 22:29:50.951445+02
10	pbkdf2_sha256$150000$xUM62uOAEoqf$9J0YQ1U923KaxyeebqcQwyizE3zEeuGjUxhxAekYNjc=	2019-06-06 18:52:31.594612+02	f	korisnik2	Marija	Maric	mara@gmail.com	f	t	2019-06-02 22:35:13+02
12	pbkdf2_sha256$150000$Gmo8IH6Y9PI7$PQiShkX62AuMi+Zpcsk1r+Gzru9tZsb/WjwwgL1tnBg=	2019-06-06 18:53:02.794543+02	f	korisnik4	Marko	Petrovic	mare@gmail.com	f	t	2019-05-30 22:39:42+02
1	pbkdf2_sha256$150000$kwMGYs5Fa8X6$fiMwNVdlaD0wF1ozWKJC1a2dUyP3NIJsyF7k3kYZkaU=	2019-06-06 18:53:14.705564+02	t	admin1			admin1@gmail.com	t	t	2019-05-27 16:35:15+02
7	pbkdf2_sha256$150000$j7tzMKgbrN0i$adxOPA0rTPAnT9wj7nUa0J7bbqgcjeHdUFdtZ0sqgH4=	2019-06-04 21:43:18.995906+02	f	ekspert3	Vukasin	Manojlovic	vule@gmail.com	f	t	2019-06-04 21:23:09.815255+02
8	pbkdf2_sha256$150000$XlAvUxerUPqw$L6aVW/dxFfIU5eI6K2DIeIpdz8WPZbUibnEPlvmNp78=	2019-06-04 21:43:37.046364+02	f	ekspert4	Nemanja	Divnic	neca@gmail.com	f	t	2019-06-04 21:24:18.591423+02
11	pbkdf2_sha256$150000$gLVnxSDfXPWR$YVckilp8mIai1WBB90W3ePnVjSHNUePGXtin391WWVE=	2019-06-04 22:37:45.542605+02	f	korisnik3	Luka	Ilic	luka@gmail.com	f	t	2019-06-04 22:37:45.33032+02
4	pbkdf2_sha256$150000$c8Sbn7BxJz6Q$1/RM9XRzrDJ2t3pIg0YH5C7dSopctEcOrv6eBKnp/TM=	2019-06-04 22:43:30+02	t	admin4			admin4@gmail.com	t	t	2019-06-02 22:45:58+02
\.


--
-- TOC entry 3360 (class 0 OID 16815)
-- Dependencies: 209
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- TOC entry 3362 (class 0 OID 16823)
-- Dependencies: 211
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- TOC entry 3364 (class 0 OID 16883)
-- Dependencies: 213
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2019-06-04 22:46:00.308305+02	4	admin4	2	[{"changed": {"fields": ["date_joined"]}}]	12	1
2	2019-06-04 22:46:28.549989+02	1	admin1	2	[{"changed": {"fields": ["last_login"]}}]	12	1
3	2019-06-04 22:46:57.725055+02	1	admin1	2	[{"changed": {"fields": ["last_login", "date_joined"]}}]	12	1
4	2019-06-04 22:47:14.642993+02	2	admin2	2	[{"changed": {"fields": ["date_joined"]}}]	12	1
5	2019-06-04 22:47:40.212517+02	3	admin3	2	[{"changed": {"fields": ["date_joined"]}}]	12	1
6	2019-06-04 22:48:20.008274+02	5	ekspert1	2	[{"changed": {"fields": ["date_joined"]}}]	12	1
7	2019-06-04 22:48:42.317637+02	6	ekspert2	2	[{"changed": {"fields": ["date_joined"]}}]	12	1
8	2019-06-04 22:48:48.853459+02	10	korisnik2	2	[{"changed": {"fields": ["date_joined"]}}]	12	1
9	2019-06-04 22:49:53.294104+02	12	korisnik4	2	[{"changed": {"fields": ["date_joined"]}}]	12	1
10	2019-06-04 22:50:25.398191+02	1	admin1	2	[{"changed": {"fields": ["date_joined"]}}]	12	1
\.


--
-- TOC entry 3350 (class 0 OID 16769)
-- Dependencies: 199
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	app	user
2	app	message
3	app	moviegenre
4	app	movie
5	app	expertpickscategory
6	app	searchedmovie
7	app	collectedmovie
8	app	expertpickmovie
9	admin	logentry
10	auth	permission
11	auth	group
12	auth	user
13	contenttypes	contenttype
14	sessions	session
\.


--
-- TOC entry 3348 (class 0 OID 16758)
-- Dependencies: 197
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2019-06-04 21:10:15.133451+02
2	auth	0001_initial	2019-06-04 21:10:15.182251+02
3	admin	0001_initial	2019-06-04 21:10:15.229934+02
4	admin	0002_logentry_remove_auto_add	2019-06-04 21:10:15.248131+02
5	admin	0003_logentry_add_action_flag_choices	2019-06-04 21:10:15.264486+02
6	app	0001_initial	2019-06-04 21:10:15.286896+02
7	app	0002_message	2019-06-04 21:10:15.318151+02
8	app	0003_movie_moviegenre	2019-06-04 21:10:15.348419+02
9	app	0004_expertpickscategory	2019-06-04 21:10:15.380274+02
10	app	0005_searchedmovie	2019-06-04 21:10:15.413403+02
11	app	0006_collectedmovie	2019-06-04 21:10:15.442843+02
12	app	0007_expertpickmovie	2019-06-04 21:10:15.490762+02
13	app	0008_auto_20190416_0022	2019-06-04 21:10:15.531171+02
14	app	0009_auto_20190507_1557	2019-06-04 21:10:47.706781+02
15	app	0010_auto_20190514_1804	2019-06-04 21:10:47.768221+02
16	app	0011_auto_20190516_1202	2019-06-04 21:10:47.78027+02
17	app	0012_auto_20190516_2046	2019-06-04 21:10:47.789988+02
18	app	0013_remove_message_type	2019-06-04 21:10:47.804789+02
19	app	0014_auto_20190517_2232	2019-06-04 21:10:47.823954+02
20	app	0015_auto_20190530_1125	2019-06-04 21:10:47.850413+02
21	app	0016_auto_20190603_1206	2019-06-04 21:10:47.865547+02
22	contenttypes	0002_remove_content_type_name	2019-06-04 21:10:47.951545+02
23	auth	0002_alter_permission_name_max_length	2019-06-04 21:10:47.963253+02
24	auth	0003_alter_user_email_max_length	2019-06-04 21:10:47.974024+02
25	auth	0004_alter_user_username_opts	2019-06-04 21:10:47.989295+02
26	auth	0005_alter_user_last_login_null	2019-06-04 21:10:48.009875+02
27	auth	0006_require_contenttypes_0002	2019-06-04 21:10:48.012649+02
28	auth	0007_alter_validators_add_error_messages	2019-06-04 21:10:48.02978+02
29	auth	0008_alter_user_username_max_length	2019-06-04 21:10:48.05493+02
30	auth	0009_alter_user_last_name_max_length	2019-06-04 21:10:48.076065+02
31	auth	0010_alter_group_name_max_length	2019-06-04 21:10:48.104094+02
32	auth	0011_update_proxy_permissions	2019-06-04 21:10:48.137688+02
33	sessions	0001_initial	2019-06-04 21:10:48.160987+02
\.


--
-- TOC entry 3381 (class 0 OID 17067)
-- Dependencies: 230
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: filminds
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
1obu6ry2p6whskt0yhls5xh9rb68mu6s	NmFlMzBjOGM0YzIwODM2ZjljZTgyYWRkY2RhMTllMTgwY2YyN2IxNzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NDU0NWZkZWI3ODllMDA5ZmRmMmU2MjUyZWU2NDlkZjE3ZjY5NTNkIn0=	2019-06-18 22:45:30.019292+02
\.


--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 226
-- Name: app_collectedmovie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.app_collectedmovie_id_seq', 33, true);


--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 228
-- Name: app_expertpickmovie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.app_expertpickmovie_id_seq', 66, true);


--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 222
-- Name: app_expertpickscategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.app_expertpickscategory_id_seq', 1, false);


--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 216
-- Name: app_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.app_message_id_seq', 34, true);


--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 220
-- Name: app_movie_genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.app_movie_genres_id_seq', 138, true);


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 224
-- Name: app_searchedmovie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.app_searchedmovie_id_seq', 19, true);


--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 214
-- Name: app_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.app_user_id_seq', 12, true);


--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 202
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 204
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 200
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 56, true);


--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 208
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 206
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 12, true);


--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 210
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 212
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 10, true);


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 198
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 14, true);


--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 196
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: filminds
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 33, true);


--
-- TOC entry 3196 (class 2606 OID 17010)
-- Name: app_collectedmovie app_collectedmovie_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_collectedmovie
    ADD CONSTRAINT app_collectedmovie_pkey PRIMARY KEY (id);


--
-- TOC entry 3201 (class 2606 OID 17030)
-- Name: app_expertpickmovie app_expertpickmovie_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_expertpickmovie
    ADD CONSTRAINT app_expertpickmovie_pkey PRIMARY KEY (id);


--
-- TOC entry 3189 (class 2606 OID 16976)
-- Name: app_expertpickscategory app_expertpickscategory_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_expertpickscategory
    ADD CONSTRAINT app_expertpickscategory_pkey PRIMARY KEY (id);


--
-- TOC entry 3175 (class 2606 OID 16930)
-- Name: app_message app_message_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_message
    ADD CONSTRAINT app_message_pkey PRIMARY KEY (id);


--
-- TOC entry 3183 (class 2606 OID 16966)
-- Name: app_movie_genres app_movie_genres_movie_id_moviegenre_id_4f2bdf09_uniq; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_movie_genres
    ADD CONSTRAINT app_movie_genres_movie_id_moviegenre_id_4f2bdf09_uniq UNIQUE (movie_id, moviegenre_id);


--
-- TOC entry 3186 (class 2606 OID 16954)
-- Name: app_movie_genres app_movie_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_movie_genres
    ADD CONSTRAINT app_movie_genres_pkey PRIMARY KEY (id);


--
-- TOC entry 3180 (class 2606 OID 16946)
-- Name: app_movie app_movie_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_movie
    ADD CONSTRAINT app_movie_pkey PRIMARY KEY (id);


--
-- TOC entry 3178 (class 2606 OID 16941)
-- Name: app_moviegenre app_moviegenre_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_moviegenre
    ADD CONSTRAINT app_moviegenre_pkey PRIMARY KEY (id);


--
-- TOC entry 3192 (class 2606 OID 16990)
-- Name: app_searchedmovie app_searchedmovie_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_searchedmovie
    ADD CONSTRAINT app_searchedmovie_pkey PRIMARY KEY (id);


--
-- TOC entry 3171 (class 2606 OID 16912)
-- Name: app_user app_user_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);


--
-- TOC entry 3173 (class 2606 OID 16914)
-- Name: app_user app_user_user_id_key; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_user_id_key UNIQUE (user_id);


--
-- TOC entry 3140 (class 2606 OID 17065)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 3145 (class 2606 OID 16849)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 3148 (class 2606 OID 16802)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3142 (class 2606 OID 16792)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3135 (class 2606 OID 16835)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 3137 (class 2606 OID 16784)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3156 (class 2606 OID 16820)
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3159 (class 2606 OID 16864)
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 3150 (class 2606 OID 16810)
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 3162 (class 2606 OID 16828)
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3165 (class 2606 OID 16878)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 3153 (class 2606 OID 17059)
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- TOC entry 3168 (class 2606 OID 16892)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3130 (class 2606 OID 16776)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 3132 (class 2606 OID 16774)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3128 (class 2606 OID 16766)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3204 (class 2606 OID 17074)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 3194 (class 1259 OID 17021)
-- Name: app_collectedmovie_movie_id_4489b3e6; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX app_collectedmovie_movie_id_4489b3e6 ON public.app_collectedmovie USING btree (movie_id);


--
-- TOC entry 3197 (class 1259 OID 17022)
-- Name: app_collectedmovie_user_id_96c6f841; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX app_collectedmovie_user_id_96c6f841 ON public.app_collectedmovie USING btree (user_id);


--
-- TOC entry 3198 (class 1259 OID 17041)
-- Name: app_expertpickmovie_category_id_28562f76; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX app_expertpickmovie_category_id_28562f76 ON public.app_expertpickmovie USING btree (category_id);


--
-- TOC entry 3199 (class 1259 OID 17042)
-- Name: app_expertpickmovie_movie_id_4627644f; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX app_expertpickmovie_movie_id_4627644f ON public.app_expertpickmovie USING btree (movie_id);


--
-- TOC entry 3187 (class 1259 OID 16982)
-- Name: app_expertpickscategory_expert_id_2c2b31d8; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX app_expertpickscategory_expert_id_2c2b31d8 ON public.app_expertpickscategory USING btree (expert_id);


--
-- TOC entry 3176 (class 1259 OID 16936)
-- Name: app_message_user_id_5fd14692; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX app_message_user_id_5fd14692 ON public.app_message USING btree (user_id);


--
-- TOC entry 3181 (class 1259 OID 16967)
-- Name: app_movie_genres_movie_id_54553bc8; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX app_movie_genres_movie_id_54553bc8 ON public.app_movie_genres USING btree (movie_id);


--
-- TOC entry 3184 (class 1259 OID 16968)
-- Name: app_movie_genres_moviegenre_id_71966712; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX app_movie_genres_moviegenre_id_71966712 ON public.app_movie_genres USING btree (moviegenre_id);


--
-- TOC entry 3190 (class 1259 OID 17001)
-- Name: app_searchedmovie_movie_id_a9ca719a; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX app_searchedmovie_movie_id_a9ca719a ON public.app_searchedmovie USING btree (movie_id);


--
-- TOC entry 3193 (class 1259 OID 17002)
-- Name: app_searchedmovie_user_id_ce2348ea; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX app_searchedmovie_user_id_ce2348ea ON public.app_searchedmovie USING btree (user_id);


--
-- TOC entry 3138 (class 1259 OID 17066)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 3143 (class 1259 OID 16850)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 3146 (class 1259 OID 16851)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 3133 (class 1259 OID 16836)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 3154 (class 1259 OID 16866)
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- TOC entry 3157 (class 1259 OID 16865)
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- TOC entry 3160 (class 1259 OID 16880)
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 3163 (class 1259 OID 16879)
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- TOC entry 3151 (class 1259 OID 17060)
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 3166 (class 1259 OID 16903)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 3169 (class 1259 OID 16904)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 3202 (class 1259 OID 17076)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 3205 (class 1259 OID 17075)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: filminds
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 3222 (class 2606 OID 17011)
-- Name: app_collectedmovie app_collectedmovie_movie_id_4489b3e6_fk_app_movie_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_collectedmovie
    ADD CONSTRAINT app_collectedmovie_movie_id_4489b3e6_fk_app_movie_id FOREIGN KEY (movie_id) REFERENCES public.app_movie(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3223 (class 2606 OID 17016)
-- Name: app_collectedmovie app_collectedmovie_user_id_96c6f841_fk_app_user_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_collectedmovie
    ADD CONSTRAINT app_collectedmovie_user_id_96c6f841_fk_app_user_id FOREIGN KEY (user_id) REFERENCES public.app_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3224 (class 2606 OID 17031)
-- Name: app_expertpickmovie app_expertpickmovie_category_id_28562f76_fk_app_exper; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_expertpickmovie
    ADD CONSTRAINT app_expertpickmovie_category_id_28562f76_fk_app_exper FOREIGN KEY (category_id) REFERENCES public.app_expertpickscategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3225 (class 2606 OID 17036)
-- Name: app_expertpickmovie app_expertpickmovie_movie_id_4627644f_fk_app_movie_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_expertpickmovie
    ADD CONSTRAINT app_expertpickmovie_movie_id_4627644f_fk_app_movie_id FOREIGN KEY (movie_id) REFERENCES public.app_movie(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3219 (class 2606 OID 16977)
-- Name: app_expertpickscategory app_expertpickscategory_expert_id_2c2b31d8_fk_app_user_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_expertpickscategory
    ADD CONSTRAINT app_expertpickscategory_expert_id_2c2b31d8_fk_app_user_id FOREIGN KEY (expert_id) REFERENCES public.app_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3216 (class 2606 OID 16931)
-- Name: app_message app_message_user_id_5fd14692_fk_app_user_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_message
    ADD CONSTRAINT app_message_user_id_5fd14692_fk_app_user_id FOREIGN KEY (user_id) REFERENCES public.app_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3217 (class 2606 OID 16955)
-- Name: app_movie_genres app_movie_genres_movie_id_54553bc8_fk_app_movie_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_movie_genres
    ADD CONSTRAINT app_movie_genres_movie_id_54553bc8_fk_app_movie_id FOREIGN KEY (movie_id) REFERENCES public.app_movie(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3218 (class 2606 OID 16960)
-- Name: app_movie_genres app_movie_genres_moviegenre_id_71966712_fk_app_moviegenre_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_movie_genres
    ADD CONSTRAINT app_movie_genres_moviegenre_id_71966712_fk_app_moviegenre_id FOREIGN KEY (moviegenre_id) REFERENCES public.app_moviegenre(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3220 (class 2606 OID 16991)
-- Name: app_searchedmovie app_searchedmovie_movie_id_a9ca719a_fk_app_movie_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_searchedmovie
    ADD CONSTRAINT app_searchedmovie_movie_id_a9ca719a_fk_app_movie_id FOREIGN KEY (movie_id) REFERENCES public.app_movie(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3221 (class 2606 OID 17043)
-- Name: app_searchedmovie app_searchedmovie_user_id_ce2348ea_fk_app_user_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_searchedmovie
    ADD CONSTRAINT app_searchedmovie_user_id_ce2348ea_fk_app_user_id FOREIGN KEY (user_id) REFERENCES public.app_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3215 (class 2606 OID 16915)
-- Name: app_user app_user_user_id_91abd4b7_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_user_id_91abd4b7_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3208 (class 2606 OID 16843)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3207 (class 2606 OID 16838)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3206 (class 2606 OID 16829)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3210 (class 2606 OID 16858)
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3209 (class 2606 OID 16853)
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3212 (class 2606 OID 16872)
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3211 (class 2606 OID 16867)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3213 (class 2606 OID 16893)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3214 (class 2606 OID 16898)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: filminds
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2019-06-06 18:55:19 CEST

--
-- PostgreSQL database dump complete
--

