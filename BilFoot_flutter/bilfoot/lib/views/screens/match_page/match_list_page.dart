import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/views/screens/match_page/bloc/match_bloc.dart';
import 'package:bilfoot/views/screens/match_page/create_edit_match_panel.dart';
import 'package:bilfoot/views/screens/match_page/widgets/match_list_item.dart';
import 'package:bilfoot/views/widgets/spinners/spinner_small.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchListPage extends StatefulWidget {
  const MatchListPage({Key? key}) : super(key: key);

  @override
  State<MatchListPage> createState() => _MatchListPageState();
}

class _MatchListPageState extends State<MatchListPage>
    with TickerProviderStateMixin {
  late MatchModel matchModel;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<MatchBloc>().add(MatchGetMatches());
    matchModel = MatchModel(
        id: "12s",
        date: DateTime.now(),
        hour: "9-10",
        pitch: "Merkez 1",
        isPitchApproved: false,
        creator: Program.program.dummyPlayer2,
        players: [Program.program.dummyPlayer2, Program.program.dummyPlayer1],
        authPlayers: [Program.program.dummyPlayer2.id],
        showOnTable: true,
        peopleLimit: 14);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.5,
                    color: Color(0xFFDDDDFF),
                  ),
                ),
              ),
              child: TabBar(
                indicatorWeight: 4,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                labelColor: Theme.of(context).primaryColor,
                indicatorColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.black87,
                labelStyle: Theme.of(context).textTheme.headline4,
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: "Upcoming",
                  ),
                  Tab(
                    text: "Past",
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<MatchBloc, MatchState>(
                builder: (context, state) {
                  return TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: state.upcomingMatches == null
                            ? const Center(
                                child: SpinnerSmall(),
                              )
                            : Column(
                                children: state.upcomingMatches!
                                    .map((e) => MatchListItem(matchModel: e))
                                    .toList(),
                              ),
                      ),
                      SingleChildScrollView(
                        child: state.pastMatches == null
                            ? const Center(
                                child: SpinnerSmall(),
                              )
                            : Column(
                                children: state.pastMatches!
                                    .map((e) => MatchListItem(matchModel: e))
                                    .toList(),
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1.5,
                    color: Color(0xFFDDDDFF),
                  ),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox.square(dimension: 5),
                  _buildMyMatchesButton(context),
                  const SizedBox.square(dimension: 10),
                  _buildNewMatchButton(context),
                  const SizedBox.square(dimension: 5),
                ],
              ),
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
          ProgramConstants.showBlurryBackground(
              context: context, child: const CreateEditMatchPanel());
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
