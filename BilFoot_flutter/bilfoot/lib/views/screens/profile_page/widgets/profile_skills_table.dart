import 'package:bilfoot/data/models/player_model.dart';
import 'package:flutter/material.dart';

class ProfileSkillsTable extends StatelessWidget {
  const ProfileSkillsTable({required this.playerModel, Key? key})
      : super(key: key);

  final PlayerModel playerModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                'Positions: ${playerModel.preferredPositions.toString().replaceAll("[", "").replaceAll("]", "")}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            const SizedBox.square(dimension: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                'Skills: ${playerModel.specialSkills.toString().replaceAll("[", "").replaceAll("]", "")}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
