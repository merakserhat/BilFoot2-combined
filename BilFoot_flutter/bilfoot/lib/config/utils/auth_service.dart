import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //#region set singleton
  static final AuthService _program = AuthService._internal();

  factory AuthService() {
    return _program;
  }
  AuthService._internal();
  static AuthService get service => _program;
//#endregion

  bool initiallyNavigated = false;

  void init(Function(User?) notifyAuthState) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        if (!initiallyNavigated) {
          initiallyNavigated = true;
          notifyAuthState(null);
        }
        notifyAuthState(null);
      } else {
        print('User is signed in!');
        print(user);
        if (!initiallyNavigated) {
          initiallyNavigated = true;
          notifyAuthState(user);
        }
      }
    });

    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<bool> register(
      {required String emailAddress, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  void login({required String emailAddress, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  void sendVerificationLink() {
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
  }
}
