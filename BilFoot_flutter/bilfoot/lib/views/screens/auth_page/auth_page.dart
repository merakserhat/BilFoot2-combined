import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/screens/auth_page/forms/login_form.dart';
import 'package:bilfoot/views/screens/auth_page/forms/register_form.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/auth_title.dart';
import 'package:flutter/material.dart';

enum AuthType { register, login }

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key, this.initialAuthType = AuthType.register})
      : super(key: key);

  final AuthType initialAuthType;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late AuthType currentAuthType;

  @override
  void initState() {
    super.initState();
    currentAuthType = widget.initialAuthType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/logo_huge.png",
              color: Colors.black.withOpacity(0.03),
            ),
            Padding(
              padding: ProgramConstants.pagePadding,
              child: Column(
                children: [
                  AuthTitle(
                    authType: currentAuthType,
                  ),
                  const SizedBox.square(dimension: 8),
                  currentAuthType == AuthType.register
                      ? RegisterForm(
                          onAuthChanged: () {
                            setState(() {
                              currentAuthType = AuthType.login;
                            });
                          },
                        )
                      : LoginForm(
                          onAuthChanged: () {
                            setState(() {
                              currentAuthType = AuthType.register;
                            });
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
