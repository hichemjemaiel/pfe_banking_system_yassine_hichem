import 'dart:math';

class Code {
  static String generateRib() {
    final rib = StringBuffer();
    final random = Random();

    for (int i = 0; i < 20; i++) {
      final x = random.nextInt(10);
      rib.write(x);
    }

    return rib.toString();
  }
}