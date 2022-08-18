import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/views/screens/match_page/match_detailed_page.dart';
import 'package:flutter/material.dart';

import '../../../themes/my_themes.dart';

class MatchListItem extends StatelessWidget {
  const MatchListItem({Key? key, required this.matchModel}) : super(key: key);
  final MatchModel matchModel;

  Color _getColor() {
    if (matchModel.people.length == matchModel.peopleLimit) {
      return Colors.red;
    } else if (matchModel.people.length >= matchModel.peopleLimit - 3) {
      return Colors.orange;
    } else {
      return MyThemes.darkTheme.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
<<<<<<< Updated upstream
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => MatchDetailedPage(match: matchModel),
        ));
      },
      child: Container(
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
=======
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => MatchDetailedPage(match: matchModel),
          ));
        },
        child: Card(
          elevation: 2,
          child: Container(
            height: 84,
            width: double.infinity,
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: ProgramConstants.getDefaultBoxShadow(context,
                  smallShadow: true),
              color: Colors.white,
>>>>>>> Stashed changes
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                            matchModel.date,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                          const Text(
                            " / ",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            matchModel.hour,
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColorDark),
                          ),
                        ],
                      ),
                      Text(
                        matchModel.creator.fullName,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 84,
                        width: 60,
                        child: FittedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 56,
                                child: Image.asset(
                                  "assets/images/pitch.png",
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                matchModel.pitch,
                                style: Theme.of(context).textTheme.headline3,
                              )
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '${matchModel.people.length}/${matchModel.peopleLimit}',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: 16, color: _getColor()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
<<<<<<< Updated upstream
          ],
        ),
      ),
    );
=======
          ),
        ));
>>>>>>> Stashed changes
  }
}
