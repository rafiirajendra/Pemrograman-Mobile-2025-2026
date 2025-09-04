void main() {
  // 1. ERROR: Variabel non-nullable 'name' harus diinisialisasi.
  // String name;
  // print(name);

  // 2. SOLUSI A: Langsung beri nilai (inisialisasi)
  String name = 'Budi';
  print('Nama: $name');

  // 3. SOLUSI B: Izinkan variabel menjadi null dengan '?'
  String? address;
  print('Alamat: $address');

  // Mengisi nilai pada variabel nullable
  address = 'Jakarta';
  print('Alamat baru: $address');
}