import 'package:bilfoot/config/constants/program_constants.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${MatchModel.formatSquareMatchDate(matchModel.date)}\n${matchModel.hour}",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.black87,
              ),
        ),
        _buildBottomTitle(context),
      ],
    );
  }

  Widget _buildBottomTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
          child: Image.asset(
            "assets/images/pitch.png",
            color: const Color.fromARGB(255, 3, 88, 6),
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
        const SizedBox(
          width: 2,
        ),
        matchModel.isPitchApproved
            ? const Icon(
                Icons.check_circle_outline,
                color: const Color.fromARGB(255, 3, 88, 6),
                size: 14,
              )
            : const Icon(
                Icons.warning_amber,
                color: Colors.amber,
                size: 14,
              ),
      ],
    );
  }
}
