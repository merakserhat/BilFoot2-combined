import 'package:bilfoot/config/constants/announcement_types.dart';
import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/team_selector.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:flutter/material.dart';

class NewAnnouncementPage extends StatelessWidget {
  const NewAnnouncementPage({Key? key, required this.announcementType})
      : super(key: key);

  final AnnouncementTypes announcementType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(),
      body: Padding(
        padding: ProgramConstants.pagePadding,
        child: Column(
          children: [
            Text(
              _getOpponentTitle(),
              style: Theme.of(context).textTheme.headline5,
            ),
            const Divider(),
            const SizedBox.square(dimension: 15),
            ..._getAnnouncementOptions(),
          ],
        ),
      ),
    );
  }

  String _getOpponentTitle() {
    switch (announcementType) {
      case AnnouncementTypes.player:
        return "Create Player Announcement";
      case AnnouncementTypes.opponent:
        return "Create Opponent Announcement";
      default:
        return "Create Match Announcement";
    }
  }

  List<Widget> _getAnnouncementOptions() {
    switch (announcementType) {
      case AnnouncementTypes.player:
        return [];
      case AnnouncementTypes.opponent:
        return [
          const AnnouncementOptionTitle(title: "Your Team:"),
          TeamSelector(teams: [
            Program.program.dummyTeam1,
            Program.program.dummyTeam1,
            Program.program.dummyTeam1,
            Program.program.dummyTeam1,
          ], onSelectionChanged: (team) {})
        ];
      default:
        return [];
    }
  }
}

class AnnouncementOptionTitle extends StatelessWidget {
  const AnnouncementOptionTitle({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
