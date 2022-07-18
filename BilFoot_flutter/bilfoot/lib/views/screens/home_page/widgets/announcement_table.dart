import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/announcements/player_announcement_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/home_page/widgets/announcement_list_item.dart';
import 'package:bilfoot/views/widgets/toggle_switch_menu.dart';
import 'package:flutter/material.dart';

class AnnouncementTable extends StatefulWidget {
  const AnnouncementTable({Key? key}) : super(key: key);

  @override
  State<AnnouncementTable> createState() => _AnnouncementTableState();
}

class _AnnouncementTableState extends State<AnnouncementTable> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ToggleSwitchMenu(
            options: const ["Player", "Opponent", "Match"],
            onToggleChanged: (index, value) {
              //TODO: change index
            },
          ),
          const SizedBox.square(dimension: 10),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: ProgramConstants.getDefaultBoxShadow(context),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container();
                  /* return AnnouncementListItem(
                    playerAnnouncement: PlayerAnnouncementModel(
                        announcer: Program.program.dummyPlayer1,
                        date: DateTime.now(),
                        positions: ["GK", "ST"],
                        forTeam: true,
                        teamModel: TeamModel(
                            name: "Cu S.K",
                            shortName: "CU",
                            mainColor: "#347282",
                            accentColor: "#f6f2c2",
                            creator: Program.program.dummyPlayer1,
                            captain: Program.program.dummyPlayer1,
                            players: [])),
                  ); //TODO: buraya list item

                  */
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
