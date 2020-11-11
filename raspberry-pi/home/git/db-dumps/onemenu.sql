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
-- Name: chefs; Type: TABLE; Schema: public; Owner: vicnie
--

CREATE TABLE public.chefs (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    photo character varying(255) NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);


ALTER TABLE public.chefs OWNER TO vicnie;

--
-- Name: chefs_id_seq; Type: SEQUENCE; Schema: public; Owner: vicnie
--

CREATE SEQUENCE public.chefs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chefs_id_seq OWNER TO vicnie;

--
-- Name: chefs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicnie
--

ALTER SEQUENCE public.chefs_id_seq OWNED BY public.chefs.id;


--
-- Name: days; Type: TABLE; Schema: public; Owner: vicnie
--

CREATE TABLE public.days (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    weekday integer NOT NULL,
    "chefId" integer,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);


ALTER TABLE public.days OWNER TO vicnie;

--
-- Name: days_id_seq; Type: SEQUENCE; Schema: public; Owner: vicnie
--

CREATE SEQUENCE public.days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.days_id_seq OWNER TO vicnie;

--
-- Name: days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicnie
--

ALTER SEQUENCE public.days_id_seq OWNED BY public.days.id;


--
-- Name: dishes; Type: TABLE; Schema: public; Owner: vicnie
--

CREATE TABLE public.dishes (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    date date NOT NULL,
    "dayId" integer,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "isSkipped" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.dishes OWNER TO vicnie;

--
-- Name: dishes_id_seq; Type: SEQUENCE; Schema: public; Owner: vicnie
--

CREATE SEQUENCE public.dishes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dishes_id_seq OWNER TO vicnie;

--
-- Name: dishes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicnie
--

ALTER SEQUENCE public.dishes_id_seq OWNED BY public.dishes.id;


--
-- Name: sides; Type: TABLE; Schema: public; Owner: vicnie
--

CREATE TABLE public.sides (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "sidetypeId" integer,
    "dishId" integer NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);


ALTER TABLE public.sides OWNER TO vicnie;

--
-- Name: sides_id_seq; Type: SEQUENCE; Schema: public; Owner: vicnie
--

CREATE SEQUENCE public.sides_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sides_id_seq OWNER TO vicnie;

--
-- Name: sides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicnie
--

ALTER SEQUENCE public.sides_id_seq OWNED BY public.sides.id;


--
-- Name: sidetypes; Type: TABLE; Schema: public; Owner: vicnie
--

CREATE TABLE public.sidetypes (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);


ALTER TABLE public.sidetypes OWNER TO vicnie;

--
-- Name: sidetypes_id_seq; Type: SEQUENCE; Schema: public; Owner: vicnie
--

CREATE SEQUENCE public.sidetypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sidetypes_id_seq OWNER TO vicnie;

--
-- Name: sidetypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicnie
--

ALTER SEQUENCE public.sidetypes_id_seq OWNED BY public.sidetypes.id;


--
-- Name: chefs id; Type: DEFAULT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.chefs ALTER COLUMN id SET DEFAULT nextval('public.chefs_id_seq'::regclass);


--
-- Name: days id; Type: DEFAULT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.days ALTER COLUMN id SET DEFAULT nextval('public.days_id_seq'::regclass);


--
-- Name: dishes id; Type: DEFAULT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.dishes ALTER COLUMN id SET DEFAULT nextval('public.dishes_id_seq'::regclass);


--
-- Name: sides id; Type: DEFAULT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.sides ALTER COLUMN id SET DEFAULT nextval('public.sides_id_seq'::regclass);


--
-- Name: sidetypes id; Type: DEFAULT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.sidetypes ALTER COLUMN id SET DEFAULT nextval('public.sidetypes_id_seq'::regclass);


--
-- Data for Name: chefs; Type: TABLE DATA; Schema: public; Owner: vicnie
--

COPY public.chefs (id, name, email, photo, "createdAt", "updatedAt") FROM stdin;
2	Victor	victor95w@gmail.com	https://lh6.googleusercontent.com/-G-72Y03GkJY/AAAAAAAAAAI/AAAAAAAAI7w/svFGQZhrKFw/photo.jpg	2019-06-15 14:01:45.4	2019-06-15 14:01:45.4
3	Annie	annie.onnered@gmail.com	https://i.pinimg.com/originals/f3/bd/84/f3bd8497e15399201b634714ec5ed390.jpg	2019-06-15 14:04:36.572	2019-06-15 14:04:36.572
\.


--
-- Data for Name: days; Type: TABLE DATA; Schema: public; Owner: vicnie
--

COPY public.days (id, name, weekday, "chefId", "createdAt", "updatedAt") FROM stdin;
1	Cheap Monday	1	\N	2019-06-15 14:09:39.942	2019-06-15 14:09:39.942
2	Regular Tuesday	2	\N	2019-06-15 14:09:47.667	2019-06-15 14:09:47.667
3	Soup n' Pot Day	3	\N	2019-06-15 14:09:58.961	2019-06-15 14:09:58.961
4	Fishy Thursday	4	\N	2019-06-15 14:10:14.239	2019-06-15 14:10:14.239
5	Taco Friday	5	\N	2019-06-15 14:10:24.104	2019-06-15 14:10:24.104
6	Freaky Friday	5	\N	2019-06-15 14:11:20.311	2019-06-15 14:11:20.311
\.


--
-- Data for Name: dishes; Type: TABLE DATA; Schema: public; Owner: vicnie
--

COPY public.dishes (id, name, date, "dayId", "createdAt", "updatedAt", "isSkipped") FROM stdin;
12	Midsommarmat	2019-06-21	\N	2019-06-17 08:01:30.836	2019-06-17 08:01:30.836	f
13	Pasta med kyckling	2019-06-19	\N	2019-06-17 08:34:47.963	2019-06-17 08:34:47.963	f
15	Pasta med bacon	2019-06-17	1	2019-06-17 08:42:07.416	2019-06-17 08:42:07.416	f
16	Pasta med korv	2019-06-18	2	2019-06-17 08:42:13.847	2019-06-17 08:42:13.847	f
17	Gui Satay Kycklingspett	2019-06-26	\N	2019-06-27 14:17:49.961	2019-06-27 14:17:49.961	f
19	Pasta med Bacon	2019-06-24	\N	2019-06-27 14:20:15.241	2019-06-27 14:20:15.241	f
20	Pasta med Pasta	2019-06-20	\N	2019-06-27 14:20:36.992	2019-06-27 14:20:36.992	f
21	Femrätters på Chateau Foret	2019-06-25	\N	2019-06-28 09:39:01.253	2019-06-28 09:39:01.253	f
23	Tacobröd med skinka och ost	2019-06-27	\N	2019-06-28 20:08:09.509	2019-06-28 20:08:09.509	f
24	BK Whopper Meal	2019-06-28	\N	2019-06-28 20:09:40.598	2019-06-28 20:09:40.598	f
31	Rosor Är Röda	2019-07-01	\N	2019-07-01 06:28:25.56	2019-07-01 06:28:25.56	f
32	Violer Är Blå	2019-07-02	\N	2019-07-01 06:28:32.829	2019-07-01 06:28:32.829	f
45	Min Fina Flickvän	2019-07-03	\N	2019-07-04 03:37:39.563	2019-07-04 03:37:39.563	f
53	Jag Saknar Dig Så	2019-07-04	\N	2019-07-04 20:17:16.127	2019-07-04 20:17:16.127	f
54	Älskade älskling! Saknar dig med!  💖💕💞💛💝💜	2019-07-05	\N	2019-07-04 21:07:50.213	2019-07-04 21:07:50.213	f
55	Egengjord sushi	2019-07-23	\N	2019-07-22 09:16:38.377	2019-07-22 09:16:38.377	f
56	Tacos	2019-07-22	\N	2019-07-22 09:16:45.136	2019-07-22 09:16:45.136	f
58	Ribs med potatis	2019-09-02	\N	2019-09-03 16:18:50.404	2019-09-03 16:18:50.404	f
59	Kotlett med potatis 	2019-09-03	\N	2019-09-03 18:57:29.463	2019-09-03 18:57:29.463	f
60	Baguette med kyckling 	2019-09-04	\N	2019-09-05 15:21:36.842	2019-09-05 15:21:36.842	f
61	Lax med bulgur och citronsås	2019-09-05	\N	2019-09-06 11:23:52.67	2019-09-06 11:23:52.67	f
65	Ärtsoppa och punsch 	2019-09-06	\N	2019-09-10 11:52:21.906	2019-09-10 11:52:21.906	f
69	Karré med klyftpotatis 	2019-09-09	\N	2019-09-11 15:07:56.055	2019-09-11 15:07:56.055	f
70	Falukorv i ugn och potatismos	2019-09-10	\N	2019-09-11 15:08:01.355	2019-09-11 15:08:01.355	f
71	Pastasallad	2019-09-11	\N	2019-09-12 17:32:26.014	2019-09-12 17:32:26.014	f
78	Pan pizza & Matlåda	2019-09-12	\N	2019-09-15 19:18:32.886	2019-09-15 19:18:32.886	f
79	Angus Burger med Pommes	2019-09-13	\N	2019-09-15 19:18:51.098	2019-09-15 19:18:51.098	f
80	Sprödbakad fisk och potatis	2019-09-16	\N	2019-09-15 19:31:34.686	2019-09-15 19:31:34.686	f
82	Fläskfilégryta med champinjoner	2019-09-17	2	2019-09-15 19:33:17.934	2019-09-15 19:33:17.934	f
85	Kräming pasta med halloumi och tomat 	2019-09-20	6	2019-09-15 19:39:36.74	2019-09-15 19:39:36.74	f
89	A la Familjen Winberg	2019-09-19	\N	2019-09-19 14:15:31.048	2019-09-19 14:15:31.048	f
90	Kycklingwok med teriyakinudlar	2019-09-25	\N	2019-09-19 14:15:38.807	2019-09-19 14:15:38.807	f
92	Var för sig	2019-09-18	\N	2019-09-19 14:16:17.28	2019-09-19 14:16:17.28	f
95	Pastagratäng med köttfärssås 	2019-09-24	\N	2019-09-22 08:29:22.615	2019-09-22 08:29:22.615	f
96	Pastagratäng med köttfärssås 	2019-09-23	1	2019-09-22 08:29:39.818	2019-09-22 08:29:39.818	f
98	Tacos	2019-09-27	5	2019-09-22 08:31:23.971	2019-09-22 08:31:23.971	f
99	AW & Matlåda	2019-09-26	\N	2019-09-30 16:20:28.939	2019-09-30 16:20:28.939	f
100	Lax med klyftpotatis 	2019-09-30	\N	2019-09-30 16:21:14.706	2019-09-30 16:21:14.706	f
102	Sushi 🍣	2019-10-02	\N	2019-09-30 16:24:28.764	2019-09-30 16:24:28.764	f
103	Stekta korv och potatisbitar	2019-10-01	2	2019-09-30 16:25:25.524	2019-09-30 16:25:25.524	f
104	Var för sig	2019-10-04	6	2019-09-30 16:25:37.772	2019-09-30 16:25:37.772	f
105	Kött och potatis 	2019-10-03	\N	2019-10-03 13:54:51.823	2019-10-03 13:54:51.823	f
107	Köttfärsrulle	2019-10-07	1	2019-10-08 04:58:38.898	2019-10-08 04:58:38.898	f
108	IKEA a la carte	2019-10-08	\N	2019-10-09 05:24:30.2	2019-10-09 05:24:30.2	f
110	Blodkorv med lingonsylt och rivna morötter 	2019-10-14	1	2019-10-17 15:59:45.125	2019-10-17 15:59:45.125	f
111	Kycklingwok med grönsaker och nudlar 	2019-10-15	\N	2019-10-17 16:00:10.143	2019-10-17 16:00:10.143	f
113	Lax med potatis 	2019-10-17	4	2019-10-19 10:14:01.056	2019-10-19 10:14:01.056	f
114	Torsk	2019-10-21	\N	2019-10-20 17:32:13.411	2019-10-20 17:32:13.411	f
116	Annie iväg 	2019-10-23	\N	2019-10-20 17:32:38.596	2019-10-20 17:32:38.596	f
117	Pasta och korv	2019-10-24	\N	2019-10-20 17:33:25.617	2019-10-20 17:33:25.617	f
118	Kött och potatis 	2019-10-22	2	2019-10-20 17:33:33.872	2019-10-20 17:33:33.872	f
119	Fira Johan 	2019-10-25	6	2019-10-20 17:34:02.802	2019-10-20 17:34:02.802	f
124	Tacos & Pizza	2019-10-18	5	2019-10-20 17:35:09.54	2019-10-20 17:35:09.54	f
126	Tacos	2019-10-11	5	2019-10-20 17:35:52.532	2019-10-20 17:35:52.532	f
129	Hamburgare och pommes 	2019-10-16	\N	2019-10-20 17:37:57.421	2019-10-20 17:37:57.421	f
130	Pasta och korv	2019-10-28	\N	2019-10-27 17:23:05.984	2019-10-27 17:23:05.984	f
132	Potatis och kött 	2019-10-29	2	2019-10-27 17:23:25.732	2019-10-27 17:23:25.732	f
135	Potatis- och purjolöksoppa	2019-10-30	3	2019-10-31 14:22:50.973	2019-10-31 14:22:50.973	f
136	Vegetarisk Bowl	2019-11-04	\N	2019-11-05 10:19:14.127	2019-11-05 10:19:14.127	f
138	Vegetarisk Bowl med bacon	2019-11-05	\N	2019-11-07 09:35:02.805	2019-11-07 09:35:02.805	f
141	Sötpotatissoppa med cashewnötter 	2019-11-07	\N	2019-11-08 14:37:16.255	2019-11-08 14:37:16.255	f
142	Klassisk gåsmiddag på Grand Hotel	2019-11-06	\N	2019-11-09 16:04:39.995	2019-11-09 16:04:39.995	f
146	Halumi och klyftpotatis 	2019-12-09	1	2019-12-08 18:52:18.616	2019-12-08 18:52:18.616	f
148	-	2019-12-12	\N	2019-12-08 18:53:35.663	2019-12-08 18:53:35.663	f
149	-	2019-12-13	\N	2019-12-08 18:53:39.444	2019-12-08 18:53:39.444	f
150	Pasta spenat tomat Test	2019-12-11	\N	2019-12-10 18:03:23.305	2019-12-10 18:03:23.305	f
151	Falafel	2019-12-10	2	2019-12-10 18:03:27.489	2019-12-10 18:03:27.489	f
\.


--
-- Data for Name: sides; Type: TABLE DATA; Schema: public; Owner: vicnie
--

COPY public.sides (id, name, "sidetypeId", "dishId", "createdAt", "updatedAt") FROM stdin;
1	Mjölk	2	2	2019-06-16 18:54:31.215	2019-06-16 18:54:31.215
2	Glass	1	7	2019-06-17 07:02:15	2019-06-17 07:02:15
3	Pärondryck	2	8	2019-06-17 07:06:02.193	2019-06-17 07:06:02.193
4	Pärondryck	2	9	2019-06-17 07:06:24.785	2019-06-17 07:06:24.785
5	Youtube	1	9	2019-06-17 07:06:24.785	2019-06-17 07:06:24.785
6	Pärondryck	2	10	2019-06-17 07:06:35.731	2019-06-17 07:06:35.731
7	Pärondryck	2	11	2019-06-17 07:07:15.368	2019-06-17 07:07:15.368
8	Alkohol	2	12	2019-06-17 08:01:30.887	2019-06-17 08:01:30.887
9	Pärondryck	2	13	2019-06-17 08:34:48.024	2019-06-17 08:34:48.024
10	Pärondryck	2	15	2019-06-17 08:42:07.45	2019-06-17 08:42:07.45
11	Pärondryck	2	16	2019-06-17 08:42:13.874	2019-06-17 08:42:13.874
12	Öl	2	17	2019-06-27 14:17:50.001	2019-06-27 14:17:50.001
13	Vitt vin	2	18	2019-06-27 14:19:45.066	2019-06-27 14:19:45.066
14	Vitt vin	2	21	2019-06-28 09:39:01.302	2019-06-28 09:39:01.302
15	Cola	2	24	2019-06-28 20:09:40.614	2019-06-28 20:09:40.614
16	Alkoholfritt vin	2	58	2019-09-03 16:18:50.459	2019-09-03 16:18:50.459
17	Ekfatslagrat rödvin	2	62	2019-09-10 11:51:28.838	2019-09-10 11:51:28.838
18	Ekfatslagrat rödvin	2	63	2019-09-10 11:51:43.158	2019-09-10 11:51:43.158
19	Punsch 	2	64	2019-09-10 11:52:07.083	2019-09-10 11:52:07.083
20	Ekfatslagrat rödvin	2	68	2019-09-11 15:07:56.024	2019-09-11 15:07:56.024
21	Ekfatslagrat rödvin	2	69	2019-09-11 15:07:56.089	2019-09-11 15:07:56.089
22	Öl	2	77	2019-09-15 19:17:39.355	2019-09-15 19:17:39.355
23	Cider	2	77	2019-09-15 19:17:39.356	2019-09-15 19:17:39.356
24	Baby Pink	2	77	2019-09-15 19:17:39.356	2019-09-15 19:17:39.356
25	Raspberry Mojito 	2	77	2019-09-15 19:17:39.356	2019-09-15 19:17:39.356
26	Somethin' Noiar	2	78	2019-09-15 19:18:32.91	2019-09-15 19:18:32.91
27	Öl & Cider	2	79	2019-09-15 19:18:51.122	2019-09-15 19:18:51.122
28	Baby Pink	2	79	2019-09-15 19:18:51.123	2019-09-15 19:18:51.123
29	Raspberry Mojito 	2	79	2019-09-15 19:18:51.124	2019-09-15 19:18:51.124
30	Vin	2	123	2019-10-20 17:35:02.231	2019-10-20 17:35:02.231
31	Galaxy	2	123	2019-10-20 17:35:02.234	2019-10-20 17:35:02.234
32	Vin	2	124	2019-10-20 17:35:09.563	2019-10-20 17:35:09.563
33	Galaxy	2	124	2019-10-20 17:35:09.564	2019-10-20 17:35:09.564
\.


--
-- Data for Name: sidetypes; Type: TABLE DATA; Schema: public; Owner: vicnie
--

COPY public.sidetypes (id, name, "createdAt", "updatedAt") FROM stdin;
1	Dessert	2019-06-15 14:13:52.547	2019-06-15 14:13:52.547
2	Drink	2019-06-15 14:13:57.006	2019-06-15 14:13:57.006
\.


--
-- Name: chefs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicnie
--

SELECT pg_catalog.setval('public.chefs_id_seq', 3, true);


--
-- Name: days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicnie
--

SELECT pg_catalog.setval('public.days_id_seq', 6, true);


--
-- Name: dishes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicnie
--

SELECT pg_catalog.setval('public.dishes_id_seq', 151, true);


--
-- Name: sides_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicnie
--

SELECT pg_catalog.setval('public.sides_id_seq', 33, true);


--
-- Name: sidetypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicnie
--

SELECT pg_catalog.setval('public.sidetypes_id_seq', 2, true);


--
-- Name: chefs chefs_email_key; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.chefs
    ADD CONSTRAINT chefs_email_key UNIQUE (email);


--
-- Name: chefs chefs_pkey; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.chefs
    ADD CONSTRAINT chefs_pkey PRIMARY KEY (id);


--
-- Name: days days_name_key; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.days
    ADD CONSTRAINT days_name_key UNIQUE (name);


--
-- Name: days days_pkey; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.days
    ADD CONSTRAINT days_pkey PRIMARY KEY (id);


--
-- Name: dishes dishes_date_key; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT dishes_date_key UNIQUE (date);


--
-- Name: dishes dishes_pkey; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT dishes_pkey PRIMARY KEY (id);


--
-- Name: sides sides_pkey; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.sides
    ADD CONSTRAINT sides_pkey PRIMARY KEY (id);


--
-- Name: sidetypes sidetypes_name_key; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.sidetypes
    ADD CONSTRAINT sidetypes_name_key UNIQUE (name);


--
-- Name: sidetypes sidetypes_pkey; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.sidetypes
    ADD CONSTRAINT sidetypes_pkey PRIMARY KEY (id);


--
-- Name: days days_chefId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.days
    ADD CONSTRAINT "days_chefId_fkey" FOREIGN KEY ("chefId") REFERENCES public.chefs(id) ON DELETE SET NULL;


--
-- Name: dishes dishes_dayId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT "dishes_dayId_fkey" FOREIGN KEY ("dayId") REFERENCES public.days(id) ON DELETE SET NULL;


--
-- Name: sides sides_sidetypeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.sides
    ADD CONSTRAINT "sides_sidetypeId_fkey" FOREIGN KEY ("sidetypeId") REFERENCES public.sidetypes(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

