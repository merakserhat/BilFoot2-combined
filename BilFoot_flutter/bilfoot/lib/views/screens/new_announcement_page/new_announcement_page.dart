import 'package:bilfoot/config/constants/announcement_types.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/match_selector.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/team_or_match_toggle.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/team_selector.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:bilfoot/views/widgets/number_slider.dart';
import 'package:bilfoot/views/widgets/position_selector.dart';
import 'package:bilfoot/views/widgets/position_selector_small.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  MatchModel? matchModel;
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
          //has to get both matches and teams arrays
          TeamOrMatchToggle(
              teams: [
                Program.program.dummyData.dummyTeam1,
                Program.program.dummyData.dummyTeam1,
                Program.program.dummyData.dummyTeam1,
                Program.program.dummyData.dummyTeam1,
                Program.program.dummyData.dummyTeam1,
              ],
              mathces: [
                Program.program.dummyData.dummyMatch1,
                Program.program.dummyData.dummyMatch1,
                Program.program.dummyData.dummyMatch1,
                Program.program.dummyData.dummyMatch1,
              ],
              onSelectionChanged: (team) {
                teamModel = team;
              },
              onSelectionChangedForMatch: (match) {
                matchModel = match;
              },
              onToggleChanged: (forMatch) {
                forTeam = !forMatch;
              }),
          const AnnouncementOptionTitle(title: "Player's positions"),
          PositionSelectorSmall(onSelectionChange: (List<String> positions) {
            playerPositions = [...positions];
          }),
          const SizedBox.square(
            dimension: 4,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 24),
            child: Text("Select Number of Players"),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 4, right: 4, bottom: 12),
            child: NumberSlider(firstNumber: 0, lastNumber: 14),
          ),
        ];
      case AnnouncementTypes.opponent:
        return [
          const AnnouncementOptionTitle(title: "Your Team"),
          TeamSelector(
              teams: [
                Program.program.dummyData.dummyTeam1,
                Program.program.dummyData.dummyTeam1,
                Program.program.dummyData.dummyTeam1,
                Program.program.dummyData.dummyTeam1,
                Program.program.dummyData.dummyTeam1,
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
