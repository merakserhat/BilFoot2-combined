import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/team_page/team_page.dart';
import 'package:bilfoot/views/screens/team_page/widgets/team_logo_title.dart';
import 'package:flutter/material.dart';

class TeamListItem extends StatelessWidget {
  const TeamListItem({Key? key, required this.teamModel}) : super(key: key);

  final TeamModel teamModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => TeamPage(team: teamModel)));
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TeamLogoTitle(teamModel: teamModel),
            Text('${teamModel.players.length} players')
          ],
        ),
      ),
    );
  }
}
