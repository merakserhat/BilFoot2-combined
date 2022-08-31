import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/widgets/add_member_panel.dart';
import 'package:bilfoot/views/widgets/player_list_item.dart';
import 'package:flutter/material.dart';

class PlayerListInTeamCard extends StatelessWidget {
  const PlayerListInTeamCard({Key? key, required this.teamModel})
      : super(key: key);

  final TeamModel teamModel;

  @override
  Widget build(BuildContext context) {
    /*  teamModel.players.add(Program.program.ali);
    teamModel.players.add(Program.program.boran);
    teamModel.players.add(Program.program.mete);
    teamModel.players.add(Program.program.ayberk);
    teamModel.players.add(Program.program.memduh);
    teamModel.players.add(Program.program.kerem);
    teamModel.players.add(Program.program.defans);*/
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Players",
              style: Theme.of(context).textTheme.headline3,
            ),
            _buildAddPlayerButton(context)
          ],
        ),
        const SizedBox.square(dimension: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 400),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: ProgramConstants.getDefaultBoxShadow(context),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                children: teamModel.players
                    .map(
                      (player) => PlayerListItem(
                        playerModel: player,
                        isStrangerView:
                            !teamModel.players.contains(Program.program.user),
                        isCurrentUser: player == Program.program.user,
                        isCurrentAuthorized:
                            teamModel.captain == Program.program.user?.id,
                        isAuthorized: teamModel.captain == player.id,
                        isForTeam: true,
                        teamModel: teamModel,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAddPlayerButton(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      shadowColor: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          ProgramConstants.showBlurryBackground(
              context: context,
              child: AddMemberPanel(
                teamModel: teamModel,
              ));
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
