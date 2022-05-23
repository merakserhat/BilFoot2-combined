import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/views/screens/team_page/widgets/circular_button_in_list_item.dart';
import 'package:flutter/material.dart';

class TeamAddMemberPanel extends StatefulWidget {
  const TeamAddMemberPanel({Key? key}) : super(key: key);

  @override
  State<TeamAddMemberPanel> createState() => _TeamAddMemberPanelState();
}

class _TeamAddMemberPanelState extends State<TeamAddMemberPanel> {
  List<PlayerModel> foundPlayers = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
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
                      decoration:
                          const InputDecoration(hintText: "Player Name"),
                      onChanged: (value) {
                        //TODO: get user data from database
                      },
                    ),
                    const SizedBox.square(dimension: 15),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow:
                            ProgramConstants.getDefaultBoxShadow(context),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AddPlayerListItem(
                              playerModel: Program.program.dummyPlayer1,
                            ),
                            AddPlayerListItem(
                              playerModel: Program.program.dummyPlayer1,
                            ),
                            AddPlayerListItem(
                              playerModel: Program.program.dummyPlayer1,
                            ),
                            AddPlayerListItem(
                              playerModel: Program.program.dummyPlayer1,
                            ),
                            AddPlayerListItem(
                              playerModel: Program.program.dummyPlayer1,
                            ),
                            AddPlayerListItem(
                              playerModel: Program.program.dummyPlayer1,
                            ),
                            AddPlayerListItem(
                              playerModel: Program.program.dummyPlayer1,
                            ),
                            AddPlayerListItem(
                              playerModel: Program.program.dummyPlayer1,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AddPlayerListItem extends StatefulWidget {
  const AddPlayerListItem(
      {required this.playerModel, this.invitationAlreadySent = false, Key? key})
      : super(key: key);

  final PlayerModel playerModel;
  final bool invitationAlreadySent;

  @override
  State<AddPlayerListItem> createState() => _AddPlayerListItemState();
}

class _AddPlayerListItemState extends State<AddPlayerListItem> {
  late bool invitationSent;

  @override
  void initState() {
    super.initState();
    invitationSent = widget.invitationAlreadySent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        boxShadow:
            ProgramConstants.getDefaultBoxShadow(context, smallShadow: true),
        borderRadius: BorderRadius.circular(3),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.playerModel.fullName),
          FittedBox(
              child: Row(
            children: [
              CircularButtonInListItem(
                buttonType: CircularButtonInListItem.profileButton,
                onTap: () {
                  //TODO: profile
                },
              ),
              invitationSent
                  ? Container(
                      width: 26,
                      height: 26,
                      margin: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.check_outlined,
                        color: Colors.green,
                        size: 20,
                      ))
                  : CircularButtonInListItem(
                      buttonType: CircularButtonInListItem.inviteButton,
                      onTap: () {
                        //TODO: invite
                        setState(() {
                          invitationSent = true;
                        });
                      },
                    )
            ],
          )),
        ],
      ),
    );
  }
}
