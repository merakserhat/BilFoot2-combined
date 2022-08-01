import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/screens/defining_page/position_selection_page.dart';
import 'package:bilfoot/views/screens/defining_page/skill_selection_page.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:flutter/material.dart';

class DefiningPage extends StatefulWidget {
  static const int positionSelection = 0;
  static const int skillSelection = 1;
  static const int loading = 2;

  const DefiningPage({Key? key}) : super(key: key);

  @override
  State<DefiningPage> createState() => _DefiningPageState();
}

class _DefiningPageState extends State<DefiningPage> {
  late int definingPart;

  @override
  void initState() {
    super.initState();
    definingPart = DefiningPage.positionSelection;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Padding(
        padding: ProgramConstants.pagePadding,
        child: _getDefiningPart(),
      ),
    );
  }

  void changeDefiningPart(defining) {
    setState(() {
      definingPart = defining;
    });
  }

  Widget _getDefiningPart() {
    switch (definingPart) {
      case DefiningPage.positionSelection:
        return PositionSelectionPage(changeDefining: changeDefiningPart);
      case DefiningPage.skillSelection:
        return SkillSelectionPage(changeDefining: changeDefiningPart);
      default:
        return const CircularProgressIndicator();
    }
  }
}
