# Praktikum Pemrograman Mobile

**Nama**  : Muhammad Rafi Rajendra  
**NIM**   : 2341720158  
**Kelas** : TI-3H

## Praktikum 1: Mengunduh Data dari Web Service (API)

### Soal 1: Tambahkan nama panggilan Anda pada title app sebagai identitas hasil pekerjaan Anda.

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muhammad Rafi Rajendra',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String result = '';

  Future<Response> getData() async {
    const authority = 'www.googleapis.com';
    const path = '/books/v1/volumes/1PYr5wxdG9kC';
    Uri url = Uri.https(authority, path);
    return http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back from the Future'),
      ),
      body: Center(
        child: Column(children: [
            const Spacer(),
            ElevatedButton(
              child: const Text('GO'),
              onPressed: (){},
            ),
            const Spacer(),
            Text(result),
            const Spacer(),
            const CircularProgressIndicator(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
```

### Soal 2: 
- Carilah judul buku favorit Anda di Google Books, lalu ganti ID buku pada variabel path di kode tersebut. Caranya ambil di URL browser Anda seperti gambar berikut ini.

- Kemudian cobalah akses di browser URI tersebut dengan lengkap seperti ini. Jika menampilkan data JSON, maka Anda telah berhasil. Lakukan capture milik Anda dan tulis di README pada laporan praktikum. Lalu lakukan commit dengan pesan "W11: Soal 2".

```dart
    const authority = 'www.googleapis.com';
    const path = '/books/v1/volumes/1PYr5wxdG9kC';
```

Output Untuk Soal 2:

![Output Soal 1 Praktikum 1](img/image01.png)

### Soal 3
- Jelaskan maksud kode langkah 5 tersebut terkait substring dan catchError!

1. substring(0, 450)

- Baris value.body.toString().substring(0, 450) mengambil 450 karakter pertama dari respons (mulai indeks 0 sampai <450).

- Masalahnya: kalau panjang string < 450, substring akan melempar RangeError → ini dianggap error di rantai Future dan akan masuk ke catchError.

2. 2) .catchError((_) { ... })

- catchError menangkap semua error yang terjadi pada getData() atau di dalam callback .then(...) (mis. RangeError dari substring).

- Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W11: Soal 3".

![Output Soal 3 Praktikum 1](GIF/gif01.gif)

## Praktikum 2: Menggunakan await/async untuk menghindari callbacks
