import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/screens/profile_page/profile_page.dart';
import 'package:bilfoot/views/screens/team_page/widgets/circular_button_in_list_item.dart';
import 'package:bilfoot/views/widgets/panel_base.dart';
import 'package:flutter/material.dart';

class AddMemberPanel extends StatefulWidget {
  const AddMemberPanel({Key? key, this.teamModel, this.matchModel})
      : super(key: key);

  final TeamModel? teamModel;
  final MatchModel? matchModel;

  @override
  State<AddMemberPanel> createState() => _AddMemberPanelState();
}

class _AddMemberPanelState extends State<AddMemberPanel> {
  List<PlayerModel> foundPlayers = [];

  @override
  Widget build(BuildContext context) {
    return PanelBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            "Add Player",
            style: Theme.of(context).textTheme.headline5,
          )),
          const SizedBox.square(dimension: 20),
          TextFormField(
            decoration: const InputDecoration(hintText: "Player Name"),
            onChanged: (value) async {
              if (value.isNotEmpty) {
                foundPlayers =
                    await BilfootClient().searchPlayers(value: value);
                setState(() {});
              } else {
                setState(() {
                  foundPlayers = [];
                });
              }
            },
          ),
          const SizedBox.square(dimension: 15),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: ProgramConstants.getDefaultBoxShadow(context),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                  children: foundPlayers
                      .map((player) => AddPlayerListItem(
                            playerModel: player,
                            teamModel: widget.teamModel,
                            matchModel: widget.matchModel,
                            key: ValueKey(player.id),
                          ))
                      .toList()),
            ),
          )
        ],
      ),
    );
  }
}

class AddPlayerListItem extends StatefulWidget {
  const AddPlayerListItem({
    required this.playerModel,
    this.invitationAlreadySent = false,
    Key? key,
    this.teamModel,
    this.matchModel,
  }) : super(key: key);

  final PlayerModel playerModel;
  final TeamModel? teamModel;
  final MatchModel? matchModel;
  final bool invitationAlreadySent;

  @override
  State<AddPlayerListItem> createState() => _AddPlayerListItemState();
}

class _AddPlayerListItemState extends State<AddPlayerListItem> {
  late bool invitationSent;
  bool invitationStatusLoading = true;

  @override
  void initState() {
    super.initState();
    invitationSent = widget.invitationAlreadySent;
    _getInvitationStatus();

    print("match model");
    print(widget.matchModel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow:
            ProgramConstants.getDefaultBoxShadow(context, smallShadow: true),
        color: Colors.white,
      ),
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProfilePage(
                  playerModel: widget.playerModel,
                ),
              ),
            );
          },
          child: Container(
            height: 40,
            width: double.infinity,
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.playerModel.fullName),
                invitationStatusLoading
                    ? const SizedBox(
                        width: 34,
                        height: 34,
                        child: CircularProgressIndicator())
                    : _buildInvitationAction(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInvitationAction() {
    if (invitationSent) {
      return Container(
          width: 26,
          height: 26,
          margin: const EdgeInsets.all(4),
          child: const Icon(
            Icons.check_outlined,
            color: Colors.green,
            size: 20,
          ));
    }
    return CircularButtonInListItem(
      buttonType: CircularButtonInListItem.inviteButton,
      onTap: () async {
        setState(() {
          invitationStatusLoading = true;
        });

        if (widget.teamModel != null) {
          await BilfootClient().inviteToTeam(
              teamId: widget.teamModel!.id, toId: widget.playerModel.id);
        } else if (widget.matchModel != null) {
          await BilfootClient().inviteToMatch(
              matchId: widget.matchModel!.id, toId: widget.playerModel.id);
        }

        setState(() {
          invitationStatusLoading = false;

          invitationSent = true;
        });
      },
    );
  }

  void _getInvitationStatus() async {
    if (widget.teamModel != null) {
      invitationSent = await BilfootClient().getTeamInvitation(
          fromId: Program.program.user!.id,
          toId: widget.playerModel.id,
          teamId: widget.teamModel!.id);
    } else if (widget.matchModel != null) {
      invitationSent = await BilfootClient().getMatchInvitation(
          fromId: Program.program.user!.id,
          toId: widget.playerModel.id,
          matchId: widget.matchModel!.id);

      print("invitationSent");
      print(invitationSent);
    }

    setState(() {
      invitationStatusLoading = false;
    });
  }
}
