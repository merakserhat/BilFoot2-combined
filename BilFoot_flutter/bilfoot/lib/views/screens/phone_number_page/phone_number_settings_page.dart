import 'package:bilfoot/config/constants/program_colors.dart';
import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/screens/phone_number_page/widgets/phone_number_input.dart';
import 'package:bilfoot/views/screens/phone_number_page/widgets/phone_privacy_settings.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:bilfoot/views/widgets/bilfoot_button.dart';
import 'package:bilfoot/views/widgets/spinners/spinner_small.dart';
import "package:flutter/material.dart";
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberSettingsPage extends StatefulWidget {
  const PhoneNumberSettingsPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberSettingsPage> createState() =>
      _PhoneNumberSettingsPageState();
}

class _PhoneNumberSettingsPageState extends State<PhoneNumberSettingsPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  bool isLoading = false;
  bool isSucceded = false;
  PhoneNumber? phoneNumber;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(phoneNumber?.phoneNumber);
    return Scaffold(
        appBar: const BasicAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: ProgramConstants.pagePadding,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox.square(dimension: 20),
                  Text(
                    "Your Phone Number",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox.square(dimension: 20),
                  PhoneNumberInput(
                    initialNumber: Program.program.user!.phoneNumber,
                    setNumber: (number) {
                      setState(() {
                        phoneNumber = number;
                      });
                    },
                    controller: controller,
                  ),
                  const SizedBox.square(dimension: 60),
                  Text(
                    "Only those people can reach your phone number:\n\n\t-Your teammates.\n\t-Players from your matches\n\t-Players you have interacted via announcements",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox.square(dimension: 60),
                  isLoading
                      ? const SpinnerSmall()
                      : isSucceded
                          ? Text(
                              "Phone Number successfully updated!\nDirecting to previous page...",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color:
                                          const Color.fromARGB(255, 3, 88, 6)),
                              textAlign: TextAlign.center,
                            )
                          : BilfootButton(
                              label: "Update",
                              onPressed: onUpdatePressed,
                              disabled: phoneNumber?.phoneNumber ==
                                  Program.program.user!.phoneNumber,
                            ),
                ],
              ),
            ),
          ),
        ));
  }

  void onUpdatePressed() async {
    if (formKey.currentState!.validate() && phoneNumber?.phoneNumber != null) {
      setState(() {
        isLoading = true;
      });

      isSucceded = await BilfootClient()
          .updatePhoneNumber(phoneNumber: phoneNumber!.phoneNumber!);

      setState(() {
        isLoading = false;
      });

      Future.delayed(
          const Duration(seconds: 1), () => Navigator.of(context).pop());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
