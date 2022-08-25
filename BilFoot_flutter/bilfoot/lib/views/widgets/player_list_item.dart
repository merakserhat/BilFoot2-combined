// ignore_for_file: constant_identifier_names

import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/profile_page/profile_page.dart';
import 'package:bilfoot/views/screens/team_page/bloc/team_bloc.dart';
import 'package:bilfoot/views/screens/team_page/widgets/circular_button_in_list_item.dart';
import 'package:bilfoot/views/widgets/modals/captain_modal.dart';
import 'package:bilfoot/views/widgets/modals/kick_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/networking/client.dart';

class PlayerListItem extends StatelessWidget {
  const PlayerListItem({
    Key? key,
    this.isForTeam = false,
    required this.playerModel,
    required this.isStrangerView,
    required this.isCurrentUser,
    required this.isCurrentAuthorized,
    required this.isAuthorized,
    this.teamModel,
    this.matchModel,
  }) : super(key: key);

  final PlayerModel playerModel;
  final bool isForTeam;
  final bool isStrangerView;
  final bool isCurrentUser;
  final bool isCurrentAuthorized;
  final bool isAuthorized;
  final TeamModel? teamModel;
  final MatchModel? matchModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: ProgramConstants.getDefaultBoxShadow(context),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: playerModel != Program.program.user
              ? () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProfilePage(
                        playerModel: playerModel,
                      ),
                    ),
                  );
                }
              : null,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(4),
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(playerModel.fullName),
                    const SizedBox.square(dimension: 20),
                    isAuthorized
                        ? Text(
                            isForTeam ? "(c)" : "(a)",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: isForTeam
                                        ? Colors.orange
                                        : Colors.green,
                                    fontWeight: FontWeight.bold),
                          )
                        : Container()
                  ],
                ),
                _buildButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    List<Widget> buttons = [];

    if (!isStrangerView) {
      if (isCurrentAuthorized && !isCurrentUser && !isAuthorized) {
        buttons = [
          isForTeam
              ? CircularButtonInListItem(
                  buttonType: CircularButtonInListItem.captainButton,
                  onTap: () {
                    ProgramConstants.showBlurryBackground(
                      context: context,
                      child: CaptainModal(
                        onAccepted: () async {
                          bool result = await BilfootClient().makeCaptain(
                              teamId: teamModel!.id,
                              newCaptainId: playerModel.id);
                          Navigator.of(context).pop();

                          if (result) {
                            /*if (updateTeam != null) {
                              updateTeam!(
                                  teamModel!.copyWith(captain: playerModel.id));
                            }*/
                            context.read<TeamBloc>().add(
                                  TeamChangeCaptain(
                                    teamId: teamModel!.id,
                                    newCaptainId: playerModel.id,
                                  ),
                                );
                          }
                        },
                        playerModel: playerModel,
                      ),
                    );
                  })
              : CircularButtonInListItem(
                  buttonType: CircularButtonInListItem.authButton,
                  onTap: () {}),
          CircularButtonInListItem(
              buttonType: CircularButtonInListItem.kickButton,
              onTap: () {
                ProgramConstants.showBlurryBackground(
                  context: context,
                  child: KickModal(
                    onAccepted: () async {
                      bool result = await BilfootClient().kickPlayer(
                          teamId: teamModel!.id,
                          kickedPlayerId: playerModel.id);
                      Navigator.of(context).pop();

                      if (result) {
                        /* if (updateTeam != null) {
                          teamModel!.players.remove(playerModel);
                          updateTeam!(teamModel!);
                        }*/
                        Navigator.of(context).pop();
                      }
                    },
                    playerModel: playerModel,
                  ),
                );
              }),
          ...buttons
        ];
      }
    }

    return Row(
      children: buttons,
    );
  }
}
