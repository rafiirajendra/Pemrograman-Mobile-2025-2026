# Praktikum Pemrograman Mobile

**Nama**  : Muhammad Rafi Rajendra  
**NIM**   : 2341720158  
**Kelas** : TI-3H

# Praktikum 1: Konversi Dart model ke JSON

## Soal 1
- Tambahkan nama panggilan Anda pada title app sebagai identitas hasil pekerjaan Anda.
    ```dart
    class MyApp extends StatelessWidget {
        const MyApp({super.key});

        // This widget is the root of your application.
        @override
        Widget build(BuildContext context) {
            return MaterialApp(
            title: 'Flutter JSON Demo Rafi',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: const MyHomePage(),
            );
        }
    }
    ```
- Gantilah warna tema aplikasi sesuai kesukaan Anda.
- Lakukan commit hasil jawaban Soal 1 dengan pesan "W13: Jawaban Soal 1"

## Soal 2
- Masukkan hasil capture layar ke laporan praktikum Anda.
    - Hasil

    ![Soal 2](image/image01.png)
- Lakukan commit hasil jawaban Soal 2 dengan pesan "W13: Jawaban Soal 2"

## Soal 3
- Masukkan hasil capture layar ke laporan praktikum Anda.
    - Hasil

    ![Soal 3](image/image02.png)
- Lakukan commit hasil jawaban Soal 2 dengan pesan "W13: Jawaban Soal 3"

# Praktikum 2: Handle kompatibilitas data JSON
## Soal 4
- Capture hasil running aplikasi Anda, kemudian impor ke laporan praktikum Anda!
    - Hasil Praktikum

    ![Soal 4](image/image03.png)
- Lalu lakukan commit dengan pesan "W13: Jawaban Soal 4".

# Praktikum 3: Menangani error JSON
## Soal 5
- Jelaskan maksud kode lebih safe dan maintainable!
    - Penjelasan dari kode lebih **safe** dan **maintainable**
    ## 1. **SAFE (Lebih Aman)** 🛡️

    ### Tanpa Konstanta (Rawan Error):
    ```dart
    Pizza.fromJson(Map<String, dynamic> json)
        : id = json['id'],
        pizzaName = json['pizzaName'],
        price = json['pirce'];  // ❌ TYPO! 'pirce' bukan 'price'
        
    Map<String, dynamic> toJson() => {
    'id': id,
    'pizzaNme': pizzaName,  // ❌ TYPO! 'pizzaNme' bukan 'pizzaName'
    'price': price,
    };
    ```

    **Masalah:** Compiler **tidak akan mendeteksi** kesalahan pengetikan ini! Aplikasi berjalan, tapi:
    - Data tidak ter-parse dengan benar
    - Nilai jadi `null` atau default
    - Error baru ketahuan saat runtime (aplikasi crash atau data salah)
    - Sulit di-debug karena tidak ada error message yang jelas

    ### Dengan Konstanta (Aman):
    ```dart
    const String keyPrice = 'price';

    Pizza.fromJson(Map<String, dynamic> json)
        : price = json[keyPirce];  // ❌ Compiler ERROR! 'keyPirce' tidak ada
    ```

    **Keuntungan:** Compiler **langsung mendeteksi** error sebelum aplikasi dijalankan!
    - IDE akan memberikan red underline
    - Tidak bisa di-compile sampai diperbaiki
    - Error ketahuan saat development, bukan production

    ---

    ## 2. **MAINTAINABLE (Mudah Dirawat)** 🔧

    ### Skenario: API Backend berubah dari `pizzaName` menjadi `name`

    ### Tanpa Konstanta (Sulit):
    ```dart
    // Harus ubah di BANYAK tempat:
    Pizza.fromJson(Map<String, dynamic> json)
        : pizzaName = json['pizzaName'],  // ❌ Ubah di sini
        
    Map<String, dynamic> toJson() => {
    'pizzaName': pizzaName,  // ❌ Ubah di sini juga
    };

    // Kalau ada di fungsi lain:
    void updatePizza() {
    var name = json['pizzaName'];  // ❌ Dan di sini
    }

    void validate() {
    if (json.containsKey('pizzaName')) {  // ❌ Dan di sini
        // ...
    }
    }
    ```

    **Masalah:**
    - Harus cari dan ganti manual di semua file
    - Rawan terlewat satu tempat → bug!
    - Tidak ada jaminan semua sudah diganti

    ### Dengan Konstanta (Mudah):
    ```dart
    // Cukup ubah di SATU tempat:
    const String keyName = 'name';  // ✅ Ubah hanya di sini!

    // Semua yang pakai konstanta ini otomatis berubah:
    Pizza.fromJson(Map<String, dynamic> json)
        : pizzaName = json[keyName],  // ✅ Otomatis pakai 'name'
        
    Map<String, dynamic> toJson() => {
    keyName: pizzaName,  // ✅ Otomatis pakai 'name'
    };
    ```

    **Keuntungan:**
    - **Single Source of Truth**: Satu tempat untuk satu nilai
    - Refactoring cepat dan aman
    - IDE bisa "Find All References" untuk tracking penggunaan

    ---

    ## 3. **Contoh Real World** 🌍

    Bayangkan Anda punya 10 file yang menggunakan kunci JSON yang sama:

    ```
    lib/
    ├── model/pizza.dart
    ├── services/pizza_service.dart
    ├── controllers/pizza_controller.dart
    ├── utils/pizza_validator.dart
    ├── widgets/pizza_card.dart
    └── ... 10 file lainnya
    ```

    **Tanpa Konstanta:**
    - Harus buka 10 file
    - Cari manual setiap 'pizzaName'
    - Ganti satu per satu
    - Risiko terlewat: **TINGGI** ⚠️

    **Dengan Konstanta:**
    - Ubah 1 konstanta
    - Semua file otomatis konsisten
    - Risiko terlewat: **NOL** ✅

    ---

    ## 4. **Autocomplete & IntelliSense** 💡

    Ketika mengetik:
    ```dart
    json[key...]  // IDE akan suggest: keyId, keyName, keyDescription, dll
    ```

    Tanpa konstanta, Anda harus ingat sendiri string yang benar.

    ---

    ## Kesimpulan:

    | Aspek | Tanpa Konstanta | Dengan Konstanta |
    |-------|----------------|------------------|
    | **Deteksi Typo** | Runtime (terlambat) | Compile-time (cepat) |
    | **Perubahan API** | Manual di banyak tempat | Satu tempat saja |
    | **Risiko Bug** | Tinggi | Rendah |
    | **Development Time** | Lama (debugging) | Cepat (error langsung) |
    | **Code Review** | Sulit spot typo | Mudah & konsisten |

    **SAFE** = Compiler melindungi Anda dari kesalahan manusia
    **MAINTAINABLE** = Perubahan mudah, cepat, dan aman
- Capture hasil praktikum Anda dan lampirkan di README.
    - Hasil

    ![Soal 5](image/image03.png)
- Lalu lakukan commit dengan pesan "W13: Jawaban Soal 5".

# Praktikum 4: SharedPreferences
## Soal 6
- Capture hasil praktikum Anda berupa GIF dan lampirkan di README.
    - Hasil Praktikum 4:

    ![Praktikum 4](image/image04.png)

    ![Soal 6](scrcpy_4fPbpkmAac.gif)
- Lalu lakukan commit dengan pesan "W13: Jawaban Soal 6".