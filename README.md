# 📚 Kütüphane Yönetim Sistemi  

Bu proje, **Veritabanı Yönetim Sistemleri** dersi kapsamında geliştirilmiştir.  
Amaç; bir kütüphanedeki kitap, yazar, kategori, yayınevi ve kütüphane kayıtlarını ilişkisel veritabanı üzerinde yönetebilmektir.  

## 🔹 Kullanılan Teknolojiler  
- **PostgreSQL** (veritabanı yönetimi)  
- **Npgsql** (C# – PostgreSQL bağlantısı için .NET kütüphanesi)  
- **C# Windows Forms** (basit arayüz geliştirme)  

## 🔹 Özellikler  
- Kitap ekleme, güncelleme, silme, listeleme işlemleri  
- Veri tabanı üzerinden doğrudan CRUD işlemleri  
- Kullanıcı dostu basit bir **Windows Forms arayüzü**  
- İlişkisel veritabanı tasarımı (kitap–yazar–kategori–yayınevi–kütüphane ilişkileri)  

## 🔹 Veritabanı Tasarımı  
Proje kapsamında tablolar arasında **ilişkisel bir veritabanı şeması** oluşturulmuştur.  
ER diyagramı ayrıca görsel olarak repo içerisinde paylaşılmıştır.  

## 🔹 Uygulama Arayüzü  
Windows Forms üzerinden temel işlemler:  
- **Listele** → Tüm kitapları görüntüler  
- **Ekle** → Yeni kitap ekler  
- **Sil** → Kitap kaydını siler  
- **Güncelle** → Kitap bilgilerini günceller  

Sonuçlar `DataGridView` bileşeni kullanılarak tablo halinde gösterilmektedir.  

## 🔹 Kurulum ve Çalıştırma  

1. PostgreSQL üzerinde `Kutuphane` veritabanını oluşturun.  
2. SQL dump dosyasını çalıştırarak tabloları ekleyin.  
3. Projeyi Visual Studio’da açın.  
4. `Npgsql` kütüphanesinin kurulu olduğundan emin olun.  
5. `Form1.cs` içindeki bağlantı bilgilerini (kullanıcı adı, şifre, port) kendi sisteminize göre düzenleyin.  
6. Uygulamayı çalıştırarak CRUD işlemlerini gerçekleştirebilirsiniz.  

---
