import 'package:bilfoot/config/utils/auth_service.dart';
import 'package:bilfoot/views/screens/auth_page/auth_page.dart';
import 'package:bilfoot/views/screens/auth_page/auth_verification_page.dart';
import 'package:bilfoot/views/screens/auth_page/forms/verification_form.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/change_auth_type_text.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/my_form_field.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/remember_me_checkbox.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/verification_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key, required this.onAuthChanged}) : super(key: key);

  final VoidCallback onAuthChanged;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passAgainController = TextEditingController();

  bool verificationState = false;

  @override
  Widget build(BuildContext context) {
    if (verificationState) {
      return VerificationForm(email: mailController.value.text);
    }

    return Form(
      key: loginFormKey,
      child: Column(
        children: [
          MyFormField(
            title: "Bilkent Mail",
            textInputType: TextInputType.emailAddress,
            textEditingController: mailController,
          ),
          MyFormField(
            title: "Password",
            obscureText: true,
            textEditingController: passController,
          ),
          MyFormField(
            title: "Password Again",
            obscureText: true,
            textEditingController: passAgainController,
          ),
          const SizedBox.square(dimension: 10),
          RememberMeCheckbox(
            onChanged: (bool? isSigned) {},
          ),
          const SizedBox.square(dimension: 30),
          ElevatedButton(
            onPressed: handleRegisterClicked,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 50),
              child: Text("Register"),
            ),
          ),
          const SizedBox.square(dimension: 26),
          ChangeAuthTypeText(
            currentAuthType: AuthType.register,
            changeAuthType: (authType) {
              widget.onAuthChanged();
            },
          )
        ],
      ),
    );
  }

  void handleRegisterClicked() async {
    bool isSuccessful = await AuthService.service.register(
        emailAddress: mailController.text, password: passController.text);
    if (isSuccessful) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AuthVerificationPage()));
      AuthService.service.sendVerificationLink();
    }
  }
}
