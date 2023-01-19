import 'package:firebase_auth/firebase_auth.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/utility.dart';

class FirebaseAuthService {
  final auth = FirebaseAuth.instance;
  AuthCredential? emailCredential;
  //Stream<User?> currentUser = FirebaseAuth.instance.userChanges();

  Future<String> signInWithEmail(String email, String password,
      [bool admin = false]) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      Utility.printLog(e.toString());
      Utility.toastMessage(mFA5D5D, 'Firebase Error', e.toString());
      return '';
    }
  }

  Future<String> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      Utility.printLog(e.toString());
      Utility.toastMessage(mFA5D5D, 'Firebase Error', e.toString());
      return '';
    }
  }
}
