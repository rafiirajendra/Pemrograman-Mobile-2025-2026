void main() {
  String nim = "2341720158";
  String nama = "Muhammad Rafi Rajendra";

  for (int n = 0; n <= 203; n++) {
    bool prima = true;

    if (n < 2) {
      prima = false;
    } else {
      for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) {
          prima = false;
          break;
        }
      }
    }

    if (prima) {
      print("$n adalah bilangan prima → $nama ($nim)");
    }
  }
}
