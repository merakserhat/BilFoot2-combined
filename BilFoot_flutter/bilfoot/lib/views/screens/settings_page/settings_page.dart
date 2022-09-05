import 'package:bilfoot/views/screens/settings_page/widgets/setting_option_item.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
          children: [
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Text("Ayarlar",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            const SettingsOptionItem(
              label: "keksdsds",
              icon: Icons.abc,
            )
          ],
        ),
      ),
    );
  }

  void lol() {
    print("kek");
  }
}
