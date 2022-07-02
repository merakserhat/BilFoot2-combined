import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/screens/defining_page/skill_selection_page.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:bilfoot/views/widgets/page_title.dart';
import 'package:bilfoot/views/widgets/position_selector.dart';
import 'package:flutter/material.dart';

class PositionSelectionPage extends StatefulWidget {
  const PositionSelectionPage({Key? key, this.onCallback}) : super(key: key);

  final Function(List<String> positions)? onCallback;

  @override
  State<PositionSelectionPage> createState() => _PositionSelectionPageState();
}

class _PositionSelectionPageState extends State<PositionSelectionPage> {
  List<String> positions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Padding(
        padding: ProgramConstants.pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const PageTitle(title: "Select your favorite positions"),
            const SizedBox.square(dimension: 20),
            PositionSelector(onSelectionChange: (List<String> positions) {
              setState(() {
                this.positions = positions;
              });
            }),
            const SizedBox.square(dimension: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (widget.onCallback != null) {
                    widget.onCallback!(positions);
                  }
                },
                child: const Text("Save"),
              ),
            ),
            const SizedBox.square(dimension: 20),
          ],
        ),
      ),
    );
  }
}
