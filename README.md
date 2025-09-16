1. Projenin Tanımı
Bu proje, Veritabanı Yönetim Sistemleri dersi kapsamında geliştirilmiş bir Kütüphane Yönetim Sistemidir. PostgreSQL veritabanı kullanılmış ve tablolar, ilişkiler, trigger’lar, fonksiyonlar ile prosedürler tasarlanmıştır.

2. Kullanılan Veritabanı Nesneleri
Tablolar:
Kitap, Kategori, Kutuphane1, Uye, UyeIletisim, OduncAlma, Yayinevi, Yazar, Adres, Bolum vb.
Alt tür tablolar: Akademik, GenelKonular, Ogrenci, Personel, AkademikPersonel

Fonksiyonlar & Prosedürler:
kategori_ekle: Yeni kategori ekler.
kitap_sayisi: Belirli sayfa sayısından büyük kitap sayısını döner.
guncelle: Öğrencilerin lisans yılını topluca günceller.
getir: Posta koduna göre adres bilgilerini döner (overload edilmiş: hem integer hem varchar alabiliyor).
uyebilgi: Posta koduna göre üye adı getirir (procedure).

3. Örnek Veri
Kategori tablosunda matematik, fizik, kimya, bilişim, hukuk gibi kategoriler var.
Kitap tablosunda örnek kayıtlar: “kimya1”, “fizik3”, “hukuk1”, “matematik1”.
Kutuphane1 tablosunda farklı raf ve posta kodları kayıtlı.
Bolum tablosunda Bilgisayar Mühendisliği, Hukuk, Hemşirelik bölümleri var.
