import 'package:bilfoot/views/screens/auth_page/auth_page.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/change_auth_type_text.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/my_form_field.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/remember_me_checkbox.dart';
import 'package:bilfoot/views/screens/auth_page/widgets/verification_field.dart';
import 'package:flutter/material.dart';

class VerificationForm extends StatefulWidget {
  const VerificationForm({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<VerificationForm> createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  TextEditingController verificationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.email +
              ' adresine gönderdiğimiz 6 basamaklı kodu girerek giriş yap.', //TODO write this in english
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox.square(dimension: 50),
        VerificationField(textEditingController: verificationController),
        const SizedBox.square(dimension: 50),
        ElevatedButton(
          onPressed: () {
            //TODO: login clicked
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 50),
            child: Text("Verify"),
          ),
        ),
      ],
    );
  }
}
