import 'package:certify/shared/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<UserCredential?> authenticate(String username, String password) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(email: username, password: password);
    } on FirebaseAuthException {
      return null;
    }
  }

  static Future<void> createCredential(String email) async {
    String randomPassword = CertifyUtils.generateRandomNumericPassword(8);
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: randomPassword);

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static bool isAuthenticated() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
