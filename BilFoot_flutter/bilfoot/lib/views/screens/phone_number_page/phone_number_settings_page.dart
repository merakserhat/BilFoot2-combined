import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/screens/phone_number_page/widgets/phone_number_input.dart';
import 'package:bilfoot/views/screens/phone_number_page/widgets/phone_privacy_settings.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:bilfoot/views/widgets/bilfoot_button.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BasicAppBar(),
        body: Padding(
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
                  initialNumber: "+905455591600",
                ),
                const SizedBox.square(dimension: 60),
                Text(
                  "Only those people can reach your phone number:\n\n\t-Your teammates.\n\t-Players from your matches\n\t-Players you have interacted via announcements",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox.square(dimension: 60),
                BilfootButton(
                  label: "Update",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
