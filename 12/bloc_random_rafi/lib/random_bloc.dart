import 'dart:async';
import 'dart:math';

class RandomNumberBloc {
  // StreamController untuk input event
  final _generateRandomController = StreamController<void>();

  // StreamController untuk output angka acak
  final _randomNumberController = StreamController<int>();

  // Input Sink (dipakai UI untuk “minta” angka baru)
  Sink<void> get generateRandom => _generateRandomController.sink;

  // Output Stream (dipakai UI untuk “mendengar” angka baru)
  Stream<int> get randomNumber => _randomNumberController.stream;

  // Constructor: dengarkan event dari generateRandom,
  // lalu setiap ada event, kirim angka random ke randomNumber
  RandomNumberBloc() {
    _generateRandomController.stream.listen((_) {
      final random = Random().nextInt(10); // 0–9
      _randomNumberController.sink.add(random);
    });
  }

  // Tutup semua controller saat BLoC sudah tidak dipakai
  void dispose() {
    _generateRandomController.close();
    _randomNumberController.close();
  }
}