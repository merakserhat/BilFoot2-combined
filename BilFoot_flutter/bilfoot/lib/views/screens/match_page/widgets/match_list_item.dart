import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/views/screens/match_page/match_detailed_page.dart';
import 'package:bilfoot/views/screens/match_page/widgets/match_info_card.dart';
import 'package:flutter/material.dart';

class MatchListItem extends StatelessWidget {
  const MatchListItem({Key? key, required this.matchModel}) : super(key: key);
  final MatchModel matchModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => MatchDetailedPage(match: matchModel),
          ));
        },
        child: MatchInfoCard(
          matchModel: matchModel,
        )
        /*Container(
        height: 80,
        width: double.infinity,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow:
              ProgramConstants.getDefaultBoxShadow(context, smallShadow: true),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                matchModel.creator.fullName,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(matchModel.date),
                      const SizedBox.square(dimension: 20),
                      Text(matchModel.hour),
                    ],
                  ),
                  Row(
                    children: [
                      Text(matchModel.pitch),
                      const SizedBox.square(dimension: 20),
                      Text(
                          '${matchModel.people.length}/${matchModel.peopleLimit}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),*/
        );
  }
}
