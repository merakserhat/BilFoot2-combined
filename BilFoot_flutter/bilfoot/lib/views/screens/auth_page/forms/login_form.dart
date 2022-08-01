import 'package:bilfoot/config/utils/auth_service.dart';
import 'package:bilfoot/views/screens/auth_page/auth_page.dart';
import 'package:bilfoot/views/screens/auth_page/forgot_password_page.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/change_auth_type_text.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/my_form_field.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/remember_me_checkbox.dart';
import 'package:bilfoot/views/screens/first_page/first_page.dart';
import 'package:bilfoot/views/screens/main_page/main_control_page.dart';
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

  String? error;
  bool isLoading = false;

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
            onChange: (_) {
              resolveError();
            },
          ),
          MyFormField(
            title: "Şifre",
            obscureText: true,
            textEditingController: passController,
            onChange: (_) {
              resolveError();
            },
          ),
          const SizedBox.square(dimension: 10),
          Row(
            children: [
              Expanded(
                child: RememberMeCheckbox(
                  onChanged: (bool? isSigned) {},
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ForgotPasswordPage()));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text(
                    "Forgot Password",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              )
            ],
          ),
          const SizedBox.square(dimension: 30),
          isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: handleLoginClicked,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 50),
                    child: Text("Login"),
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

  void handleLoginClicked() async {
    setState(() {
      isLoading = true;
    });
    String? error = await AuthService.service.login(
        emailAddress: mailController.text, password: passController.text);

    if (error != null) {
      setState(() {
        this.error = error;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void resolveError() {
    if (error != null) {
      setState(() {
        error = null;
      });
    }
  }
}
