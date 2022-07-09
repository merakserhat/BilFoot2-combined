// ignore_for_file: non_constant_identifier_names

import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/match_page/widgets/match_info.dart';
import 'package:bilfoot/views/screens/match_page/widgets/player_list_in_match_card.dart';
import 'package:bilfoot/views/screens/team_page/edit_panel/team_edit_panel.dart';
import 'package:bilfoot/views/screens/team_page/widgets/player_list_in_team_card.dart';
import 'package:bilfoot/views/screens/team_page/widgets/team_logo_title.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchDetailedPage extends StatefulWidget {
  static const String routeName = "match_detailed_page";

  const MatchDetailedPage({Key? key, required this.match}) : super(key: key);

  final MatchModel match;
  @override
  State<MatchDetailedPage> createState() => _MatchDetailedPageState();
}

class _MatchDetailedPageState extends State<MatchDetailedPage> {
  final int STRANGER_VIEW = 0;
  final int MEMBER_VIEW = 1;
  final int AUTH_VIEW = 2;

  late int viewMode;

  @override
  void initState() {
    super.initState();

    if (widget.match.people.contains(Program.program.user)) {
      if (widget.match.authPeople.contains(Program.program.user)) {
        viewMode = AUTH_VIEW;
      } else {
        viewMode = MEMBER_VIEW;
      }
    } else {
      viewMode = STRANGER_VIEW;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: ProgramConstants.pagePadding,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    MatchInfo(matchModel: widget.match),
                    if (viewMode == AUTH_VIEW) _buildEditMatchButton(),
                  ],
                ),
                const SizedBox.square(dimension: 30),
                PlayerListInMatchCard(
                  matchModel: widget.match,
                  isAuthView: viewMode == AUTH_VIEW,
                ),
                const SizedBox.square(dimension: 30),
                viewMode != STRANGER_VIEW
                    ? _buildLeaveButton(context)
                    : _buildJoinButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditMatchButton() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          /*ProgramConstants.showBlurryBackground(
              context: context,
              child: BlocProvider(
                create: (context) => TeamEditBloc(),
                child: TeamEditPanel(
                  teamModel: widget.team,
                ),
              ));*/
        },
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(100)),
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.red,
        shadowColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            //TODO: quit player
          },
          child: Container(
              width: 120,
              height: 40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Text(
                  "QUIT MATCH",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white, fontSize: 14),
                ),
              )),
        ),
      ),
    );
  }

  Widget _buildJoinButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.green,
        shadowColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            //TODO: Joint match
          },
          child: Container(
              width: 120,
              height: 40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Text(
                  "JOIN MATCH",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white, fontSize: 14),
                ),
              )),
        ),
      ),
    );
  }
}
