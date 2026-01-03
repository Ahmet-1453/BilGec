# 🧠 BilGeç - Hibrit Genel Kültür Quiz Uygulaması

**BilGeç**, Flutter ile geliştirilmiş; hem yerel veri tabanından (JSON) hazır sorular sunan hem de Yapay Zeka (AI) destekli dinamik içerik üretebilen modern bir bilgi yarışması uygulamasıdır. Temiz mimari prensipleri ve kullanıcı dostu arayüz akışı ile tasarlanmıştır.

---

### 🚀 Özellikler

* **Hibrit Soru Motoru:** İnternet yokken `JSON` tabanlı hazır sorular, internet varken **AI (Gemini)** destekli sınırsız soru üretimi.
* **Dinamik İçerik:** Kullanıcının girdiği herhangi bir konuda (Örn: "Türk Tarihi") anında 10 soruluk özgün test oluşturma.
* **Güvenli Giriş:** Firebase Authentication ile e-posta/şifre tabanlı giriş ve mail doğrulama zorunluluğu.
* **Bulut Kayıt:** Çözülen AI testlerinin ve kazanılan skorların **Firestore** üzerinde kullanıcıya özel saklanması.
* **İnteraktif UI:** `flip_card` animasyonları ile oyunlaştırılmış soru cevaplama deneyimi.
* **Profil Analizi:** Toplam puan ve çözülen test istatistiklerinin takibi.

---

### 🛠 Kullanılan Teknolojiler

* **Framework:** Flutter (Dart)
* **State Management:** Provider
* **Backend:** Firebase (Authentication, Firestore)
* **Yapay Zeka:** Google Gemini API
* **Veri Kaynağı:** Yerel JSON Assets & Cloud Firestore

---

### 📂 Proje ve Klasör Yapısı

Proje, okunabilirliği artırmak için modüler bir yapıda düzenlenmiştir:

* `lib/data/`: Yerel JSON veri okuma işlemleri.
* `lib/models/`: Veri modelleri (`QuestionModel`, `CategoryModel`).
* `lib/services/`: Dış servisler (`AuthService`, `FirestoreService`, `GeminiService`).
* `lib/state/`: Uygulama durumu ve mantığı (`QuizController`).
* `lib/ui/`: Tüm ekranlar ve görsel bileşenler.
* `assets/`: Hazır soru havuzu (`questions.json`).

---

### ⚙️ Kurulum ve Çalıştırma

Projeyi yerel ortamınızda çalıştırmak için terminalde şu komutları uygulayın:

1.  **Bağımlılıkları Yükleyin:**
    ```bash
    flutter pub get
    ```

2.  **Uygulamayı Başlatın:**
    ```bash
    flutter run
    ```

---

### 📸 Ekran Görüntüleri

| Giriş Ekranı | Ana Menü | Quiz Ekranı |
| :---: | :---: | :---: |
| ![Ekran Görüntüsü](screenshots/giris.png) | ![Ekran Görüntüsü](screenshots/ana_menu.png) | ![Ekran Görüntüsü](screenshots/quiz.png) |

---

### ⚠️ Önemli Notlar

Güvenlik prensipleri gereği;
* Firebase yapılandırma dosyası (`google-services.json`),
* Yapay Zeka servisi için kullanılan **API Key** bilgileri repoya **eklenmemiştir.**
* Uygulamanın çalışması için bu dosyaların ilgili dizinlere eklenmesi gerekmektedir.