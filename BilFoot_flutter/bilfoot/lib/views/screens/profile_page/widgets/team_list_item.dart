import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/screens/team_page/bloc/team_bloc.dart';
import 'package:bilfoot/views/screens/team_page/team_page.dart';
import 'package:bilfoot/views/screens/team_page/widgets/team_logo_title.dart';
import 'package:bilfoot/views/widgets/spinners/spinner_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamListItem extends StatelessWidget {
  const TeamListItem({Key? key, required this.teamId}) : super(key: key);

  final String teamId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamBloc, TeamState>(
      builder: (context, state) {
        TeamModel? teamModel;

        state.teams?.forEach((team) {
          if (team.id == teamId) teamModel = team;
        });
        return InkWell(
          onTap: () {
            if (teamModel != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TeamPage(teamId: teamId),
                ),
              );
            }
          },
          child: Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: ProgramConstants.getDefaultBoxShadow(context),
            ),
            child: teamModel == null
                ? const Center(
                    child: SpinnerSmall(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TeamLogoTitle(teamModel: teamModel!),
                      Text('${teamModel!.players.length} players')
                    ],
                  ),
          ),
        );
      },
    );
  }
}
