import 'package:bilfoot/views/screens/auth_page/bloc/authentication_bloc.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/cards/player_announcement_card.dart';
import 'package:bilfoot/views/screens/phone_number_page/phone_number_settings_page.dart';
import 'package:bilfoot/views/screens/settings_page/widgets/setting_option_item.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../new_announcement_page/widgets/cards/opponent_announcement_card.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Text("Ayarlar",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontWeight: FontWeight.bold)),
            ),

            // ignore: prefer_const_constructors
            SettingsOptionItem(
              label: "Bildirimleri Yönet",
              icon: Icons.arrow_forward_ios_rounded,
              //TODO:
              onClick: () {},
            ),
            SettingsOptionItem(
              label: "Update Phone Number",
              icon: Icons.arrow_forward_ios_rounded,
              onClick: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const PhoneNumberSettingsPage()));
              },
            ),
            SettingsOptionItem(
              label: "Bİlfoot'u Değerlendir",
              icon: Icons.arrow_forward_ios_rounded,
              //TODO:
              onClick: () {},
            ),
            SettingsOptionItem(
              label: "Çıkış Yap",
              icon: Icons.exit_to_app,
              //TODO:
              onClick: () {
                Navigator.of(context).pop();

                context.read<AuthenticationBloc>().add(AuthenticationLogOut());
              },
            ),
          ],
        ),
      ),
    );
  }
}
