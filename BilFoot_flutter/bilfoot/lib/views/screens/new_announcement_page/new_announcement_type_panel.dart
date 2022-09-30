import 'package:bilfoot/config/constants/announcement_types.dart';
import 'package:bilfoot/views/screens/new_announcement_page/new_announcement_page.dart';
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
          style: Theme.of(context).textTheme.headline3,
        ),
        const Divider(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();

              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const NewAnnouncementPage(
                    announcementType: AnnouncementTypes.player);
              }));
            },
            child: const Text("Player"),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();

              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const NewAnnouncementPage(
                    announcementType: AnnouncementTypes.opponent);
              }));
            },
            child: const Text("Opponent"),
          ),
        ),
        // SizedBox(
        //   width: double.infinity,
        //   child: ElevatedButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //         return const NewAnnouncementPage(
        //             announcementType: AnnouncementTypes.match);
        //       }));
        //     },
        //     child: const Text("Match"),
        //   ),
        // ),
      ],
    ));
  }
}
