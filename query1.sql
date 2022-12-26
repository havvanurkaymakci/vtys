--
-- PostgreSQL database dump
--

-- Dumped from database version 13.9
-- Dumped by pg_dump version 13.9

-- Started on 2022-12-26 20:28:35

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
-- TOC entry 244 (class 1255 OID 17775)
-- Name: fonk1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fonk1() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE

BEGIN
update "Kategori" set "kitapSayisi"= "kitapSayisi" +1;
return new;
END;
$$;


ALTER FUNCTION public.fonk1() OWNER TO postgres;

--
-- TOC entry 245 (class 1255 OID 17838)
-- Name: fonk2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fonk2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
         INSERT INTO "UyeIletisim" ("uye_Id")
         VALUES(New.UyeId);
 
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.fonk2() OWNER TO postgres;

--
-- TOC entry 246 (class 1255 OID 17841)
-- Name: fonk3(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fonk3() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE posta_kodu varchar;
    BEGIN
        posta_kodu= OLD."postaKodu";
        DELETE FROM "Uye" WHERE "uyePostaKodu" = posta_kodu;
    
        RETURN NULL;
    END;
$$;


ALTER FUNCTION public.fonk3() OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 17861)
-- Name: fonk4(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fonk4() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE

BEGIN
update "Kutuphane1" set "rafSayisi"= "rafSayisi" +1;
return new;
END;
$$;


ALTER FUNCTION public.fonk4() OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 17869)
-- Name: getir(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getir(posta_kodu integer) RETURNS TABLE("postaKodu1" integer, il1 integer, ilce1 integer)
    LANGUAGE plpgsql
    AS $$ 

BEGIN
return query
select name, "ilce" from "Adres" where "postaKodu" = posta_kodu;
END;
$$;


ALTER FUNCTION public.getir(posta_kodu integer) OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 17868)
-- Name: getir(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getir(posta_kodu character varying) RETURNS TABLE("postaKodu1" character varying, il1 character varying, ilce1 character varying)
    LANGUAGE plpgsql
    AS $$ 

BEGIN
return query
select name, "ilce" from "Adres" where "postaKodu" = posta_kodu;
END;
$$;


ALTER FUNCTION public.getir(posta_kodu character varying) OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 17690)
-- Name: guncelle(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.guncelle(mevcut_yil integer, yeni_yil integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
DECLARE

BEGIN
UPDATE "Ogrenci" SET "lisansYili" = yeni_yil WHERE "lisansYili"=mevcut_yil;
return yeni_yil;
END;
$$;


ALTER FUNCTION public.guncelle(mevcut_yil integer, yeni_yil integer) OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 17571)
-- Name: kategori_ekle(integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kategori_ekle(kategori_id integer, kategori_adi character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$ 
BEGIN
INSERT INTO "Kategori"("kategoriId","kategoriAdi")
VALUES(kategori_Id, kategori_Adi);
END;
$$;


ALTER FUNCTION public.kategori_ekle(kategori_id integer, kategori_adi character varying) OWNER TO postgres;

--
-- TOC entry 226 (class 1255 OID 17554)
-- Name: kitap_sayisi(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kitap_sayisi(sayfa_sayisi integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
DECLARE
kitapSayisi integer;
BEGIN
SELECT COUNT(*) INTO kitapSayisi FROM "Kitap" WHERE "sayfaSayisi" >sayfa_sayisi;
RETURN kitapSayisi;

END;
$$;


ALTER FUNCTION public.kitap_sayisi(sayfa_sayisi integer) OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 17744)
-- Name: uyebilgi(character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.uyebilgi(posta_kodu character varying)
    LANGUAGE plpgsql
    AS $$
begin
select "uyeAdiSoyadi" from "Uye" where "uyePostaKodu"= posta_kodu;
end;
$$;


ALTER PROCEDURE public.uyebilgi(posta_kodu character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 207 (class 1259 OID 17315)
-- Name: Adres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Adres" (
    "postaKodu" character varying(5) NOT NULL,
    il character varying,
    ilce character varying
);


ALTER TABLE public."Adres" OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 17306)
-- Name: Kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kategori" (
    "kategoriId" integer NOT NULL,
    "kategoriAdi" character varying(50),
    "kitapSayisi" integer
);


ALTER TABLE public."Kategori" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 17331)
-- Name: Akademik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Akademik" (
)
INHERITS (public."Kategori");


ALTER TABLE public."Akademik" OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 17257)
-- Name: Uye; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Uye" (
    "uyeId" character varying(5) NOT NULL,
    "uyeAdiSoyadi" character varying(60),
    "uyePostaKodu" character(5),
    "uyeTipi" character varying(30),
    "bolumNo" integer NOT NULL
);


ALTER TABLE public."Uye" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 17297)
-- Name: AkademikPersonel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AkademikPersonel" (
)
INHERITS (public."Uye");


ALTER TABLE public."AkademikPersonel" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17369)
-- Name: Bolum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Bolum" (
    "bolumNo" integer NOT NULL,
    "fakulteNo" character(3),
    "bolumAdi" character varying(80)
);


ALTER TABLE public."Bolum" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17367)
-- Name: Bolum_bolumNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Bolum_bolumNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Bolum_bolumNo_seq" OWNER TO postgres;

--
-- TOC entry 3174 (class 0 OID 0)
-- Dependencies: 215
-- Name: Bolum_bolumNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Bolum_bolumNo_seq" OWNED BY public."Bolum"."bolumNo";


--
-- TOC entry 211 (class 1259 OID 17338)
-- Name: GenelKonular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GenelKonular" (
)
INHERITS (public."Kategori");


ALTER TABLE public."GenelKonular" OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 17304)
-- Name: Kategori_kategoriId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kategori_kategoriId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kategori_kategoriId_seq" OWNER TO postgres;

--
-- TOC entry 3175 (class 0 OID 0)
-- Dependencies: 205
-- Name: Kategori_kategoriId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kategori_kategoriId_seq" OWNED BY public."Kategori"."kategoriId";


--
-- TOC entry 220 (class 1259 OID 17381)
-- Name: Kitap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kitap" (
    "kitapId" character(5) NOT NULL,
    "kitapAdi" character varying(70) NOT NULL,
    "yayineviId" character(3),
    "kutuphaneId" integer NOT NULL,
    "kategoriId" integer NOT NULL,
    "rafNo" character(3),
    "yazarId" integer NOT NULL,
    "sayfaSayisi" integer
);


ALTER TABLE public."Kitap" OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 17325)
-- Name: KitapKonum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KitapKonum" (
    "rafNo" character(3) NOT NULL,
    "kategoriId" integer NOT NULL
);


ALTER TABLE public."KitapKonum" OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 17323)
-- Name: KitapKonum_kategoriId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."KitapKonum_kategoriId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."KitapKonum_kategoriId_seq" OWNER TO postgres;

--
-- TOC entry 3176 (class 0 OID 0)
-- Dependencies: 208
-- Name: KitapKonum_kategoriId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."KitapKonum_kategoriId_seq" OWNED BY public."KitapKonum"."kategoriId";


--
-- TOC entry 218 (class 1259 OID 17377)
-- Name: Kitap_kategoriId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kitap_kategoriId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kitap_kategoriId_seq" OWNER TO postgres;

--
-- TOC entry 3177 (class 0 OID 0)
-- Dependencies: 218
-- Name: Kitap_kategoriId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kitap_kategoriId_seq" OWNED BY public."Kitap"."kategoriId";


--
-- TOC entry 217 (class 1259 OID 17375)
-- Name: Kitap_kutuphaneId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kitap_kutuphaneId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kitap_kutuphaneId_seq" OWNER TO postgres;

--
-- TOC entry 3178 (class 0 OID 0)
-- Dependencies: 217
-- Name: Kitap_kutuphaneId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kitap_kutuphaneId_seq" OWNED BY public."Kitap"."kutuphaneId";


--
-- TOC entry 219 (class 1259 OID 17379)
-- Name: Kitap_yazarId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kitap_yazarId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kitap_yazarId_seq" OWNER TO postgres;

--
-- TOC entry 3179 (class 0 OID 0)
-- Dependencies: 219
-- Name: Kitap_yazarId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kitap_yazarId_seq" OWNED BY public."Kitap"."yazarId";


--
-- TOC entry 214 (class 1259 OID 17353)
-- Name: Kutuphane1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kutuphane1" (
    "kutuphaneId" integer NOT NULL,
    "rafNo" character(3),
    "postaKodu" character(5),
    "rafSayisi" integer
);


ALTER TABLE public."Kutuphane1" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17399)
-- Name: OduncAlma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OduncAlma" (
    "kitapId" character(5),
    "uyeId" character(5),
    "alisTarihi" date,
    "teslimTarihi" date,
    "islemId" integer NOT NULL
);


ALTER TABLE public."OduncAlma" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17397)
-- Name: OduncAlma_islemId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."OduncAlma_islemId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."OduncAlma_islemId_seq" OWNER TO postgres;

--
-- TOC entry 3180 (class 0 OID 0)
-- Dependencies: 223
-- Name: OduncAlma_islemId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OduncAlma_islemId_seq" OWNED BY public."OduncAlma"."islemId";


--
-- TOC entry 201 (class 1259 OID 17266)
-- Name: Ogrenci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ogrenci" (
    "lisansYili" integer
)
INHERITS (public."Uye");


ALTER TABLE public."Ogrenci" OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 17290)
-- Name: Personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Personel" (
)
INHERITS (public."Uye");


ALTER TABLE public."Personel" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17843)
-- Name: UyeIletisim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UyeIletisim" (
    "uye_Id" character varying(5) NOT NULL,
    "uyeMail" character varying(40),
    "uyeTelefon" character varying(15)
);


ALTER TABLE public."UyeIletisim" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 17273)
-- Name: Uye_bolumNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Uye_bolumNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Uye_bolumNo_seq" OWNER TO postgres;

--
-- TOC entry 3181 (class 0 OID 0)
-- Dependencies: 202
-- Name: Uye_bolumNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Uye_bolumNo_seq" OWNED BY public."Uye"."bolumNo";


--
-- TOC entry 212 (class 1259 OID 17346)
-- Name: Yayinevi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yayinevi" (
    "yayineviId" character(3) NOT NULL,
    "yayineviAdi" character varying(50),
    "postaKodu" character(5)
);


ALTER TABLE public."Yayinevi" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17391)
-- Name: Yazar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yazar" (
    "yazarId" integer NOT NULL,
    "yazarAdSoyad" character varying(60)
);


ALTER TABLE public."Yazar" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17389)
-- Name: Yazar_yazarId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Yazar_yazarId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Yazar_yazarId_seq" OWNER TO postgres;

--
-- TOC entry 3182 (class 0 OID 0)
-- Dependencies: 221
-- Name: Yazar_yazarId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Yazar_yazarId_seq" OWNED BY public."Yazar"."yazarId";


--
-- TOC entry 213 (class 1259 OID 17351)
-- Name: kutuphane_kutuphaneId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."kutuphane_kutuphaneId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."kutuphane_kutuphaneId_seq" OWNER TO postgres;

--
-- TOC entry 3183 (class 0 OID 0)
-- Dependencies: 213
-- Name: kutuphane_kutuphaneId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."kutuphane_kutuphaneId_seq" OWNED BY public."Kutuphane1"."kutuphaneId";


--
-- TOC entry 2945 (class 2604 OID 17334)
-- Name: Akademik kategoriId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Akademik" ALTER COLUMN "kategoriId" SET DEFAULT nextval('public."Kategori_kategoriId_seq"'::regclass);


--
-- TOC entry 2942 (class 2604 OID 17300)
-- Name: AkademikPersonel bolumNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AkademikPersonel" ALTER COLUMN "bolumNo" SET DEFAULT nextval('public."Uye_bolumNo_seq"'::regclass);


--
-- TOC entry 2948 (class 2604 OID 17372)
-- Name: Bolum bolumNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bolum" ALTER COLUMN "bolumNo" SET DEFAULT nextval('public."Bolum_bolumNo_seq"'::regclass);


--
-- TOC entry 2946 (class 2604 OID 17341)
-- Name: GenelKonular kategoriId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GenelKonular" ALTER COLUMN "kategoriId" SET DEFAULT nextval('public."Kategori_kategoriId_seq"'::regclass);


--
-- TOC entry 2943 (class 2604 OID 17309)
-- Name: Kategori kategoriId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kategori" ALTER COLUMN "kategoriId" SET DEFAULT nextval('public."Kategori_kategoriId_seq"'::regclass);


--
-- TOC entry 2949 (class 2604 OID 17384)
-- Name: Kitap kutuphaneId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap" ALTER COLUMN "kutuphaneId" SET DEFAULT nextval('public."Kitap_kutuphaneId_seq"'::regclass);


--
-- TOC entry 2950 (class 2604 OID 17385)
-- Name: Kitap kategoriId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap" ALTER COLUMN "kategoriId" SET DEFAULT nextval('public."Kitap_kategoriId_seq"'::regclass);


--
-- TOC entry 2951 (class 2604 OID 17386)
-- Name: Kitap yazarId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap" ALTER COLUMN "yazarId" SET DEFAULT nextval('public."Kitap_yazarId_seq"'::regclass);


--
-- TOC entry 2944 (class 2604 OID 17328)
-- Name: KitapKonum kategoriId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapKonum" ALTER COLUMN "kategoriId" SET DEFAULT nextval('public."KitapKonum_kategoriId_seq"'::regclass);


--
-- TOC entry 2947 (class 2604 OID 17356)
-- Name: Kutuphane1 kutuphaneId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kutuphane1" ALTER COLUMN "kutuphaneId" SET DEFAULT nextval('public."kutuphane_kutuphaneId_seq"'::regclass);


--
-- TOC entry 2953 (class 2604 OID 17402)
-- Name: OduncAlma islemId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OduncAlma" ALTER COLUMN "islemId" SET DEFAULT nextval('public."OduncAlma_islemId_seq"'::regclass);


--
-- TOC entry 2940 (class 2604 OID 17276)
-- Name: Ogrenci bolumNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenci" ALTER COLUMN "bolumNo" SET DEFAULT nextval('public."Uye_bolumNo_seq"'::regclass);


--
-- TOC entry 2941 (class 2604 OID 17293)
-- Name: Personel bolumNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel" ALTER COLUMN "bolumNo" SET DEFAULT nextval('public."Uye_bolumNo_seq"'::regclass);


--
-- TOC entry 2939 (class 2604 OID 17275)
-- Name: Uye bolumNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye" ALTER COLUMN "bolumNo" SET DEFAULT nextval('public."Uye_bolumNo_seq"'::regclass);


--
-- TOC entry 2952 (class 2604 OID 17394)
-- Name: Yazar yazarId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yazar" ALTER COLUMN "yazarId" SET DEFAULT nextval('public."Yazar_yazarId_seq"'::regclass);


--
-- TOC entry 3150 (class 0 OID 17315)
-- Dependencies: 207
-- Data for Name: Adres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Adres" ("postaKodu", il, ilce) FROM stdin;
00002	Istanbul	Uskudar
\.


--
-- TOC entry 3153 (class 0 OID 17331)
-- Dependencies: 210
-- Data for Name: Akademik; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Akademik" ("kategoriId", "kategoriAdi", "kitapSayisi") FROM stdin;
\.


--
-- TOC entry 3147 (class 0 OID 17297)
-- Dependencies: 204
-- Data for Name: AkademikPersonel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AkademikPersonel" ("uyeId", "uyeAdiSoyadi", "uyePostaKodu", "uyeTipi", "bolumNo") FROM stdin;
E0003	Elif aydin	00002	ogrenci	3
E0004	Mustafa Ozer	00002	ogrenci	1
E0005	Fatih Altay	00002	AkademikPersonel	1
G0005	Melih Gursoy	00002	ogrenci	1
G0006	Ayse Gunes	00002	ogrenci	1
\.


--
-- TOC entry 3159 (class 0 OID 17369)
-- Dependencies: 216
-- Data for Name: Bolum; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Bolum" ("bolumNo", "fakulteNo", "bolumAdi") FROM stdin;
1	023	Bilgisayar Muhendisligi
2	014	Hukuk
3	009	hemsirelik
\.


--
-- TOC entry 3154 (class 0 OID 17338)
-- Dependencies: 211
-- Data for Name: GenelKonular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."GenelKonular" ("kategoriId", "kategoriAdi", "kitapSayisi") FROM stdin;
\.


--
-- TOC entry 3149 (class 0 OID 17306)
-- Dependencies: 206
-- Data for Name: Kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Kategori" ("kategoriId", "kategoriAdi", "kitapSayisi") FROM stdin;
5	hukuk	\N
6	edebiyat	\N
7	ekonomi	\N
1	matematik	6
2	fizik	16
3	kimya	8
4	bilisim	11
18	edebiyat	\N
15	sosyoluci	\N
\.


--
-- TOC entry 3163 (class 0 OID 17381)
-- Dependencies: 220
-- Data for Name: Kitap; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Kitap" ("kitapId", "kitapAdi", "yayineviId", "kutuphaneId", "kategoriId", "rafNo", "yazarId", "sayfaSayisi") FROM stdin;
A0001	kimya1	y01	1	1	r01	2	340
A0003	fizik3	y01	1	1	r01	2	250
A0009	matematik1	y01	1	1	r01	2	345
A0010	hukuk1	y01	1	4	r01	2	456
A0007	matematk2	y01	1	2	r01	1	180
A0008	hukuk2	y01	1	4	r01	1	300
A0011	matematik3	y01	1	1	r03	2	356
A0004	fizik1	y01	1	1	r01	1	150
\.


--
-- TOC entry 3152 (class 0 OID 17325)
-- Dependencies: 209
-- Data for Name: KitapKonum; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."KitapKonum" ("rafNo", "kategoriId") FROM stdin;
r01	1
r02	2
r03	3
r04	4
r06	6
r07	7
r08	8
\.


--
-- TOC entry 3157 (class 0 OID 17353)
-- Dependencies: 214
-- Data for Name: Kutuphane1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Kutuphane1" ("kutuphaneId", "rafNo", "postaKodu", "rafSayisi") FROM stdin;
1	r01	00002	5
2	r02	00003	4
\.


--
-- TOC entry 3167 (class 0 OID 17399)
-- Dependencies: 224
-- Data for Name: OduncAlma; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OduncAlma" ("kitapId", "uyeId", "alisTarihi", "teslimTarihi", "islemId") FROM stdin;
\.


--
-- TOC entry 3144 (class 0 OID 17266)
-- Dependencies: 201
-- Data for Name: Ogrenci; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Ogrenci" ("uyeId", "uyeAdiSoyadi", "uyePostaKodu", "uyeTipi", "bolumNo", "lisansYili") FROM stdin;
G0009	\N	\N	\N	2	\N
\.


--
-- TOC entry 3146 (class 0 OID 17290)
-- Dependencies: 203
-- Data for Name: Personel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Personel" ("uyeId", "uyeAdiSoyadi", "uyePostaKodu", "uyeTipi", "bolumNo") FROM stdin;
\.


--
-- TOC entry 3143 (class 0 OID 17257)
-- Dependencies: 200
-- Data for Name: Uye; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Uye" ("uyeId", "uyeAdiSoyadi", "uyePostaKodu", "uyeTipi", "bolumNo") FROM stdin;
\.


--
-- TOC entry 3168 (class 0 OID 17843)
-- Dependencies: 225
-- Data for Name: UyeIletisim; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UyeIletisim" ("uye_Id", "uyeMail", "uyeTelefon") FROM stdin;
G0009	\N	\N
\.


--
-- TOC entry 3155 (class 0 OID 17346)
-- Dependencies: 212
-- Data for Name: Yayinevi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Yayinevi" ("yayineviId", "yayineviAdi", "postaKodu") FROM stdin;
y01	a	00001
y02	b	00002
y03	c	00003
\.


--
-- TOC entry 3165 (class 0 OID 17391)
-- Dependencies: 222
-- Data for Name: Yazar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Yazar" ("yazarId", "yazarAdSoyad") FROM stdin;
1	xyz1
2	xyz2
\.


--
-- TOC entry 3184 (class 0 OID 0)
-- Dependencies: 215
-- Name: Bolum_bolumNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Bolum_bolumNo_seq"', 1, false);


--
-- TOC entry 3185 (class 0 OID 0)
-- Dependencies: 205
-- Name: Kategori_kategoriId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kategori_kategoriId_seq"', 1, false);


--
-- TOC entry 3186 (class 0 OID 0)
-- Dependencies: 208
-- Name: KitapKonum_kategoriId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."KitapKonum_kategoriId_seq"', 1, false);


--
-- TOC entry 3187 (class 0 OID 0)
-- Dependencies: 218
-- Name: Kitap_kategoriId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kitap_kategoriId_seq"', 1, false);


--
-- TOC entry 3188 (class 0 OID 0)
-- Dependencies: 217
-- Name: Kitap_kutuphaneId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kitap_kutuphaneId_seq"', 3, true);


--
-- TOC entry 3189 (class 0 OID 0)
-- Dependencies: 219
-- Name: Kitap_yazarId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kitap_yazarId_seq"', 1, false);


--
-- TOC entry 3190 (class 0 OID 0)
-- Dependencies: 223
-- Name: OduncAlma_islemId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OduncAlma_islemId_seq"', 6, true);


--
-- TOC entry 3191 (class 0 OID 0)
-- Dependencies: 202
-- Name: Uye_bolumNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Uye_bolumNo_seq"', 4, true);


--
-- TOC entry 3192 (class 0 OID 0)
-- Dependencies: 221
-- Name: Yazar_yazarId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Yazar_yazarId_seq"', 1, false);


--
-- TOC entry 3193 (class 0 OID 0)
-- Dependencies: 213
-- Name: kutuphane_kutuphaneId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."kutuphane_kutuphaneId_seq"', 1, false);


--
-- TOC entry 2969 (class 2606 OID 17724)
-- Name: Adres Adres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Adres"
    ADD CONSTRAINT "Adres_pkey" PRIMARY KEY ("postaKodu");


--
-- TOC entry 2964 (class 2606 OID 17786)
-- Name: AkademikPersonel AkademikPersonel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AkademikPersonel"
    ADD CONSTRAINT "AkademikPersonel_pkey" PRIMARY KEY ("uyeId");


--
-- TOC entry 2978 (class 2606 OID 17374)
-- Name: Bolum Bolum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bolum"
    ADD CONSTRAINT "Bolum_pkey" PRIMARY KEY ("bolumNo");


--
-- TOC entry 2967 (class 2606 OID 17314)
-- Name: Kategori Kategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kategori"
    ADD CONSTRAINT "Kategori_pkey" PRIMARY KEY ("kategoriId");


--
-- TOC entry 2971 (class 2606 OID 17330)
-- Name: KitapKonum KitapKonum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapKonum"
    ADD CONSTRAINT "KitapKonum_pkey" PRIMARY KEY ("rafNo");


--
-- TOC entry 2980 (class 2606 OID 17388)
-- Name: Kitap Kitap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap"
    ADD CONSTRAINT "Kitap_pkey" PRIMARY KEY ("kitapId");


--
-- TOC entry 2988 (class 2606 OID 17404)
-- Name: OduncAlma OduncAlma_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OduncAlma"
    ADD CONSTRAINT "OduncAlma_pkey" PRIMARY KEY ("islemId");


--
-- TOC entry 2959 (class 2606 OID 17788)
-- Name: Ogrenci Ogrenci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenci"
    ADD CONSTRAINT "Ogrenci_pkey" PRIMARY KEY ("uyeId");


--
-- TOC entry 2961 (class 2606 OID 17750)
-- Name: Personel Personel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "Personel_pkey" PRIMARY KEY ("uyeId");


--
-- TOC entry 2955 (class 2606 OID 17748)
-- Name: Uye Uye_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye"
    ADD CONSTRAINT "Uye_pkey" PRIMARY KEY ("uyeId");


--
-- TOC entry 2974 (class 2606 OID 17350)
-- Name: Yayinevi Yayinevi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yayinevi"
    ADD CONSTRAINT "Yayinevi_pkey" PRIMARY KEY ("yayineviId");


--
-- TOC entry 2986 (class 2606 OID 17396)
-- Name: Yazar Yazar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yazar"
    ADD CONSTRAINT "Yazar_pkey" PRIMARY KEY ("yazarId");


--
-- TOC entry 2976 (class 2606 OID 17358)
-- Name: Kutuphane1 kutuphane_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kutuphane1"
    ADD CONSTRAINT kutuphane_pkey PRIMARY KEY ("kutuphaneId");


--
-- TOC entry 2965 (class 1259 OID 17751)
-- Name: fki_UyeId_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_UyeId_fkey" ON public."AkademikPersonel" USING btree ("uyeId");


--
-- TOC entry 2956 (class 1259 OID 17488)
-- Name: fki_bolumno_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_bolumno_fkey ON public."Uye" USING btree ("bolumNo");


--
-- TOC entry 2972 (class 1259 OID 17410)
-- Name: fki_kategoriId_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_kategoriId_fkey" ON public."Akademik" USING btree ("kategoriId");


--
-- TOC entry 2989 (class 1259 OID 17461)
-- Name: fki_kitapId_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_kitapId_fkey" ON public."OduncAlma" USING btree ("kitapId");


--
-- TOC entry 2981 (class 1259 OID 17450)
-- Name: fki_kutuphaneId_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_kutuphaneId_fkey" ON public."Kitap" USING btree ("kutuphaneId");


--
-- TOC entry 2990 (class 1259 OID 17782)
-- Name: fki_ogrenciId_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_ogrenciId_fkey" ON public."OduncAlma" USING btree ("uyeId");


--
-- TOC entry 2957 (class 1259 OID 17635)
-- Name: fki_postaKodu_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_postaKodu_fkey" ON public."Uye" USING btree ("uyePostaKodu");


--
-- TOC entry 2962 (class 1259 OID 17829)
-- Name: fki_r; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_r ON public."Personel" USING btree ("uyePostaKodu");


--
-- TOC entry 2982 (class 1259 OID 17444)
-- Name: fki_rafNo_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_rafNo_fkey" ON public."Kitap" USING btree ("rafNo");


--
-- TOC entry 2983 (class 1259 OID 17535)
-- Name: fki_yayineviId_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_yayineviId_fkey" ON public."Kitap" USING btree ("yayineviId");


--
-- TOC entry 2984 (class 1259 OID 17438)
-- Name: fki_yazarId_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_yazarId_fkey" ON public."Kitap" USING btree ("yazarId");


--
-- TOC entry 3007 (class 2620 OID 17859)
-- Name: Uye testtrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER testtrig AFTER INSERT ON public."Uye" FOR EACH ROW EXECUTE FUNCTION public.fonk2();


--
-- TOC entry 3012 (class 2620 OID 17776)
-- Name: Kitap trig1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trig1 AFTER INSERT ON public."Kitap" FOR EACH ROW EXECUTE FUNCTION public.fonk1();


--
-- TOC entry 3010 (class 2620 OID 17860)
-- Name: Adres trig3; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trig3 AFTER DELETE ON public."Adres" FOR EACH ROW EXECUTE FUNCTION public.fonk3();


--
-- TOC entry 3009 (class 2620 OID 17855)
-- Name: Ogrenci trig3; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trig3 AFTER INSERT ON public."Ogrenci" FOR EACH ROW EXECUTE FUNCTION public.fonk3();


--
-- TOC entry 3008 (class 2620 OID 17851)
-- Name: Uye trig3; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trig3 AFTER INSERT ON public."Uye" FOR EACH ROW EXECUTE FUNCTION public.fonk3();


--
-- TOC entry 3011 (class 2620 OID 17865)
-- Name: KitapKonum trig4; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trig4 AFTER INSERT ON public."KitapKonum" FOR EACH ROW EXECUTE FUNCTION public.fonk4();


--
-- TOC entry 3005 (class 2606 OID 17752)
-- Name: OduncAlma UyeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OduncAlma"
    ADD CONSTRAINT "UyeId_fkey" FOREIGN KEY ("uyeId") REFERENCES public."Uye"("uyeId") ON DELETE CASCADE NOT VALID;


--
-- TOC entry 2991 (class 2606 OID 17483)
-- Name: Uye bolumno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye"
    ADD CONSTRAINT bolumno_fkey FOREIGN KEY ("bolumNo") REFERENCES public."Bolum"("bolumNo") NOT VALID;


--
-- TOC entry 2993 (class 2606 OID 17794)
-- Name: Ogrenci bolumno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenci"
    ADD CONSTRAINT bolumno_fkey FOREIGN KEY ("bolumNo") REFERENCES public."Bolum"("bolumNo") NOT VALID;


--
-- TOC entry 2996 (class 2606 OID 17814)
-- Name: AkademikPersonel bolumno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AkademikPersonel"
    ADD CONSTRAINT bolumno_fkey FOREIGN KEY ("bolumNo") REFERENCES public."Bolum"("bolumNo") NOT VALID;


--
-- TOC entry 2995 (class 2606 OID 17830)
-- Name: Personel bolumno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT bolumno_fkey FOREIGN KEY ("bolumNo") REFERENCES public."Bolum"("bolumNo") NOT VALID;


--
-- TOC entry 2997 (class 2606 OID 17405)
-- Name: Akademik kategoriId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Akademik"
    ADD CONSTRAINT "kategoriId_fkey" FOREIGN KEY ("kategoriId") REFERENCES public."Kategori"("kategoriId") NOT VALID;


--
-- TOC entry 2998 (class 2606 OID 17417)
-- Name: GenelKonular kategoriId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GenelKonular"
    ADD CONSTRAINT "kategoriId_fkey" FOREIGN KEY ("kategoriId") REFERENCES public."Kategori"("kategoriId") NOT VALID;


--
-- TOC entry 3002 (class 2606 OID 17536)
-- Name: Kitap kategoriId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap"
    ADD CONSTRAINT "kategoriId_fkey" FOREIGN KEY ("yayineviId") REFERENCES public."Yayinevi"("yayineviId") NOT VALID;


--
-- TOC entry 3004 (class 2606 OID 17456)
-- Name: OduncAlma kitapId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OduncAlma"
    ADD CONSTRAINT "kitapId_fkey" FOREIGN KEY ("kitapId") REFERENCES public."Kitap"("kitapId") NOT VALID;


--
-- TOC entry 3001 (class 2606 OID 17445)
-- Name: Kitap kutuphaneId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap"
    ADD CONSTRAINT "kutuphaneId_fkey" FOREIGN KEY ("kutuphaneId") REFERENCES public."Kutuphane1"("kutuphaneId") NOT VALID;


--
-- TOC entry 3006 (class 2606 OID 17777)
-- Name: OduncAlma ogrenciId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OduncAlma"
    ADD CONSTRAINT "ogrenciId_fkey" FOREIGN KEY ("uyeId") REFERENCES public."Uye"("uyeId") NOT VALID;


--
-- TOC entry 2992 (class 2606 OID 17730)
-- Name: Uye postaKodu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye"
    ADD CONSTRAINT "postaKodu_fkey" FOREIGN KEY ("uyePostaKodu") REFERENCES public."Adres"("postaKodu") NOT VALID;


--
-- TOC entry 2994 (class 2606 OID 17824)
-- Name: Personel postaKodu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "postaKodu_fkey" FOREIGN KEY ("uyePostaKodu") REFERENCES public."Adres"("postaKodu") NOT VALID;


--
-- TOC entry 3000 (class 2606 OID 17439)
-- Name: Kitap rafNo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap"
    ADD CONSTRAINT "rafNo_fkey" FOREIGN KEY ("rafNo") REFERENCES public."KitapKonum"("rafNo") NOT VALID;


--
-- TOC entry 3003 (class 2606 OID 17541)
-- Name: Kitap yayineviId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap"
    ADD CONSTRAINT "yayineviId_fkey" FOREIGN KEY ("yayineviId") REFERENCES public."Yayinevi"("yayineviId") NOT VALID;


--
-- TOC entry 2999 (class 2606 OID 17433)
-- Name: Kitap yazarId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap"
    ADD CONSTRAINT "yazarId_fkey" FOREIGN KEY ("yazarId") REFERENCES public."Yazar"("yazarId") NOT VALID;


-- Completed on 2022-12-26 20:28:36

--
-- PostgreSQL database dump complete
--

