import 'dart:async';

import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/config/utils/auth_service.dart';
import 'package:bilfoot/views/screens/main_page/main_control_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/auth_title.dart';

class AuthVerificationPage extends StatefulWidget {
  const AuthVerificationPage({Key? key}) : super(key: key);

  @override
  State<AuthVerificationPage> createState() => _AuthVerificationPageState();
}

class _AuthVerificationPageState extends State<AuthVerificationPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();
      if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainControlPage()));
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/logo_huge.png",
            color: Colors.black.withOpacity(0.03),
          ),
          Padding(
            padding: ProgramConstants.pagePadding,
            child: Column(
              children: [
                const AuthTitle(),
                const SizedBox.square(dimension: 20),
                Text(
                  "Verification link is sent to your email ${FirebaseAuth.instance.currentUser!.email}",
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "You can't find the email?",
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: handleSendVerificationAgain,
                        child: const Text("Send Again"),
                      ),
                      ElevatedButton(
                        onPressed: () => AuthService.service.logout(),
                        child: const Text("Log out"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleSendVerificationAgain() {
    AuthService.service.sendVerificationLink();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
    timer?.cancel();
  }
}
