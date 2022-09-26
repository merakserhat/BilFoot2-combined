import 'package:bilfoot/data/models/match_model.dart';
import '../../../themes/my_themes.dart';
import 'match_list_item.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:flutter/material.dart';

class MatchInfo extends StatelessWidget {
  const MatchInfo({Key? key, required this.matchModel}) : super(key: key);

  final MatchModel matchModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  matchModel.hour,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                const Text(" / "),
                Text(
                  MatchModel.formatDate(matchModel.date),
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.black87),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Image.asset(
                        "assets/images/pitch.png",
                        color: Color.fromARGB(255, 3, 88, 6),
                      ),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Text(
                      matchModel.pitch,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    matchModel.isPitchApproved
                        ? const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 16,
                          )
                        : const Icon(
                            Icons.warning_amber,
                            color: Colors.amber,
                            size: 16,
                          ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${matchModel.players.length}',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: _getColor()),
                    ),
                    Text(
                      '/${matchModel.peopleLimit}',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),

      /*Column(
        children: [
          Text(
            '${MatchModel.formatDate(matchModel.date)} ${matchModel.hour}',
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            matchModel.pitch,
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),*/
    );
  }

  Color _getColor() {
    if (matchModel.players.length == matchModel.peopleLimit) {
      return Color.fromARGB(255, 92, 6, 0);
    } else {
      return Colors.blueGrey[500] as Color;
    }
  }
}
