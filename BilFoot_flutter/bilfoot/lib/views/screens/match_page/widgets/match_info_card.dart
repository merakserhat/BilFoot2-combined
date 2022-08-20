import 'package:bilfoot/views/themes/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../config/constants/program_constants.dart';
import '../../../../data/models/match_model.dart';

class MatchInfoCard extends StatelessWidget {
  const MatchInfoCard({Key? key, required this.matchModel}) : super(key: key);
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
    return Card(
      elevation: 2,
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
                    matchModel.date,
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
                              color: Colors.green,
                            ),
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
                      Text(
                        '${matchModel.people.length}/${matchModel.peopleLimit}',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: 14, color: _getColor()),
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
}
