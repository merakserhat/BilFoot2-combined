import 'package:bilfoot/data/models/match_model.dart';
import "package:flutter/material.dart";

class MatchLogo extends StatelessWidget {
  const MatchLogo({Key? key, required this.matchModel}) : super(key: key);

  final MatchModel matchModel;
  final double ballSize = 60;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: ballSize,
              height: ballSize,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black),
              child: Center(
                child: Text(
                  MatchModel.formatDate(matchModel.date),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
            SizedBox(
              width: ballSize,
              height: ballSize,
              child: Image.asset(
                "assets/images/logo_huge.png",
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            Positioned(
              child: Text(
                matchModel.pitch,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.green),
              ),
              right: 0,
              bottom: 0,
            )
          ],
        ),
        const SizedBox.square(dimension: 8),
        Text(matchModel.hour, style: Theme.of(context).textTheme.bodyText2),
      ],
    );
  }
}
