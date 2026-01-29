# macOS Örnek Uygulama Oluşturma Adımları

Bu paketi (`userorient-swiftui`) macOS’ta test etmek için aşağıdaki adımları izleyebilirsiniz.

## 1. Yeni macOS Uygulaması Aç

1. **Xcode**’u aç.
2. **File → New → Project…** (⇧⌘N).
3. **macOS** sekmesinden **App** şablonunu seç → **Next**.
4. Örnek ayarlar:
   - **Product Name:** `UserOrientMacOSExample`
   - **Team:** Kendi takımın
   - **Organization Identifier:** `com.example` (veya kendi domain’in)
   - **Interface:** SwiftUI
   - **Language:** Swift
   - **Storage:** None (veya ihtiyaca göre)
5. **Next** → Projeyi **paket klasörünün dışına** kaydet: örn. `userorient/UserOrientSwiftUIExample` (yani `userorient-swiftui` ile **aynı seviyede**). Projeyi paket içinde oluşturursan “Missing package product” hatası alabilirsin.

## 2. Paketi Projeye Ekle

1. Menüden **File → Add Package Dependencies…**
2. Sağ altta **Add Local…** butonuna tıkla.
3. **userorient-swiftui** klasörünü seç (içinde `Package.swift` olan klasör).
4. **Add Package** → Ürün olarak **userorient-swiftui** kütüphanesini seç → **Add Package**.

## 3. Uygulama Kodunu Yaz

App tarafında yapman gerekenler:

- `import userorient_swiftui`
- `@main` struct’ta (ör. `UserOrientMacOSExampleApp`) `init()` içinde:
  - `UserOrient.configure(apiKey: "…", languageCode: "en")`
  - İsteğe bağlı: `UserOrient.setUser(UserOrientUser(...))`
- Ana ekranda `UserOrientBoardView()` göstermek.

Bu repo’daki `UserOrientMacOSExampleApp.swift` dosyası tam örnek kodu içerir; projenin `App` / ana view’ını bu örneğe göre güncelleyebilirsin.

## 4. Çalıştır

1. Scheme’de hedef olarak **My Mac** seçili olsun.
2. **Run** (⌘R) ile uygulamayı çalıştır.
3. Açılan pencerede UserOrient board görünmeli; API key geçerliyse özellikler yüklenir.

## Notlar

- **API key:** Gerçek bir proje için UserOrient’tan aldığın API key’i kullan. Test için placeholder kullanırsan ağ isteği hata verebilir; UI yine de açılır.
- Pakette değişiklik yaptığında Xcode bazen paketi yeniden çözmez; **File → Packages → Reset Package Caches** veya projeyi kapatıp açmayı deneyebilirsin.
