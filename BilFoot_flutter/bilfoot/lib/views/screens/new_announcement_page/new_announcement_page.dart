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
import 'package:bilfoot/views/widgets/fragmented_header/fragmented_header.dart';
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
  late final List<String> newPlayerTitles, newOpponentTitles;
  late final List<Widget> newPlayerWidgets, newOpponentWidgets;
  int _selectedIndex = 0;

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
    //TODO: bunu awaitten sonra söyle
    _setAnnouncementOptions();
    _setTitles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              FragmentedHeader(
                msgSend: "Announce",
                selectedIndex: _selectedIndex,
                titles: _getTitles(),
                onChanged: (int index, String title) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
              const SizedBox.square(dimension: 10),
              Expanded(child: _getAnnouncementOptions()[_selectedIndex]),
              const SizedBox.square(dimension: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: BilfootButton(
                    label: _selectedIndex == _getTitles().length - 1
                        ? "Announce!"
                        : "Continue",
                    onPressed: createAnnouncement,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getTitles() {
    switch (widget.announcementType) {
      case AnnouncementTypes.player:
        return newPlayerTitles;
      case AnnouncementTypes.opponent:
        return newOpponentTitles;
      default:
        return [];
    }
  }

  List<Widget> _getAnnouncementOptions() {
    switch (widget.announcementType) {
      case AnnouncementTypes.player:
        return newPlayerWidgets;
      case AnnouncementTypes.opponent:
        return newOpponentWidgets;
      default:
        return [];
    }
  }

  void _setTitles() {
    switch (widget.announcementType) {
      case AnnouncementTypes.player:
        newPlayerTitles = [
          "Select Match",
          "Select Positions",
          "Select Player Limit",
        ];
        break;
      case AnnouncementTypes.opponent:
        newOpponentTitles = [
          "Select Team",
          "Select Match",
        ];
        break;
      default:
      //TODO: this part is now not active.
    }
  }

  void _setAnnouncementOptions() {
    switch (widget.announcementType) {
      case AnnouncementTypes.player:
        newPlayerWidgets = [
          MatchSelector(matches: [
            Program.program.dummyData.dummyMatch1,
            Program.program.dummyData.dummyMatch1,
            Program.program.dummyData.dummyMatch1,
            Program.program.dummyData.dummyMatch1,
          ], onSelectionChanged: _onMatchSelectionChanged),
          PositionSelectorSmall(onSelectionChange: (List<String> positions) {
            setState(() {
              playerPositions = [...positions];
            });
          }),
          NumberSlider(
            min: 0,
            max: 8,
            onChanged: _onNumberOfPlayersChanged,
          ),
        ];
        break;
      case AnnouncementTypes.opponent:
        newOpponentWidgets = [
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
              }),
          MatchSelector(matches: [
            Program.program.dummyData.dummyMatch1,
            Program.program.dummyData.dummyMatch1,
            Program.program.dummyData.dummyMatch1,
            Program.program.dummyData.dummyMatch1,
          ], onSelectionChanged: _onMatchSelectionChanged),
        ];
        break;
      case AnnouncementTypes.match:
        //TODO: for now, this part is not active.
        break;
    }
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

  void createAnnouncement() {
    print(forTeam);
    print(teamModel);
    print(playerPositions);

    //if(_selectedIndex == _getTitles().length - 1) {

    //} else {
    setState(() {
      _selectedIndex++;
      if (_selectedIndex == _getTitles().length) {
        _selectedIndex = 0;
      }
    });
    //}

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
