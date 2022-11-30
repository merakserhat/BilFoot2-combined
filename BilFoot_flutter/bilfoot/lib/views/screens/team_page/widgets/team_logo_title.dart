import 'package:auto_size_text/auto_size_text.dart';
import 'package:bilfoot/config/utils/hex_color.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:flutter/material.dart';

class TeamLogoTitle extends StatelessWidget {
  const TeamLogoTitle({Key? key, this.bigLogo = false, required this.teamModel})
      : super(key: key);

  final bool bigLogo;
  final TeamModel teamModel;

  @override
  Widget build(BuildContext context) {
    return bigLogo ? buildBiggerLogo(context) : buildSmallerLogo(context);
  }

  Widget buildSmallerLogo(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: HexColor(teamModel.mainColor),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              teamModel.shortName.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: HexColor(teamModel.accentColor)),
            ),
          ),
        ),
        const SizedBox.square(dimension: 5),
        Text(
          teamModel.name,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        )
      ],
    );
  }

  Widget buildBiggerLogo(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: HexColor(teamModel.mainColor),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              teamModel.shortName.toUpperCase(),
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: HexColor(teamModel.accentColor)),
            ),
          ),
        ),
        SizedBox(
            width: 80,
            child: AutoSizeText(
              teamModel.name,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              minFontSize: 9,
              softWrap: false,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            ))
      ],
    );
  }
}
