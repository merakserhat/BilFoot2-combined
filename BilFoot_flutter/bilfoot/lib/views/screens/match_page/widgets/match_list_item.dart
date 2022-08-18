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
        ));
  }
}
