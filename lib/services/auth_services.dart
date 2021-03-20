part of 'services.dart';

class AuthServices {
  static var _auth = FirebaseAuth.instance;
  static Future<SignInSignOutResult> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      Users user = userCredential.user.convertToAdmin();
      await UsersServices.updateUser(user);
      return SignInSignOutResult(user: user);
    } on FirebaseAuthException catch (e) {
      return SignInSignOutResult(message: e.toString());
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<User> get userStream => _auth.authStateChanges();
}

class SignInSignOutResult {
  final Users user;
  final String message;

  SignInSignOutResult({this.user, this.message});
}
