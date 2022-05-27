import 'package:bilfoot/views/widgets/panel_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewAnnouncementTypePanel extends StatelessWidget {
  const NewAnnouncementTypePanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PanelBase(
        child: Column(
      children: [
        Text(
          "New Announcement",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
        const Divider(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              //TODO: player announcement page
            },
            child: const Text("Player"),
          ),
        ),
        const SizedBox.square(dimension: 5),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              //TODO: opponent announcement page
            },
            child: const Text("Opponent"),
          ),
        ),
        const SizedBox.square(dimension: 5),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              //TODO: match announcement page
            },
            child: const Text("Match"),
          ),
        ),
      ],
    ));
  }
}
