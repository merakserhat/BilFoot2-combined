import 'package:bilfoot/data/models/match_model.dart';
import 'package:flutter/material.dart';

class MatchInfo extends StatelessWidget {
  const MatchInfo({Key? key, required this.matchModel}) : super(key: key);

  final MatchModel matchModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            '${MatchModel.formatDate(matchModel.date)} ${matchModel.hour}',
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            matchModel.pitch,
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }
}
