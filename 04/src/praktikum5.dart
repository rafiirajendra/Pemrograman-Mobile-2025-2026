void main() {
  var record = ('first', a: 2, b: true, 'last');
  print("Record awal: $record");

  (int, int) angka = (10, 20);
  print("Sebelum tukar: $angka");

  var hasil = tukar(angka);
  print("Sesudah tukar: $hasil");

  // Record type annotation in a variable declaration:
  (String, int) mahasiswa = ('Rafi Rajendra', 2341720158);
  print("Data Mahasiswa: $mahasiswa");

  var mahasiswa2 = ('Rafi Rajendra', a: 2341720158, b: true, 'last');

  print(mahasiswa2.$1); // Prints 'first'
  print(mahasiswa2.a); // Prints 2
  print(mahasiswa2.b); // Prints true
  print(mahasiswa2.$2); // Prints 'last'
}

(int, int) tukar((int, int) record) {
  var (a, b) = record;
  return (b, a);
}
