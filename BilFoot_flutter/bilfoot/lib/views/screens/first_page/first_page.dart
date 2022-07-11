import 'package:bilfoot/config/utils/auth_service.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/screens/auth_page/auth_page.dart';
import 'package:bilfoot/views/screens/auth_page/auth_verification_page.dart';
import 'package:bilfoot/views/screens/main_page/main_control_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);
  static const String routeName = "first_page";

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    initAuthentication();
  }

  void initAuthentication() {
    AuthService.service.init((User? user) async {
      if (user == null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const AuthPage()));
        return;
      }
      if (!user.emailVerified) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const AuthVerificationPage()));
        return;
      }

      await AuthService.service.getIdToken(user);
      bool isSuccess = await BilfootClient().getHomeData();

      if (!isSuccess) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const AuthPage()));
        return;
      }

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainControlPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Loading..."),
          ],
        ),
      ),
    );
  }
}
