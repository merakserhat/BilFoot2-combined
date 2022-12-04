import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/announcements/opponent_announcement_model.dart';
import 'package:bilfoot/data/models/announcements/player_announcement_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/cards/opponent_announcement_card.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/cards/player_announcement_card.dart';
import 'package:bilfoot/views/widgets/toggle_switch_menu.dart';
import 'package:flutter/material.dart';

class AnnouncementList extends StatefulWidget {
  const AnnouncementList(
      {Key? key,
      this.opponentAnnouncementModels,
      this.playerAnnouncementModels})
      : super(key: key);

  final List<PlayerAnnouncementModel>? playerAnnouncementModels;
  final List<OpponentAnnouncementModel>? opponentAnnouncementModels;

  @override
  State<AnnouncementList> createState() => _AnnouncementListState();
}

class _AnnouncementListState extends State<AnnouncementList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _getListSize(),
          itemBuilder: (BuildContext context, int index) {
            return _getComponent(index);
          }),
    );
  }

  int _getListSize() {
    if (widget.playerAnnouncementModels != null) {
      return widget.playerAnnouncementModels!.length;
    } else if (widget.opponentAnnouncementModels != null) {
      return widget.opponentAnnouncementModels!.length;
    } else {
      return 0;
    }
  }

  Widget _getComponent(int index) {
    if (widget.playerAnnouncementModels != null) {
      return PlayerAnnouncementCard(
        playerAnnouncementModel: widget.playerAnnouncementModels![index],
      );
    } else if (widget.opponentAnnouncementModels != null) {
      return OpponentAnnouncementCard(
        opponentAnnouncementModel: widget.opponentAnnouncementModels![index],
      );
    } else {
      return Container();
    }
  }
}
