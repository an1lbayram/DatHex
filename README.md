# 🧙‍♀️ DatHex v1.3

> **TR:** Windows sistemlerde kurulu tüm uygulamaları `winget` kullanarak güvenli ve sessiz bir şekilde güncelleyen açık kaynak bir batch scripti.  
> **EN:** An open-source batch script to safely and silently upgrade all installed applications on Windows using `winget`.

---

## 🚀 Özellikler / Features

| TR | EN |
|---|---|
| ✅ Tüm uygulamaları tek komutla güncelleme | Upgrade all installed applications with a single command |
| 🔒 Yönetici yetkisi gereksinimi ve kontrolü | Requires administrator privileges and checks for them |
| 🌐 İnternet bağlantısı kontrolü | Verifies active internet connection |
| 🔍 Winget araç kontrolü ve eksikse yönlendirme | Checks if `winget` is installed and guides installation if missing |
| 📋 Güncellenebilir uygulamaları listeleme | Lists applications that have available updates |
| ☁️ Sessiz güncelleme desteği (`--silent`) | Supports silent update mode (`--silent`) |
| 🎨 CLI renklerini değiştirme ve kullanıcı dostu menü | Customizable CLI colors with a clear, user-friendly menu |
| ❌ Belirli uygulamaları hariç tutma seçeneği | Option to exclude specific applications from being updated |

---

## 🛠️ Gereksinimler / Requirements

**TR:**  
- Windows 10 veya 11  
- [Winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/)  
- Yönetici izni 

**EN:**  
- Windows 10 or 11  
- [Winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/)  
- Administrator permission

---

## ⚙️ Kullanım / Usage

**TR:**  

1. Bu depoyu indirin veya `DatHex.bat` dosyasını kopyalayın.  
2. Dosyaya sağ tıklayın → **Yönetici olarak çalıştır**.  
3. Menüden bir seçenek seçin:  
   - `[1]` Tüm uygulamaları güncelle  
   - `[2]` Güncellenebilir uygulamaları listele  
   - `[3]` CLI rengini değiştir  
   - `[4]` Belirli uygulamaları hariç tut  
   - `[5]` Çıkış  

**EN:**  

1. Download this repository or copy the `DatHex.bat` file.  
2. Right-click → **Run as Administrator**.  
3. Choose an option from the menu:  
   - `[1]` Upgrade all installed applications  
   - `[2]` List applications with available updates  
   - `[3]` Change CLI color  
   - `[4]` Exclude specific applications from update  
   - `[5]` Exit  

---

## 📌 Notlar / Notes

**TR:**  
- `winget` aracının sisteminizde kurulu olduğundan emin olun.  
- İnternet bağlantısı olmadan güncelleme yapılamaz.  
- CLI renkleri menü üzerinden değiştirilebilir.  
- Hariç tutulacak uygulamaları seçerek yalnızca gerekli uygulamaları güncelleyebilirsiniz.  

**EN:**  
- Ensure `winget` is installed on your system.  
- Updates require an active internet connection.  
- CLI colors can be customized from the menu.  
- You can exclude specific applications to update only the desired ones.

---

## 📄 Lisans / License

**TR:** Bu proje [MIT Lisansı](./LICENSE) ile lisanslanmıştır.  
**EN:** This project is licensed under the [MIT License](./LICENSE).

---

## ✨ Geliştirici / Developer

**by [an1lbayram](https://github.com/an1lbayram)**

