import 'package:bilfoot/config/constants/announcement_types.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/widgets/position_selector.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/team_or_match_toggle.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/team_selector.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:flutter/material.dart';

class NewAnnouncementPage extends StatefulWidget {
  const NewAnnouncementPage({Key? key, required this.announcementType})
      : super(key: key);

  final AnnouncementTypes announcementType;

  @override
  State<NewAnnouncementPage> createState() => _NewAnnouncementPageState();
}

class _NewAnnouncementPageState extends State<NewAnnouncementPage> {
  bool forTeam = false;
  TeamModel? teamModel;
  List<String> playerPositions = ["CM"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                _getOpponentTitle(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const Divider(),
            const SizedBox.square(dimension: 15),
            ..._getAnnouncementOptions(),
            const SizedBox.square(dimension: 20),
            ElevatedButton(
                onPressed: createAnnouncement, child: const Text("Create"))
          ],
        ),
      ),
    );
  }

  String _getOpponentTitle() {
    switch (widget.announcementType) {
      case AnnouncementTypes.player:
        return "Create Player Announcement";
      case AnnouncementTypes.opponent:
        return "Create Opponent Announcement";
      default:
        return "Create Match Announcement";
    }
  }

  List<Widget> _getAnnouncementOptions() {
    switch (widget.announcementType) {
      case AnnouncementTypes.player:
        return [
          const AnnouncementOptionTitle(title: "For What?"),
          TeamOrMatchToggle(
              teams: [
                Program.program.dummyTeam1,
                Program.program.dummyTeam1,
                Program.program.dummyTeam1,
                Program.program.dummyTeam1,
              ],
              onSelectionChanged: (team) {
                teamModel = team;
              },
              onToggleChanged: (forMatch) {
                forTeam = !forMatch;
              }),
          const AnnouncementOptionTitle(title: "Player's positions"),
          PositionSelector(onSelectionChange: (List<String> positions) {
            playerPositions = [...positions];
          })
        ];
      case AnnouncementTypes.opponent:
        return [
          const AnnouncementOptionTitle(title: "Your Team"),
          TeamSelector(
              teams: [
                Program.program.dummyTeam1,
                Program.program.dummyTeam1,
                Program.program.dummyTeam1,
                Program.program.dummyTeam1,
              ],
              onSelectionChanged: (team) {
                teamModel = team;
              })
        ];
      default:
        return [];
    }
  }

  void createAnnouncement() {
    print(forTeam);
    print(teamModel);
    print(playerPositions);
  }
}

class AnnouncementOptionTitle extends StatelessWidget {
  const AnnouncementOptionTitle({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
