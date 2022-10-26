import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/match_selector.dart';
import 'package:bilfoot/views/screens/new_announcement_page/widgets/team_selector.dart';
import 'package:bilfoot/views/widgets/toggle_switch_menu.dart';
import 'package:flutter/material.dart';

class TeamOrMatchToggle extends StatefulWidget {
  const TeamOrMatchToggle(
      {Key? key,
      required this.teams,
      required this.onSelectionChanged,
      required this.onToggleChanged,
      required this.mathces,
      required this.onSelectionChangedForMatch})
      : super(key: key);

  final List<TeamModel> teams;
  final List<MatchModel> mathces;
  final Function(TeamModel) onSelectionChanged;
  final Function(MatchModel) onSelectionChangedForMatch;
  final Function(bool) onToggleChanged;

  @override
  State<TeamOrMatchToggle> createState() => _TeamOrMatchToggleState();
}

class _TeamOrMatchToggleState extends State<TeamOrMatchToggle> {
  bool forMatch = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ToggleSwitchMenu(
                options: const ["For Match", "For Team"],
                onToggleChanged: (index, value) {
                  if (index == 0 && !forMatch) {
                    setState(() {
                      forMatch = true;
                      widget.onToggleChanged(forMatch); //for team
                    });
                  } else if (index != 0 && forMatch) {
                    setState(() {
                      forMatch = false;
                      widget.onToggleChanged(forMatch); //for team
                    });
                  }
                }),
          ),
          if (!forMatch) ...[
            const SizedBox.square(dimension: 15),
            TeamSelector(
                teams: widget.teams,
                onSelectionChanged: widget.onSelectionChanged)
          ],
          if (forMatch) ...[
            const SizedBox.square(dimension: 15),
            MatchSelector(
                matches: widget.mathces,
                onSelectionChanged: widget.onSelectionChangedForMatch)
          ],
        ],
      ),
    );
  }
}
