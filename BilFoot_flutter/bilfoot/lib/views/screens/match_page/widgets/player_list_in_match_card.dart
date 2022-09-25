import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/views/widgets/add_member_panel.dart';
import 'package:bilfoot/views/widgets/player_list_item.dart';
import 'package:flutter/material.dart';

class PlayerListInMatchCard extends StatelessWidget {
  const PlayerListInMatchCard(
      {Key? key,
      required this.matchModel,
      required this.isAuthView,
      required this.updateMatch})
      : super(key: key);

  final MatchModel matchModel;
  final bool isAuthView;
  final Function(MatchModel) updateMatch;

  @override
  Widget build(BuildContext context) {
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
            isAuthView ? _buildAddPlayerButton(context) : Container(),
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
                children: matchModel.players
                    .map((player) => PlayerListItem(
                          updateMatch: updateMatch,
                          playerModel: player,
                          matchModel: matchModel,
                          isCurrentAuthorized: matchModel.authPlayers.contains(
                              Program
                                  .program.user!.id), //e == teamModel.captain;
                          isCurrentUser: player == Program.program.user,
                          isAuthorized:
                              matchModel.authPlayers.contains(player.id),
                          isStrangerView: !matchModel.players.contains(
                            Program.program.user,
                          ), //e == Program.program.user
                        ))
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
                matchModel: matchModel,
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
