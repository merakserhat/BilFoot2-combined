import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/announcements/match_announcement_model.dart';
import 'package:bilfoot/data/models/announcements/opponent_announcement_model.dart';
import 'package:bilfoot/data/models/announcements/player_announcement_model.dart';
import 'package:flutter/material.dart';

class AnnouncementListItem extends StatefulWidget {
  AnnouncementListItem(
      {Key? key,
      this.invited = false,
      this.playerAnnouncement,
      this.opponentAnnouncement,
      this.matchAnnouncement})
      : super(key: key) {
    assert(playerAnnouncement != null ||
        opponentAnnouncement != null ||
        matchAnnouncement != null);
  }

  final bool invited;
  final PlayerAnnouncementModel? playerAnnouncement;
  final OpponentAnnouncementModel? opponentAnnouncement;
  final MatchAnnouncementModel? matchAnnouncement;

  @override
  State<AnnouncementListItem> createState() => _AnnouncementItemState();
}

class _AnnouncementItemState extends State<AnnouncementListItem> {
  late bool invited;

  @override
  void initState() {
    super.initState();
    invited = widget.invited;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow:
            ProgramConstants.getDefaultBoxShadow(context, smallShadow: true),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(4),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ), //removes outlined when activated
        child: ExpansionTile(
          title: Text(
            _getTitleText(),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          leading: _getLeadingButton(),
          tilePadding: const EdgeInsets.symmetric(horizontal: 4),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 4),
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox.square(dimension: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Message"),
                  ),
                ),
                const SizedBox.square(dimension: 10),
                invited
                    ? const Expanded(
                        child: Text(
                        "Invited",
                        textAlign: TextAlign.center,
                      ))
                    : Expanded(
                        child: ElevatedButton(
                        onPressed: () {
                          //TODO: invite
                          setState(() {
                            invited = true;
                          });
                        },
                        child: const Text("Invite"),
                      )),
                const SizedBox.square(dimension: 5),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _getTitleText() {
    if (widget.playerAnnouncement != null) {
      return '${widget.playerAnnouncement!.announcer.fullName} is looking for ${widget.playerAnnouncement!.positions.toString().substring(1, widget.playerAnnouncement!.positions.toString().length - 1)}.';
    } else if (widget.opponentAnnouncement != null) {
      return '${widget.opponentAnnouncement!.announcer.fullName}\'s team ${widget.opponentAnnouncement!.teamModel.name} is looking for an opponent to play.';
    } else {
      return '${widget.matchAnnouncement!.announcer.fullName} is looking for a match to play.';
    }
  }

  Widget _getLeadingButton() {
    // if (widget.opponentAnnouncement != null ||
    //     (widget.playerAnnouncement != null &&
    //         widget.playerAnnouncement!.forTeam)) {
    //   return Container(
    //     margin: const EdgeInsets.only(right: 5),
    //     child: CircularButtonInListItem(
    //       buttonType: CircularButtonInListItem.teamButton,
    //       onTap: () {
    //         //TODO: Team
    //       },
    //     ),
    //   );
    // } else {
    //   return CircularButtonInListItem(
    //     buttonType: CircularButtonInListItem.profileButton,
    //     onTap: () {
    //       //TODO: Profile
    //     },
    //   );
    // }

    return Container();
  }
}
