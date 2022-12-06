import 'package:bilfoot/config/constants/settings_enums.dart';
import 'package:flutter/material.dart';

class PhonePrivacySettings extends StatefulWidget {
  const PhonePrivacySettings({Key? key}) : super(key: key);

  @override
  State<PhonePrivacySettings> createState() => _PhonePrivacySettingsState();
}

class _PhonePrivacySettingsState extends State<PhonePrivacySettings> {
  PhonePrivacyOptions? _phonePrivacy =
      PhonePrivacyOptions.teamMatchAnnouncement;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox.square(dimension: 8),
        ListTile(
          title: const Text("Everyone in this application can see my number"),
          leading: Radio<PhonePrivacyOptions>(
            value: PhonePrivacyOptions.everyone,
            groupValue: _phonePrivacy,
            onChanged: (PhonePrivacyOptions? value) {
              setState(() {
                _phonePrivacy = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Only my interactions can see my number'),
          leading: Radio<PhonePrivacyOptions>(
            value: PhonePrivacyOptions.teamMatchAnnouncement,
            groupValue: _phonePrivacy,
            onChanged: (PhonePrivacyOptions? value) {
              setState(() {
                _phonePrivacy = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text("No one can see my number"),
          leading: Radio<PhonePrivacyOptions>(
            value: PhonePrivacyOptions.never,
            groupValue: _phonePrivacy,
            onChanged: (PhonePrivacyOptions? value) {
              setState(() {
                _phonePrivacy = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
