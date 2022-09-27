import 'package:bilfoot/data/models/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MatchComponentLine extends StatelessWidget {
  const MatchComponentLine({Key? key, required this.matchModel})
      : super(key: key);
  final MatchModel matchModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  MatchModel.formatDate(matchModel.date),
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black87),
                ),
                const Text(", "),
                Text(
                  matchModel.hour,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black87),
                ),
              ],
            ),
            Text("  /  "),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 18,
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
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  width: 1,
                ),
                Column(
                  children: [
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
                    SizedBox(
                      height: 2,
                    )
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
