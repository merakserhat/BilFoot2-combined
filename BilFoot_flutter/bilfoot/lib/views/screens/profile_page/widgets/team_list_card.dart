import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/views/screens/profile_page/widgets/team_list_item.dart';
import 'package:bilfoot/views/screens/team_page/bloc/team_bloc.dart';
import 'package:bilfoot/views/screens/team_page/edit_panel/bloc/team_edit_bloc.dart';
import 'package:bilfoot/views/screens/team_page/edit_panel/team_edit_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamListCard extends StatefulWidget {
  const TeamListCard(
      {Key? key, required this.playerModel, this.isStrangerView = false})
      : super(key: key);

  final PlayerModel playerModel;
  final bool isStrangerView;

  @override
  State<TeamListCard> createState() => _TeamListCardState();
}

class _TeamListCardState extends State<TeamListCard> {
  @override
  void initState() {
    super.initState();

    context.read<TeamBloc>().add(TeamGetTeams());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Teams",
              style: Theme.of(context).textTheme.headline5,
            ),
            widget.isStrangerView
                ? Container()
                : _buildCreateTeamButton(context)
          ],
        ),
        const SizedBox.square(dimension: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 200),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: ProgramConstants.getDefaultBoxShadow(context),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                children: widget.playerModel.teams
                    .map((e) => TeamListItem(teamId: e))
                    .toList(),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCreateTeamButton(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      shadowColor: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          ProgramConstants.showBlurryBackground(
              context: context,
              child: BlocProvider(
                create: (context) => TeamEditBloc(),
                child: const TeamEditPanel(),
              ));
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
