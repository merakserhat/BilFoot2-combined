import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/screens/team_page/team_page.dart';
import 'package:bilfoot/views/screens/team_page/widgets/team_logo_title.dart';
import 'package:flutter/material.dart';

class TeamListItem extends StatefulWidget {
  const TeamListItem(
      {Key? key, required this.teamId, required this.refreshTeamListCard})
      : super(key: key);

  final String teamId;
  final VoidCallback refreshTeamListCard;
  @override
  State<TeamListItem> createState() => _TeamListItemState();
}

class _TeamListItemState extends State<TeamListItem> {
  TeamModel? teamModel;

  @override
  void initState() {
    super.initState();
    _getTeamModel();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (teamModel != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => TeamPage(
                    team: teamModel!,
                    refreshTeamListCard: widget.refreshTeamListCard,
                  )));
        }
      },
      child: Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: ProgramConstants.getDefaultBoxShadow(context),
        ),
        child: teamModel == null
            ? const Center(
                child: const CircularProgressIndicator(),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TeamLogoTitle(teamModel: teamModel!),
                  Text('${teamModel!.players.length} players')
                ],
              ),
      ),
    );
  }

  void _getTeamModel() async {
    teamModel = await BilfootClient().getTeamModel(id: widget.teamId);
    setState(() {});
  }
}
