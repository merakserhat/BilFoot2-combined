import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/views/screens/match_page/match_detailed_page.dart';
import 'package:bilfoot/views/themes/my_themes.dart';
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
      child: Container(
        height: 84,
        width: double.infinity,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    matchModel.hour,
                    textAlign: TextAlign.end,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.black87),
                  ),
                  Text(
                    MatchModel.formatDate(matchModel.date),
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.black87),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
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
                          const SizedBox(
                            width: 1,
                          ),
                          SizedBox(
                            height: 20,
                            child: Text(
                              matchModel.pitch,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${matchModel.players.length}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: _getColor()),
                          ),
                          Text(
                            '/${matchModel.peopleLimit}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor() {
    if (matchModel.players.length == matchModel.peopleLimit) {
      return Color.fromARGB(255, 92, 6, 0);
    } else {
      return Colors.blueGrey[700] as Color;
    }
  }
}
