import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/screens/defining_page/bloc/defining_bloc.dart';
import 'package:bilfoot/views/screens/defining_page/defining_page.dart';
import 'package:bilfoot/views/screens/defining_page/skill_selection_page.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:bilfoot/views/widgets/page_title.dart';
import 'package:bilfoot/views/widgets/position_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PositionSelectionPage extends StatefulWidget {
  const PositionSelectionPage({Key? key, required this.changeDefining})
      : super(key: key);

  final Function(int) changeDefining;

  @override
  State<PositionSelectionPage> createState() => _PositionSelectionPageState();
}

class _PositionSelectionPageState extends State<PositionSelectionPage> {
  List<String> positions = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const PageTitle(title: "Select your favorite positions"),
        const SizedBox.square(dimension: 20),
        PositionSelector(onSelectionChange: (List<String> positions) {
          context
              .read<DefiningBloc>()
              .add(SelectedPositionsChanged(positions: positions));
          setState(() {
            this.positions = positions;
          });
        }),
        const SizedBox.square(dimension: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              widget.changeDefining(DefiningPage.skillSelection);
            },
            child: const Text("Save"),
          ),
        ),
        const SizedBox.square(dimension: 20),
      ],
    );
  }
}
