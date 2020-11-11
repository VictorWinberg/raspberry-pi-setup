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
-- Name: categories; Type: TABLE; Schema: public; Owner: vicnie
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    color character varying(255),
    orderidx integer NOT NULL
);


ALTER TABLE public.categories OWNER TO vicnie;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: vicnie
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO vicnie;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicnie
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: categories_orderidx_seq; Type: SEQUENCE; Schema: public; Owner: vicnie
--

CREATE SEQUENCE public.categories_orderidx_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_orderidx_seq OWNER TO vicnie;

--
-- Name: categories_orderidx_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicnie
--

ALTER SEQUENCE public.categories_orderidx_seq OWNED BY public.categories.orderidx;


--
-- Name: products; Type: TABLE; Schema: public; Owner: vicnie
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    inactive boolean DEFAULT false,
    checked boolean DEFAULT false,
    category integer,
    amount numeric DEFAULT 0,
    unit character varying(50)
);


ALTER TABLE public.products OWNER TO vicnie;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: vicnie
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO vicnie;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicnie
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vicnie
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    photo character varying(255) NOT NULL,
    language character varying(255) NOT NULL
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
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: categories orderidx; Type: DEFAULT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.categories ALTER COLUMN orderidx SET DEFAULT nextval('public.categories_orderidx_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: vicnie
--

COPY public.categories (id, name, color, orderidx) FROM stdin;
1	Flingor & Gryn	rgb(255, 191, 128)	15
9	Dryck	rgb(255, 128, 223)	14
10	Mejeri	rgb(128, 204, 255)	12
12	Kryddor	rgb(153, 230, 153)	11
4	Tacos & Pesto	rgb(255, 128, 128)	9
24	International	#8080ff	10
7	Kött & Chark	rgb(255, 128, 128)	5
8	Ost & Pålägg	rgb(223, 255, 128)	4
3	Pasta & Ris	rgb(255, 230, 128)	8
6	Kolonialvaror	rgb(191, 255, 128)	7
14	Hälsa & Skönhet	rgb(255, 128, 179)	21
16	Annie & Victor 💖	rgb(255, 128, 179)	24
15	Alkohol	rgb(255, 128, 128)	23
22	Kassan	#ffbf80	22
17	Snacks & Godis	#aa80ff	20
18	Tvätt & Städ	#80ffe5	18
11	Fryst	rgb(128, 179, 255)	19
5	Hushåll	rgb(153, 230, 230)	17
25	Baka	#ffe680	16
13	Frukt & Grönt	#80ff80	3
2	Bröd & Bageri	rgb(170, 128, 255)	6
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: vicnie
--

COPY public.products (id, name, inactive, checked, category, amount, unit) FROM stdin;
7	Yogurt	t	f	10	0	\N
15	Kroppkakor	t	f	7	0	\N
17	Pulled Pork	t	f	7	0	\N
28	Senap stark	t	f	6	0	\N
30	Conditioner pink	t	f	14	0	\N
31	Rakhyvlar	t	f	14	0	\N
40	Drumsticks	t	f	11	0	\N
44	Pizza	t	f	11	0	\N
45	Pommes frites	t	f	11	0	\N
47	Grillkrydda	t	f	12	0	\N
48	Kanel	t	f	12	0	\N
49	Oregano	t	f	12	0	\N
56	Tortillachips	t	f	4	0	\N
342	Majonnäs	t	f	6	0	\N
336	Grenadin	t	f	6	0	\N
9	Läsk	t	f	9	0	\N
89	Vit Rom	t	f	15	0	\N
50	Rosmarin	t	f	12	0	\N
311	Tårta	t	f	11	0	\N
310	Selleri	t	f	13	0	\N
20	Jasminris	f	f	3	0	\N
239	1 liters påsar	t	f	5	0	\N
238	Svinto	t	f	5	0	\N
181	Glass	t	f	11	0	\N
3	Grädde	t	f	10	0	\N
8	Apelsinjuice	t	f	9	0	\N
188	Ajax	t	f	5	0	\N
170	Ketchup	t	f	6	0	\N
149	Flingsalt	t	f	12	0	\N
196	Rapsolja	t	f	6	0	\N
86	Chilliflakes	t	f	12	0	\N
85	Ansiktstvätt	t	f	14	0	\N
95	Rostad lök	t	f	6	0	\N
150	Disktrasor	t	f	5	0	\N
163	Salt	t	f	12	0	\N
19	Basmatiris	f	f	3	0	\N
359	Bregott	f	f	10	0	\N
156	Tandpetare	t	f	14	0	\N
155	Plastpåsar	t	f	5	0	\N
106	Hamburgare	t	f	7	0	\N
108	Potatissallad	t	f	10	0	\N
506	Matjesill	f	f	7	1	 st
657	Silvertejp	t	t	5	0	\N
171	Chillisås	t	t	6	0	\N
388	Flytande honung	t	t	25	0	\N
381	Krossade tomater	t	t	6	0	\N
162	Jordnötter	t	t	17	0	\N
540	Gräddfil	t	t	10	0	\N
735	Coca-Cola	t	t	9	0	\N
731	7up	t	t	9	0	\N
305	Tomatpuré	t	t	6	0	\N
508	Gräslök	t	t	13	0	\N
816	Chilisås	t	t	6	0	\N
101	Strösocker	t	t	2	0	\N
199	Lantchips	t	t	17	0	\N
522	Rörsocker	t	t	2	0	\N
430	Dipp	t	t	17	0	\N
580	Diljonsenap	t	t	6	0	\N
585	Haricots Verts	t	t	11	0	\N
16	Påläggskorv - Salami	t	t	7	0	\N
54	Tacobröd	t	t	4	0	\N
912	Vitkål	t	t	13	800	g
920	Kokosgrädde	t	t	6	400	ml
918	Svarta böner	t	t	6	380	g
125	Kött	t	t	7	0	\N
676	Mirin	t	t	24	0	\N
677	Tahini	t	t	24	0	\N
133	Mynta	t	t	12	0	\N
14	Korv - ex. Chorizo	t	t	7	0	\N
272	Balsam	t	t	14	0	\N
79	Tandkräm	t	t	14	0	\N
37	Toalettpapper	t	t	18	0	\N
57	Potatis	t	t	13	0	\N
135	Champinjoner	t	t	13	0	\N
916	Majskolv	t	t	13	4	st
58	Sallad	t	t	13	0	\N
914	Salladslök	t	t	13	300	g
5	Mjölk	t	t	10	3	 st
509	Ägg	t	t	10	0	\N
62	Min Kärlek 💛💝💜❤️	f	f	16	0	\N
1	A-fil	t	t	10	0	\N
784	Sesamolja	t	t	6	0	\N
755	Kastanjechampinjoner	t	t	13	0	\N
460	Basilika	t	t	13	0	\N
797	Körsbärstomater	t	t	13	0	\N
872	Rucula	t	t	13	0	\N
752	Svampbuljong	t	t	6	0	\N
894	Kavjar	t	t	6	0	\N
38	Tvättmedel color	t	t	18	0	\N
767	Rostebröd	t	t	2	0	\N
39	Tvättmedel vit	t	t	18	0	\N
889	Tacochips	t	t	4	0	\N
868	Tvål	t	t	14	0	\N
32	Shampoo	t	t	14	0	\N
42	Kyckling	t	t	8	0	\N
80	Baguetter	t	t	2	0	\N
869	Salladsdressing	t	t	6	0	\N
813	Böngroddar	t	t	6	0	\N
52	Pesto - Basilika	t	t	4	0	\N
664	Jordnötssmör	t	t	24	0	\N
197	Dijonsenap	t	t	6	0	\N
268	Bröd	t	t	2	0	\N
782	Sockerärtor	t	t	6	0	\N
35	Diskmedel	t	t	5	0	\N
740	Tapenade (Svarta oliver ICA)	t	t	6	0	\N
22	Spaghetti	t	t	3	0	\N
380	Schalottenlök	t	t	13	0	\N
818	Fizzy pop	t	t	17	0	\N
758	Parmesanost	t	t	8	0	\N
753	Carnaroli- eller arborioris	t	t	3	0	\N
754	Matlagningsvin	t	t	9	0	\N
744	Stöbakad fisk 	t	t	11	0	\N
778	Äggnudlar	t	t	3	0	\N
822	Sura Colanappar	t	t	17	0	\N
688	Silverlök	t	t	13	0	\N
729	Ljus choklad 	t	t	25	0	\N
51	Vitlök	t	t	13	0	\N
276	Citron	t	t	13	0	\N
267	Risgrynsgröt	t	t	7	0	\N
661	Tofu	t	t	24	0	\N
666	Svart ris	t	t	3	0	\N
708	Philadelphiaost	t	t	8	0	\N
879	Risifrutti	t	t	10	0	\N
46	Fetaost	t	t	8	0	\N
462	Vitpeppar	t	t	12	0	\N
10	Måltidsdryck	t	t	9	0	\N
710	Digestivekex 	t	t	8	0	\N
103	Honung	t	t	6	0	\N
27	Olivolja	t	t	6	0	\N
653	Persilja	t	t	11	0	\N
537	Lime	t	t	13	0	\N
652	Brödkrutonger	t	t	2	0	\N
655	Winerkorv	t	t	7	0	\N
102	Bomullspads	t	t	14	0	\N
489	Paprikapuler	t	t	12	0	\N
34	Fruktmüsli	t	t	1	0	\N
33	Crunchy	t	t	1	0	\N
11	Bacon	t	t	7	0	\N
281	Bulgur	t	t	3	0	\N
131	Blandfärs	t	t	7	0	\N
616	Woksås (Asian woksause)	t	t	6	0	\N
70	Gurka 2	f	f	14	0	
23	Bearnaisesås	t	t	6	0	\N
663	Avokado	t	t	13	2	 st
447	Paprika	f	f	13	0	\N
29	Soltorkade tomater	f	f	6	0	\N
591	Remouladsås 	t	t	6	0	\N
2	Creme Fraiche 	f	f	10	0	\N
105	Flytande smör	t	t	10	0	\N
425	Toalettrengöring	t	t	18	0	\N
426	Fönsterputs	t	t	18	0	\N
25	Chillibea	t	t	6	0	\N
521	Värktabletter	t	t	22	0	\N
55	Tacosås	t	t	4	0	\N
324	Limejuice på flaska	t	t	13	0	\N
53	Pesto - Soltorkad tomat	t	t	4	0	\N
922	Tortillabröd	t	t	4	0	\N
78	Ost	t	t	8	0	\N
725	Brun farin	t	t	25	0	\N
728	Sirap	t	t	25	0	\N
726	Smörpapper 	t	t	5	0	\N
658	Vanlig tejp	t	t	5	0	\N
6	Smör	t	t	10	0	\N
36	Hushållspapper	t	t	18	0	\N
665	Gulbetor	t	t	13	0	\N
615	Wokgrönsaker 	t	t	11	0	\N
43	Lax	t	t	11	0	\N
672	Ingefära	t	t	13	0	\N
473	Rödlök	t	t	13	0	\N
257	Passerade tomater	t	t	6	400	g
606	Fönsterskrapa	t	t	5	0	\N
785	Blomkål	t	t	13	0	\N
857	Sesamfrön	t	t	12	0	\N
41	Färdigmat	t	t	11	0	\N
756	Vegofärs	t	t	11	0	\N
823	Post	t	t	22	0	\N
107	Hamburgebröd	t	t	2	0	\N
919	Risvinäger	t	t	6	0	\N
926	Grönsaksfond	t	t	6	0	\N
687	Chilli	t	t	13	4	st
259	Gul lök	t	t	13	3	st
686	Koriander	t	t	13	2	 krukor
312	Morötter	t	t	13	300	g
59	Sötpotatis	t	t	13	100	kg
383	Halloumiost	t	t	8	2	st
139	Mozarellaost	t	t	8	150	g
673	Kokosmjölk	t	t	6	500	ml
590	Mjölig Potatis	t	t	3	1.5	kg
699	Saffran	t	t	22	4	pkt
116	Nudlar	f	f	3	0	\N
187	Tops	t	t	14	0	\N
504	Färskpotatis	t	t	13	0	\N
217	Creme Fraiche - soltorkad tomat	t	t	10	0	\N
87	Fläckborttagningsmedel	t	t	5	0	\N
134	Purjolök	t	t	13	0	\N
717	Babyspenat	t	t	13	65	g
705	Apelsin	t	t	13	2	st
636	Zucchini	t	t	13	0	\N
382	Spenat	t	t	13	0	\N
13	Fläskfilé	t	t	7	0	\N
734	Äppeljuice	t	t	9	0	\N
736	Shotglas 	t	t	\N	0	\N
743	Teriyaki	t	t	6	0	\N
737	Fireball	t	t	15	0	\N
738	Turkisk peppar	t	t	15	0	\N
848	Svamp	t	t	13	0	\N
845	Syltlök	t	t	6	0	\N
100	Vispgrädde	t	t	10	0	\N
647	Korvbröd	t	t	2	0	\N
452	Diskborste	t	t	18	0	\N
345	Falukorv	t	t	7	0	\N
559	Vin	t	t	15	0	\N
378	Buljongtärningar	t	t	6	0	\N
535	Frysta jordgubbar	t	t	11	0	\N
175	Polarbröd	t	t	2	0	\N
77	Sprite	t	t	9	0	\N
61	Vetemjöl	t	t	2	0	\N
467	Fanta	t	t	9	0	\N
18	Skinka	t	t	7	0	\N
525	Frukt	t	t	13	0	\N
584	Gnocchi (Pasta)	t	t	3	0	\N
561	Äpple	t	t	13	0	\N
424	Tvättsvamp	t	t	18	0	\N
478	Nötdryck	t	t	10	0	\N
26	Lingonsylt	t	t	6	0	\N
505	Senapssill	t	t	\N	0	\N
60	Tomater	f	f	13	0	\N
962	Solrosfrön	f	f	25	0	
21	Pasta (Penne)	f	f	3	0	
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vicnie
--

COPY public.users (id, username, email, photo, language) FROM stdin;
4	Victor Winberg	victor.m.winberg@gmail.com	https://lh4.googleusercontent.com/-B7EX1IJuLuM/AAAAAAAAAAI/AAAAAAAAAA4/wfq7MaUv4QY/photo.jpg?sz=50	en
1	Victor Winberg	victor95w@gmail.com	https://lh6.googleusercontent.com/-G-72Y03GkJY/AAAAAAAAAAI/AAAAAAAAI7w/svFGQZhrKFw/photo.jpg?sz=50	en
2	Annie Önnered	annie.onnered@gmail.com	https://lh4.googleusercontent.com/-zp37wwjju1U/AAAAAAAAAAI/AAAAAAAAACI/BET3Cc9Cg_s/photo.jpg?sz=50	sv
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicnie
--

SELECT pg_catalog.setval('public.categories_id_seq', 25, true);


--
-- Name: categories_orderidx_seq; Type: SEQUENCE SET; Schema: public; Owner: vicnie
--

SELECT pg_catalog.setval('public.categories_orderidx_seq', 25, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicnie
--

SELECT pg_catalog.setval('public.products_id_seq', 963, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicnie
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: products products_name_key; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_name_key UNIQUE (name);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (email);


--
-- Name: products products_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicnie
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_fkey FOREIGN KEY (category) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

