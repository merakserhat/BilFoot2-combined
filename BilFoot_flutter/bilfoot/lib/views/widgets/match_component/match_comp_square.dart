import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../data/models/match_model.dart';

class MatchComponentSquare extends StatelessWidget {
  const MatchComponentSquare({Key? key, required this.matchModel})
      : super(key: key);
  final MatchModel matchModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MatchModel.formatDate(matchModel.date),
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black87),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  matchModel.hour,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black87,
                      ),
                ),
              ],
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
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    matchModel.isPitchApproved
                        ? const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 14,
                          )
                        : const Icon(
                            Icons.warning_amber,
                            color: Colors.amber,
                            size: 14,
                          ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
