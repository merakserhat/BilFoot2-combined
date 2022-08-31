// ignore_for_file: non_constant_identifier_names

import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/screens/match_page/widgets/match_info.dart';
import 'package:bilfoot/views/screens/match_page/widgets/player_list_in_match_card.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:bilfoot/views/widgets/modals/quit_modal.dart';
import 'package:flutter/material.dart';

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

    if (widget.match.players.contains(Program.program.user)) {
      if (widget.match.authPlayers.contains(Program.program.user!.id)) {
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
            ProgramConstants.showBlurryBackground(
              context: context,
              child: QuitModal(
                onAccepted: () async {
                  bool result =
                      await BilfootClient().quitMatch(matchId: widget.match.id);
                  Navigator.of(context).pop();

                  // if (result) {
                  //   Navigator.of(context).pop();
                  //   context.read<TeamBloc>().add(TeamQuitTeam(teamId: team.id));
                  // }
                },
                quitMatch: true,
              ),
            );
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
