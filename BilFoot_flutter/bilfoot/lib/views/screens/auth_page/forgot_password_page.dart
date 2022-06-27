import 'dart:async';

import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/config/utils/auth_service.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/my_form_field.dart';
import 'package:bilfoot/views/screens/main_page/main_control_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/auth_title.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController mailController = TextEditingController();

  String? error;
  bool isLoading = false;
  bool isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
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
                const AuthTitle(
                  customTitle: "Forgot Password",
                ),
                const SizedBox.square(dimension: 20),
                ..._buildContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleForgotPasswordClicked() async {
    print("sa");
    setState(() {
      isLoading = true;
    });

    String? error = await AuthService.service
        .sendPasswordResetLink(email: mailController.text);

    if (error == null) {
      setState(() {
        isSuccess = true;
        isLoading = false;
      });
    } else {
      setState(() {
        this.error = error;
        isLoading = false;
      });
    }
  }

  void resolveError() {
    if (error != null) {
      setState(() {
        error = null;
      });
    }
  }

  List<Widget> _buildContent() {
    if (isSuccess) {
      return [
        Text(
          "Password reset link was sent to ${mailController.text}\nPlease check your email",
          textAlign: TextAlign.center,
        )
      ];
    } else {
      return [
        Form(
          key: forgotPasswordFormKey,
          child: Column(
            children: [
              MyFormField(
                title: "Kullanıcı Adı veya E-Posta",
                textInputType: TextInputType.emailAddress,
                textEditingController: mailController,
                onChange: (_) {
                  resolveError();
                },
              ),
              const SizedBox.square(dimension: 10),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: handleForgotPasswordClicked,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 50),
                        child: Text("Send Password Reset Link"),
                      ),
                    ),
              error != null
                  ? Text(
                      error!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).errorColor),
                    )
                  : Container(),
              const SizedBox.square(dimension: 26),
            ],
          ),
        ),
      ];
    }
  }
}
