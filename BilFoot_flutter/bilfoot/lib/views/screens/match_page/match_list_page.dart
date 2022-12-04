import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/screens/match_page/bloc/match_bloc.dart';
import 'package:bilfoot/views/screens/match_page/create_edit_match_panel.dart';
import 'package:bilfoot/views/screens/match_page/widgets/match_list_item.dart';
import 'package:bilfoot/views/widgets/spinners/spinner_small.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

/**
 * This page is not an active page for now.
 *
 * In order to publish this application with the core features,
 * this part should be hidden.
 */
class MatchListPage extends StatefulWidget {
  const MatchListPage({Key? key}) : super(key: key);

  @override
  State<MatchListPage> createState() => _MatchListPageState();
}

class _MatchListPageState extends State<MatchListPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<MatchBloc>().add(MatchGetMatches());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: BlocBuilder<MatchBloc, MatchState>(
          builder: (context, state) {
            return Column(
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
                  child: AbsorbPointer(
                    absorbing: state.isLoading,
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
                ),
                Expanded(
                    child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    state.upcomingMatches == null || state.isLoading
                        ? const Center(
                            child: SpinnerSmall(),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: state.upcomingMatches!
                                  .map((e) => MatchListItem(matchModel: e))
                                  .toList(),
                            ),
                          ),
                    state.pastMatches == null || state.isLoading
                        ? const Center(
                            child: SpinnerSmall(),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: state.pastMatches!
                                  .map((e) => MatchListItem(matchModel: e))
                                  .toList(),
                            ),
                          ),
                  ],
                )),
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
            );
          },
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
