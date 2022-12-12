import 'dart:async';

import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/config/utils/auth_service.dart';
import 'package:bilfoot/views/screens/auth_page/bloc/authentication_bloc.dart';
import 'package:bilfoot/views/screens/main_page/main_control_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseAuth.instance.currentUser!.reload();
        if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
          context.read<AuthenticationBloc>().add(FirebaseEmailVerified());
          timer.cancel();
        }
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
                        onPressed: () => context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationLogOut()),
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
    super.dispose();
    timer?.cancel();
  }
}
