// ignore_for_file: non_constant_identifier_names

import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/screens/team_page/edit_panel/team_edit_panel.dart';
import 'package:bilfoot/views/screens/team_page/widgets/player_list_in_team_card.dart';
import 'package:bilfoot/views/screens/team_page/widgets/team_logo_title.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:bilfoot/views/widgets/bilfoot_button.dart';
import 'package:bilfoot/views/widgets/modals/quit_modal.dart';
import 'package:bilfoot/views/widgets/spinners/spinner_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_panel/bloc/team_edit_bloc.dart';

class TeamPage extends StatefulWidget {
  static const String routeName = "profile_page";

  const TeamPage({Key? key, required this.team, this.refreshTeamListCard})
      : super(key: key);

  final TeamModel team;
  final VoidCallback? refreshTeamListCard;
  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final int STRANGER_VIEW = 0;
  final int MEMBER_VIEW = 1;
  final int CAPTAIN_VIEW = 2;

  late int viewMode;

  @override
  void initState() {
    super.initState();

    if (widget.team.players.contains(Program.program.user)) {
      if (widget.team.captain == Program.program.user?.id) {
        viewMode = CAPTAIN_VIEW;
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
                    TeamLogoTitle(
                      teamModel: widget.team,
                      bigLogo: true,
                    ),
                    if (viewMode == CAPTAIN_VIEW) _buildEditTeamButton(),
                  ],
                ),
                const SizedBox.square(dimension: 30),
                PlayerListInTeamCard(
                  teamModel: widget.team,
                ),
                const SizedBox.square(dimension: 30),
                if (viewMode != STRANGER_VIEW) _buildLeaveButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditTeamButton() {
    return Positioned(
      right: 0,
      bottom: 20,
      child: GestureDetector(
        onTap: () {
          ProgramConstants.showBlurryBackground(
              context: context,
              child: BlocProvider(
                create: (context) => TeamEditBloc(),
                child: TeamEditPanel(
                  teamModel: widget.team,
                ),
              ));
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
                      await BilfootClient().quitTeam(teamId: widget.team.id);
                  Navigator.of(context).pop();

                  if (result) {
                    Program.program.user!.teams.remove(widget.team.id);
                    if (widget.refreshTeamListCard != null) {
                      widget.refreshTeamListCard!();
                    }
                    Navigator.of(context).pop();
                  }
                },
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
                  "QUIT TEAM",
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
