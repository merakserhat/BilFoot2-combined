// ignore_for_file: non_constant_identifier_names

import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/screens/team_page/bloc/team_bloc.dart';
import 'package:bilfoot/views/screens/team_page/edit_panel/team_edit_panel.dart';
import 'package:bilfoot/views/screens/team_page/widgets/player_list_in_team_card.dart';
import 'package:bilfoot/views/screens/team_page/widgets/team_logo_title.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:bilfoot/views/widgets/bilfoot_button.dart';
import 'package:bilfoot/views/widgets/modals/quit_modal.dart';
import 'package:bilfoot/views/widgets/spinners/spinner.dart';
import 'package:bilfoot/views/widgets/spinners/spinner_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_panel/bloc/team_edit_bloc.dart';

class TeamPage extends StatelessWidget {
  static const String routeName = "team_page";

  const TeamPage(
      {Key? key, this.teamModel, this.refreshTeamListCard, this.teamId})
      : super(key: key);

  final TeamModel? teamModel;
  final String? teamId; //for out teams to be updated
  final VoidCallback? refreshTeamListCard;

  final int STRANGER_VIEW = 0;
  final int MEMBER_VIEW = 1;
  final int CAPTAIN_VIEW = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: ProgramConstants.pagePadding,
          child: SizedBox(
            width: double.infinity,
            child: BlocBuilder<TeamBloc, TeamState>(
              builder: (context, state) {
                late int viewMode;

                TeamModel? team;

                if (teamModel != null) {
                  team = teamModel!;
                } else {
                  try {
                    team = state.teams!
                        .firstWhere((element) => element.id == teamId);
                  } catch (e) {}
                }

                if (team == null) {
                  return const Center(child: Spinner());
                }

                if (team.players.contains(Program.program.user)) {
                  if (team.captain == Program.program.user?.id) {
                    viewMode = CAPTAIN_VIEW;
                  } else {
                    viewMode = MEMBER_VIEW;
                  }
                } else {
                  viewMode = STRANGER_VIEW;
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        TeamLogoTitle(
                          teamModel: team,
                          bigLogo: true,
                        ),
                        if (viewMode == CAPTAIN_VIEW)
                          _buildEditTeamButton(context, team),
                      ],
                    ),
                    const SizedBox.square(dimension: 30),
                    PlayerListInTeamCard(
                      teamModel: team,
                    ),
                    const SizedBox.square(dimension: 30),
                    if (viewMode != STRANGER_VIEW)
                      _buildLeaveButton(context, team),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditTeamButton(BuildContext context, TeamModel team) {
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
                  teamModel: team,
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

  Widget _buildLeaveButton(BuildContext context, TeamModel team) {
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
                  bool result = await BilfootClient().quitTeam(teamId: team.id);
                  Navigator.of(context).pop();

                  if (result) {
                    Navigator.of(context).pop();
                    context.read<TeamBloc>().add(TeamQuitTeam(teamId: team.id));
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
