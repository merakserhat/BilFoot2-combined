import 'package:bilfoot/views/screens/auth_page/auth_page.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/change_auth_type_text.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/my_form_field.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/remember_me_checkbox.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key, required this.onAuthChanged}) : super(key: key);

  final VoidCallback onAuthChanged;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
      child: Column(
        children: [
          MyFormField(
            title: "Kullanıcı Adı veya E-Posta",
            textInputType: TextInputType.emailAddress,
            textEditingController: mailController,
          ),
          MyFormField(
            title: "Şifre",
            obscureText: true,
            textEditingController: passController,
          ),
          const SizedBox.square(dimension: 10),
          RememberMeCheckbox(
            onChanged: (bool? isSigned) {},
          ),
          const SizedBox.square(dimension: 30),
          ElevatedButton(
            onPressed: () {
              //TODO: login clicked
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 50),
              child: Text("Login"),
            ),
          ),
          const SizedBox.square(dimension: 26),
          ChangeAuthTypeText(
            currentAuthType: AuthType.login,
            changeAuthType: (authType) {
              widget.onAuthChanged();
            },
          )
        ],
      ),
    );
  }
}
