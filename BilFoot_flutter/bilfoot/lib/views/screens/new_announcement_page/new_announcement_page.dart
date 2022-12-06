import 'package:bilfoot/config/constants/announcement_types.dart';
import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/match_selector.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/team_or_match_toggle.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/team_selector.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:bilfoot/views/widgets/bilfoot_button.dart';
import 'package:bilfoot/views/widgets/modals/set_phone_modal.dart';
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
  List<MatchModel>? playerMatches;
  List<TeamModel>? playerTeams;
  bool isMatchesLoading = true;
  bool isTeamsLoading = true;

  @override
  void initState() {
    super.initState();
    //TODO: burada maçları çek
    //TODO: burada eğer opponent ise takımları da çek
    getPlayerMatches();
    if (widget.announcementType == AnnouncementTypes.opponent) {
      getPlayerTeams();
    } else {
      isTeamsLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Padding(
        padding: ProgramConstants.pagePadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                _getOpponentTitle(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
              const Divider(),
              const SizedBox.square(dimension: 15),
              ..._getAnnouncementOptions(),
              const SizedBox.square(dimension: 30),
              BilfootButton(
                  onPressed: createAnnouncement, label: "Create Announcement")
            ],
          ),
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
          AnnouncementOptionItem(
              widget: MatchSelector(matches: [
                Program.program.dummyData.dummyMatch1,
                Program.program.dummyData.dummyMatch1,
                Program.program.dummyData.dummyMatch1,
                Program.program.dummyData.dummyMatch1,
              ], onSelectionChanged: _onMatchSelectionChanged),
              title: "Select Your Match"),
          AnnouncementOptionItem(
              widget: PositionSelectorSmall(
                  onSelectionChange: (List<String> positions) {
                setState(() {
                  playerPositions = [...positions];
                });
              }),
              title: "Player's positions"),
          AnnouncementOptionItem(
              widget: NumberSlider(
                min: 0,
                max: 8,
                onChanged: _onNumberOfPlayersChanged,
              ),
              title: "Select number of players you need"),
        ];
      case AnnouncementTypes.opponent:
        return [
          AnnouncementOptionItem(
            widget: TeamSelector(
                teams: [
                  Program.program.dummyData.dummyTeam1,
                  Program.program.dummyData.dummyTeam1,
                  Program.program.dummyData.dummyTeam1,
                  Program.program.dummyData.dummyTeam1,
                  Program.program.dummyData.dummyTeam1,
                ],
                onSelectionChanged: (team) {
                  teamModel = team;
                }),
            title: "Select your team",
          ),
          AnnouncementOptionItem(
              widget: MatchSelector(matches: [
                Program.program.dummyData.dummyMatch1,
                Program.program.dummyData.dummyMatch1,
                Program.program.dummyData.dummyMatch1,
                Program.program.dummyData.dummyMatch1,
              ], onSelectionChanged: _onMatchSelectionChanged),
              title: "Select Your Match"),
        ];
      default:
        return [];
    }
  }

  void createAnnouncement() {
    print(forTeam);
    print(teamModel);
    print(playerPositions);

    if (Program.program.user!.phoneNumber == null) {
      ProgramConstants.showBlurryBackground(
          context: context,
          child: const SetPhoneModal(
              phoneModalText: PhoneModalText.announcementText));
    }
  }

  _onNumberOfPlayersChanged(double value) {}

  _onMatchSelectionChanged(MatchModel selectedMatch) {}

  void getPlayerTeams() {}

  void getPlayerMatches() {}
}

class AnnouncementOptionItem extends StatelessWidget {
  const AnnouncementOptionItem(
      {Key? key, required this.title, required this.widget})
      : super(key: key);

  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox.square(dimension: 5),
        Text(
          title,
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox.square(dimension: 10),
        widget,
        const SizedBox.square(dimension: 25),
      ],
    );
  }
}
