import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/screens/phone_number_page/widgets/phone_number_input.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:bilfoot/views/widgets/bilfoot_button.dart';
import 'package:flutter/material.dart';

/**
 * Şimdilik deprecated.
 * İleride kayıt aşamasında numara almaya başlarsak bu sayfadan devam edilecek
 */
class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BasicAppBar(),
        body: Padding(
          padding: ProgramConstants.pagePadding,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox.square(dimension: 20),
                Text(
                  "To support the communication in our app, we are using WhatsApp",
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox.square(dimension: 40),
                /*Center(
                  child: SizedBox(
                      height: 80,
                      child: Image.asset("assets/images/whatsapp.png")),
                ),*/
                const SizedBox.square(dimension: 60),
                //const PhoneNumberInput(),
                Expanded(child: Container()),
                BilfootButton(
                  customPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 100),
                  label: "Onayla",
                  onPressed: () {
                    formKey.currentState?.validate();
                  },
                ),
                const SizedBox.square(dimension: 20),
                /*GestureDetector(
                  child: Text(
                    "Continue without phone number",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),*/
                const SizedBox.square(dimension: 40),
              ],
            ),
          ),
        ));
  }
}
