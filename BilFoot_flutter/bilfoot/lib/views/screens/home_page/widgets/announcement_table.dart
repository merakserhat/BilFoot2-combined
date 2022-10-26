import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/announcements/player_announcement_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/home_page/widgets/announcement_list_item.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/cards/player_announcement_card.dart';
import 'package:bilfoot/views/widgets/toggle_switch_menu.dart';
import 'package:flutter/material.dart';

class AnnouncementList extends StatefulWidget {
  const AnnouncementList({Key? key}) : super(key: key);

  @override
  State<AnnouncementList> createState() => _AnnouncementListState();
}

class _AnnouncementListState extends State<AnnouncementList> {
  @override
  Widget build(BuildContext context) {
    return Center(child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return PlayerAnnouncementCard(playerAnnouncementModel: Program.program.dummyData.dummyPlayerAnnouncement,);
        }
    ),);
  }
}
