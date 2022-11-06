import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/announcements/player_announcement_model.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/widgets/match_component/match_comp_square.dart';
import 'package:bilfoot/views/widgets/modals/base_modal.dart';
import 'package:bilfoot/views/widgets/modals/captain_modal.dart';
import 'package:bilfoot/views/widgets/modals/quit_modal.dart';
import 'package:bilfoot/views/widgets/modals/validation_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlayerAnnouncementCard extends StatefulWidget {
  PlayerAnnouncementCard({Key? key, required this.playerAnnouncementModel})
      : super(key: key);

  final PlayerAnnouncementModel playerAnnouncementModel;

  @override
  State<PlayerAnnouncementCard> createState() => _PlayerAnnouncementCardState();
}

class _PlayerAnnouncementCardState extends State<PlayerAnnouncementCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 0, color: Colors.black12))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MatchComponentSquare(
                matchModel: widget.playerAnnouncementModel.match),
            const SizedBox.square(dimension: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.playerAnnouncementModel.announcer.fullName} ${MatchModel.formatDate(widget.playerAnnouncementModel.match.date)} tarihli maçı için adam arıyor.",
                    softWrap: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          children: widget.playerAnnouncementModel.positions
                              .map((e) => Text(
                                    "$e ",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ))
                              .toList()),
                      Row(
                        children: [
                          Text(
                            '${widget.playerAnnouncementModel.acceptedPlayers}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: _getColor()),
                          ),
                          Text(
                            '/${widget.playerAnnouncementModel.playerLimit}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        _getActions(),
      ]),
    );
  }

  Color _getColor() {
    if (widget.playerAnnouncementModel.acceptedPlayers ==
        widget.playerAnnouncementModel.playerLimit) {
      return const Color.fromARGB(255, 92, 6, 0);
    } else {
      return Colors.blueGrey[700] as Color;
    }
  }

  String _getValidationText() {
    return "${widget.playerAnnouncementModel.announcer.fullName}'ın maçına katılma istediği yollamak istiyor musunuz?";
  }

  Widget _getActions() {
    if (widget.playerAnnouncementModel.acceptedPlayers ==
        widget.playerAnnouncementModel.playerLimit) {
      return Center(
        child: Text(
          "Full",
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Theme.of(context).errorColor),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: ElevatedButton(
          onPressed: () {
            ProgramConstants.showBlurryBackground(
              context: context,
              child: ValidationModal(
                text: _getValidationText(),
                onAccepted: () async {
                  bool result = await BilfootClient()
                      .sendPlayerAnnouncementJoinRequest(
                          widget.playerAnnouncementModel.id);
                  Navigator.of(context).pop();

                  if (result) {
                    /* context.read<TeamBloc>().add(
                              TeamChangeCaptain(
                                teamId: teamModel!.id,
                                newCaptainId: playerModel.id,
                              ),
                            );*/
                  }
                },
              ),
            );
          },
          child: const Text("Actions")),
    );
  }
}
