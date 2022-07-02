import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/views/screens/match_page/widgets/match_list_item.dart';
import 'package:bilfoot/views/screens/match_page/widgets/match_table.dart';
import "package:flutter/material.dart";

class MatchListPage extends StatefulWidget {
  const MatchListPage({Key? key}) : super(key: key);

  @override
  State<MatchListPage> createState() => _MatchListPageState();
}

class _MatchListPageState extends State<MatchListPage> {
  late MatchModel matchModel;

  @override
  void initState() {
    super.initState();
    matchModel = MatchModel(
        date: "17 Tem. Salı",
        hour: "9-10",
        pitch: "Merkez 1",
        isPitchApproved: false,
        creator: Program.program.dummyPlayer2,
        people: [Program.program.dummyPlayer2, Program.program.dummyPlayer1],
        authPeople: [Program.program.dummyPlayer2],
        showOnTable: true,
        peopleLimit: 14);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: ProgramConstants.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Matches:",
              style:
                  Theme.of(context).textTheme.headline5!.copyWith(fontSize: 20),
            ),
            const SizedBox.square(dimension: 10),
            const MatchTable(),
            const SizedBox.square(dimension: 20),
            Row(
              children: [
                const SizedBox.square(dimension: 5),
                _buildMyMatchesButton(context),
                const SizedBox.square(dimension: 10),
                _buildNewMatchButton(context),
                const SizedBox.square(dimension: 5),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMyMatchesButton(BuildContext context) {
    return Expanded(
      child: Material(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: () {},
          child: SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                "My Matches",
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Colors.white),
              ))),
        ),
      ),
    );
  }

  Widget _buildNewMatchButton(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {
          //ProgramConstants.showBlurryBackground(
          //    context: context, child: const NewAnnouncementTypePanel());
        },
        child: const SizedBox(
          height: 50,
          width: 50,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
