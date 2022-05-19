import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/config/utils/hex_color.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:flutter/material.dart';

class TeamListItem extends StatelessWidget {
  const TeamListItem({Key? key, required this.teamModel}) : super(key: key);

  final TeamModel teamModel;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _buildTeamNameAndLogo(context),
          Text('${teamModel.players.length} players')
        ],
      ),
    );
  }

  Widget _buildTeamNameAndLogo(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: HexColor(teamModel.mainColor),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              teamModel.shortName.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: HexColor(teamModel.accentColor)),
            ),
          ),
        ),
        const SizedBox.square(dimension: 5),
        Text(
          teamModel.name,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        )
      ],
    );
  }
}
