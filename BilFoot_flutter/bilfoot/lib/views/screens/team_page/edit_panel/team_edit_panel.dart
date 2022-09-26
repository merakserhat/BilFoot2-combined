import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/config/utils/hex_color.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/screens/team_page/bloc/team_bloc.dart';
import 'package:bilfoot/views/screens/team_page/edit_panel/bloc/team_edit_bloc.dart';
import 'package:bilfoot/views/screens/team_page/widgets/team_logo_title.dart';
import 'package:bilfoot/views/widgets/panel_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TeamEditPanel extends StatefulWidget {
  const TeamEditPanel({Key? key, this.teamModel}) : super(key: key);

  final TeamModel? teamModel;

  @override
  State<TeamEditPanel> createState() => _TeamEditPanelState();
}

class _TeamEditPanelState extends State<TeamEditPanel> {
  @override
  void initState() {
    super.initState();

    if (widget.teamModel != null) {
      context
          .read<TeamEditBloc>()
          .add(TeamEditInitializeExistingTeam(widget.teamModel!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PanelBase(
      child: BlocBuilder<TeamEditBloc, TeamEditState>(
        builder: (context, state) {
          return Column(
            children: [
              Text(state.isEditing ? "Edit Team" : "Create Team",
                  style: Theme.of(context).textTheme.headline4),
              const SizedBox.square(dimension: 20),
              if (state.shortName.isNotEmpty && state.name.isNotEmpty)
                FittedBox(
                  child: TeamLogoTitle(
                    bigLogo: true,
                    teamModel: TeamModel(
                        id: "",
                        name: state.name,
                        shortName: state.shortName,
                        mainColor: state.mainColor,
                        accentColor: state.accentColor,
                        players: []),
                  ),
                ),

              //edit part
              _buildEditionPart(state),
              const SizedBox.square(dimension: 20),
              state.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        context.read<TeamEditBloc>().add(
                            TeamEditSaveButtonClicked(context.read<TeamBloc>(),
                                () => Navigator.of(context).pop()));
                      },
                      child: Text(state.isEditing ? "Edit" : "Create"))
            ],
          );
        },
      ),
    );
  }

  Widget _buildEditionPart(TeamEditState state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Team Name: ", style: Theme.of(context).textTheme.bodyText2),
            const SizedBox.square(dimension: 20),
            Expanded(
              child: TextFormField(
                initialValue: widget.teamModel?.name,
                onChanged: (String value) {
                  context.read<TeamEditBloc>().add(TeamEditNameChanged(value));
                },
              ),
            ),
          ],
        ),
        const SizedBox.square(dimension: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Short Name: ", style: Theme.of(context).textTheme.bodyText2),
            const SizedBox.square(dimension: 20),
            Expanded(
              child: TextFormField(
                maxLength: 2,
                initialValue: widget.teamModel?.shortName,
                onChanged: (String value) {
                  context
                      .read<TeamEditBloc>()
                      .add(TeamEditShortNameChanged(value));
                },
              ),
            ),
          ],
        ),
        const SizedBox.square(dimension: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Main Color: ", style: Theme.of(context).textTheme.bodyText2),
            GestureDetector(
              onTap: () {
                _openColorPicker(
                    HexColor(state.mainColor),
                    (Color color) => context.read<TeamEditBloc>().add(
                          TeamEditMainColorChanged(
                              color.toString().substring(10, 16).toString()),
                        ));
              },
              child: Container(
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: HexColor(state.mainColor),
                  boxShadow: ProgramConstants.getDefaultBoxShadow(
                    context,
                    smallShadow: true,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox.square(dimension: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Accent Color: ",
                style: Theme.of(context).textTheme.bodyText2),
            GestureDetector(
              onTap: () {
                _openColorPicker(
                    HexColor(state.accentColor),
                    (Color color) => context.read<TeamEditBloc>().add(
                          TeamEditAccentColorChanged(
                              color.toString().substring(10, 16).toString()),
                        ));
              },
              child: Container(
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: HexColor(state.accentColor),
                  boxShadow: ProgramConstants.getDefaultBoxShadow(
                    context,
                    smallShadow: true,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  void _openColorPicker(Color currentColor, Function(Color) changeColor) {
    Color color = currentColor;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (newColor) => color = newColor,
              paletteType: PaletteType.hsv,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Select'),
              onPressed: () {
                changeColor(color);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
