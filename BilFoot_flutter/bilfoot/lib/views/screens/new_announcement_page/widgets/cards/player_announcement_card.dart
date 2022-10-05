import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/views/widgets/match_component/match_comp_square.dart';
import 'package:bilfoot/views/widgets/match_component/match_component_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../data/models/program.dart';

class PlayerAnnouncementCard extends StatefulWidget {
  PlayerAnnouncementCard({
    Key? key,
    /*required this.matchModel*/
  }) : super(key: key);

  final List<String> positions = ["GK", "ST"];
  final MatchModel matchModel = MatchModel(
      id: "12s",
      date: DateTime.now(),
      hour: "9-10",
      pitch: "Merkez 1",
      isPitchApproved: false,
      creator: Program.program.dummyPlayer2,
      players: [Program.program.dummyPlayer2, Program.program.dummyPlayer1],
      authPlayers: [Program.program.dummyPlayer2.id],
      showOnTable: true,
      peopleLimit: 14);

  Color _getColor() {
    if (matchModel.players.length == matchModel.peopleLimit) {
      return Color.fromARGB(255, 92, 6, 0);
    } else {
      return Colors.blueGrey[700] as Color;
    }
  }

  @override
  State<PlayerAnnouncementCard> createState() => _PlayerAnnouncementCardState();
}

class _PlayerAnnouncementCardState extends State<PlayerAnnouncementCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: MatchComponentSquare(matchModel: widget.matchModel),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.matchModel.creator.fullName} Takımı fıqejpwfopqw için maç arıyor",
                    softWrap: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          children: widget.positions
                              .map((e) => Text(
                                    "$e ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                              .toList()),
                      Row(
                        children: [
                          Text(
                            '${widget.matchModel.players.length}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: widget._getColor()),
                          ),
                          Text(
                            '/${widget.matchModel.peopleLimit}',
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
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: ElevatedButton(onPressed: () {}, child: Text("Actions")),
        )
      ]),
    );
  }
}
