--
-- PostgreSQL database dump
--

-- Dumped from database version 11.9 (Raspbian 11.9-0+deb10u1)
-- Dumped by pg_dump version 11.9 (Raspbian 11.9-0+deb10u1)

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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: users; Type: TABLE; Schema: public; Owner: vicnie
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.users OWNER TO vicnie;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: vicnie
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO vicnie;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicnie
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: wishes; Type: TABLE; Schema: public; Owner: vicnie
--

CREATE TABLE public.wishes (
    id integer NOT NULL,
    wish character varying(255),
    name character varying(255),
    bought boolean DEFAULT false NOT NULL,
    buyer character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.wishes OWNER TO vicnie;

--
-- Name: wishes_id_seq; Type: SEQUENCE; Schema: public; Owner: vicnie
--

CREATE SEQUENCE public.wishes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wishes_id_seq OWNER TO vicnie;

--
-- Name: wishes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicnie
--

ALTER SEQUENCE public.wishes_id_seq OWNED BY public.wishes.id;


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: wishes id; Type: DEFAULT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.wishes ALTER COLUMN id SET DEFAULT nextval('public.wishes_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vicnie
--

COPY public.users (id, name, email, "createdAt", "updatedAt") FROM stdin;
1	ludwig	ludwig.onnered@gmail.com	2019-01-23 21:20:56.695+01	2019-01-23 21:20:56.695+01
2	simon	simonfsonnered@gmail.com	2019-01-23 21:20:56.695+01	2019-01-23 21:20:56.695+01
3	annie	annie.onnered@gmail.com	2019-01-23 21:20:56.695+01	2019-01-23 21:20:56.695+01
4	mamma	gunnel.onnered@gmail.com	2019-01-23 21:20:56.696+01	2019-01-23 21:20:56.696+01
5	pappa	hbgjolu@gmail.com	2019-01-23 21:20:56.696+01	2019-01-23 21:20:56.696+01
\.


--
-- Data for Name: wishes; Type: TABLE DATA; Schema: public; Owner: vicnie
--

COPY public.wishes (id, wish, name, bought, buyer, "createdAt", "updatedAt") FROM stdin;
90	Vattenpass (hög kvalité) 	simon	f	\N	2020-01-18 20:38:13.496+01	2020-01-18 20:38:13.496+01
77	Dyrt ....Viven Nilsson halsband ( Ok för dyrt )	mamma	f	\N	2019-11-25 21:27:06.475+01	2019-11-25 21:27:06.475+01
58	Dagryggsäck ,Ohaus 	mamma	f	\N	2019-07-09 19:02:13.785+02	2019-07-09 19:02:13.785+02
102	Kläder, ge mig pengar så köper jag 	ludwig	f	\N	2020-06-07 14:01:48.319+02	2020-06-07 14:01:48.319+02
29	Almanackan	mamma	t	ludwig	2019-01-23 21:32:23.446+01	2019-11-03 17:33:31.217+01
25	Snälla barn	mamma	t	simon	2019-01-23 21:31:35.335+01	2019-11-09 00:31:51.614+01
76	Ljusstake Celeste randig grön guld randig /finns bara på typ Tradera 	mamma	t	annie	2019-11-25 21:26:08.113+01	2020-06-10 14:38:35.439+02
30	Fotoalmamacka till köpet,lagom stor	mamma	f		2019-01-23 21:32:58.221+01	2019-12-10 15:43:04.645+01
105	Weekendbag 	ludwig	f	\N	2020-10-11 11:55:32.687+02	2020-10-11 11:55:32.687+02
106	Gröna skogsbyxor	annie	f	\N	2020-10-17 13:45:46.466+02	2020-10-17 13:45:46.466+02
87	Innetofflor	pappa	f	\N	2019-12-17 22:17:24.908+01	2019-12-17 22:17:24.908+01
107	Långärmad träningströja	annie	f	\N	2020-10-17 13:46:02.919+02	2020-10-17 13:46:02.919+02
108	Lord of the flies bok/pocket (engelska)	simon	f	\N	2020-10-22 22:12:35.31+02	2020-10-22 22:12:51.124+02
27	Morgontofflor	mamma	f		2019-01-23 21:32:03.966+01	2019-12-19 20:14:13.01+01
109	After shave (lotion/balm)	simon	f	\N	2020-10-22 22:13:06.656+02	2020-10-22 22:13:40.701+02
104	Kavaj	annie	f	\N	2020-07-10 11:40:47.314+02	2020-11-06 18:13:36.357+01
32	C G kopp guldvarianten	mamma	t	ludwig	2019-01-23 21:33:17.099+01	2020-11-07 10:01:19.607+01
112	En Spotify lista där du valt 10 ? låtar som du gillar och tror att jag skulle vilja lyssna på.	mamma	f	\N	2020-11-07 10:02:30.143+01	2020-11-07 10:02:30.143+01
113	löpar tights, inte fel med mer än 1 par. inte supertjocka	simon	f	\N	2020-11-07 10:17:09.12+01	2020-11-07 10:17:24.06+01
114	Carisma servis	annie	f	\N	2020-11-07 13:19:32.236+01	2020-11-07 13:19:32.236+01
100	Skärbräda, tjock stor jävel	ludwig	t	annie	2020-06-07 14:00:45.149+02	2020-11-11 17:06:42.142+01
110	en flaska fin calvados	simon	f		2020-10-24 19:41:52.873+02	2020-11-11 19:08:25.647+01
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicnie
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: wishes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicnie
--

SELECT pg_catalog.setval('public.wishes_id_seq', 114, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wishes wishes_pkey; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.wishes
    ADD CONSTRAINT wishes_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

