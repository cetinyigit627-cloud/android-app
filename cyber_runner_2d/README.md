# Cyber Runner 2D - Flutter Flame Oyunu

Bu proje, Flutter ve Flame Engine kullanılarak geliştirilmiş hazır bir 2D oyundur.

## 🚀 APK Nasıl Alınır?

### Yöntem 1: GitHub ile Ücretsiz Buluttan APK İndirme (Tavsiye Edilen)
1. Bu zip dosyasını açıp bir GitHub reposuna yükleyin (Push edin).
2. GitHub'da **Actions** sekmesine gidin.
3. Otomatik olarak `flutter build apk --release` çalışacaktır.
4. İşlem bitince (yaklaşık 2 dk), **Artifacts** bölümünden doğrudan `.apk` dosyanızı telefonunuza indirin!

### Yöntem 2: Kendi Bilgisayarınızda Terminalden
```bash
# Bağımlılıkları yükle
flutter pub get

# APK derle
flutter build apk --release

# Çıktı dosyanız:
# build/app/outputs/flutter-apk/app-release.apk
```
