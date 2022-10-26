import 'package:bilfoot/config/utils/dummy_data.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/views/screens/team_page/widgets/team_logo_title.dart';
import 'package:bilfoot/views/widgets/match_component/match_comp_square.dart';
import 'package:bilfoot/views/widgets/match_component/match_component_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../data/models/program.dart';

class OpponentAnnouncementCard extends StatefulWidget {
  OpponentAnnouncementCard({
    Key? key,
    /*required this.matchModel*/
  }) : super(key: key);

  final List<String> positions = ["GK", "ST"];
  final matchModel = Program.program.dummyData.dummyMatch1;

  Color _getColor() {
    if (Program.program.dummyData.dummyMatch1.players.length ==
        Program.program.dummyData.dummyMatch1.peopleLimit) {
      return const Color.fromARGB(255, 92, 6, 0);
    } else {
      return Colors.blueGrey[700] as Color;
    }
  }

  @override
  State<OpponentAnnouncementCard> createState() =>
      _OpponentAnnouncementCardState();
}

class _OpponentAnnouncementCardState extends State<OpponentAnnouncementCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: TeamLogoTitle(
                  teamModel: Program.program.dummyData.dummyTeam1,
                  bigLogo: true),
            ),
            const SizedBox.square(
              dimension: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.matchModel.creator.fullName} Takımı fıqejpwfopqw için maç arıyor",
                    softWrap: true,
                  ),
                  MatchComponentLine(matchModel: widget.matchModel)
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: ElevatedButton(
              onPressed: () {},
              child: const Text("Actions"),
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(252, double.infinity))),
        )
      ]),
    );
  }
}
