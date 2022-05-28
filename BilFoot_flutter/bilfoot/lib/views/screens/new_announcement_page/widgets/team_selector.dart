import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/team_page/widgets/team_logo_title.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TeamSelector extends StatefulWidget {
  const TeamSelector(
      {Key? key, required this.teams, required this.onSelectionChanged})
      : super(key: key);
  final List<TeamModel> teams;
  final Function(TeamModel) onSelectionChanged;

  @override
  State<TeamSelector> createState() => _TeamSelectorState();
}

class _TeamSelectorState extends State<TeamSelector> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 200.0,
          onPageChanged: (index, _) {
            widget.onSelectionChanged(widget.teams[index]);
          }),
      items: widget.teams.map((team) {
        return TeamLogoTitle(teamModel: team);
      }).toList(),
    );
  }
}
