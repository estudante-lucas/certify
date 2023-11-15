import 'dart:math';

class CertifyUtils {
  static String generateRandomNumericPassword(int length) {
    if (length <= 0) {
      throw ArgumentError("O comprimento da senha deve ser maior que zero.");
    }

    Random random = Random();
    StringBuffer password = StringBuffer();

    for (int i = 0; i < length; i++) {
      // Gera um dígito aleatório de 0 a 9
      password.write(random.nextInt(10));
    }

    return password.toString();
  }
}
