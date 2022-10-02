import 'package:bilfoot/data/models/program.dart';
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

  ///returns error if exists
  Future<String?> register(
      {required String emailAddress, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //print('The password provided is too weak.');
        return "Your password is so weak!";
      } else if (e.code == 'email-already-in-use') {
        //print('The account already exists for that email.');
        return "This email adress is already in use.";
      }
    } catch (e) {
      return "An error occured!.";
    }
    return null;
  }

  ///returns error if exists
  Future<String?> login(
      {required String emailAddress, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //print('No user found for that email.');
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        //print('Wrong password provided for that user.');
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      return "An error occured!.";
    }
    return null;
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  void sendVerificationLink() {
    print("current user");
    print(FirebaseAuth.instance.currentUser);
    FirebaseAuth.instance.currentUser
        ?.sendEmailVerification()
        .catchError((error) {
      print(error);
    });
  }

  Future<String?> sendPasswordResetLink({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }

    return null;
  }

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future getIdToken(User user) async {
    String token = await user.getIdToken();
    Program.program.token = token;
    print("user token : " + token);
  }
}
