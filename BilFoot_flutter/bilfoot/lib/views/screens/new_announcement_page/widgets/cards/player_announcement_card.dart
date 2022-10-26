import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/views/widgets/match_component/match_comp_square.dart';
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




  @override
  State<PlayerAnnouncementCard> createState() => _PlayerAnnouncementCardState();
}

class _PlayerAnnouncementCardState extends State<PlayerAnnouncementCard> {

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: const BoxDecoration(border: Border(top: BorderSide(width: 0,color: Colors.black12))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MatchComponentSquare(matchModel: Program.program.dummyData.dummyMatch1),
            const SizedBox.square(dimension: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${Program.program.dummyData.dummyMatch1.creator.fullName} Takımı fıqejpwfopqw için maç arıyor",
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
                                        const TextStyle(fontWeight: FontWeight.bold),
                                  ))
                              .toList()),
                      Row(
                        children: [
                          Text(
                            '${Program.program.dummyData.dummyMatch1.players.length}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: _getColor()),
                          ),
                          Text(
                            '/${Program.program.dummyData.dummyMatch1.peopleLimit}',
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
          child: ElevatedButton(onPressed: () {}, child: const Text("Actions")),
        )
      ]),
    );
  }

  Color _getColor() {
    if (Program.program.dummyData.dummyMatch1.players.length == Program.program.dummyData.dummyMatch1.peopleLimit) {
      return const Color.fromARGB(255, 92, 6, 0);
    } else {
      return Colors.blueGrey[700] as Color;
    }
  }
}
