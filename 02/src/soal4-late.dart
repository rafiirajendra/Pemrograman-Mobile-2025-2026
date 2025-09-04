class Story {
  // Kita berjanji 'description' akan diisi sebelum diakses.
  late String description;

  // Sebuah method untuk mengambil dan mengisi data.
  void fetchDescription() {
    print('Mengambil deskripsi...');
    description = 'Ini adalah cerita petualangan yang seru!';
  }
}

void main() {
  var myStory = Story();

  // Memanggil method untuk memenuhi janji
  myStory.fetchDescription();

  // Sekarang aman untuk mengakses 'description' karena sudah diisi
  print(myStory.description);
}