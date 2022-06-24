import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bilfoot/views/screens/auth_page/auth_page.dart';
import "package:flutter/material.dart";

class AuthTitle extends StatelessWidget {
  final AuthType? authType;

  const AuthTitle({Key? key, this.authType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox.square(
          dimension: 20,
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          width: 80,
          child: Image.asset(
            'assets/images/just_logo.png',
            color: Colors.black87,
          ),
        ),
        Text(
          "BilFoot",
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox.square(
          dimension: 60,
        ),
        Text(
          _getAuthTitle(),
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox.square(
          dimension: 30,
        ),
      ],
    );
    ;
  }

  String _getAuthTitle() {
    if (authType == null) {
      return "Verification";
    } else {
      return authType == AuthType.register ? "Register" : "Login";
    }
  }
}
