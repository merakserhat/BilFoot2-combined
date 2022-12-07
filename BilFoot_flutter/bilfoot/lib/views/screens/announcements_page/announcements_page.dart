import 'package:bilfoot/config/constants/program_colors.dart';
import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/screens/auth_page/auth_page.dart';
import 'package:bilfoot/views/screens/defining_page/position_selection_page.dart';
import 'package:bilfoot/views/screens/defining_page/skill_selection_page.dart';
import 'package:bilfoot/views/screens/announcements_page//bloc/announcement_bloc.dart';
import 'package:bilfoot/views/screens/announcements_page/widgets/announcement_table.dart';
import 'package:bilfoot/views/screens/new_announcement_page/new_announcement_type_panel.dart';
import 'package:bilfoot/views/widgets/modals/captain_modal.dart';
import 'package:bilfoot/views/widgets/modals/kick_modal.dart';
import 'package:bilfoot/views/widgets/modals/quit_modal.dart';
import 'package:bilfoot/views/widgets/spinners/spinner_small.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);
  static const String routeName = "home_page";

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
    context.read<AnnouncementBloc>().add(AnnouncementGetAnnouncements());

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
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
                tabs: const [
                  Tab(
                    text: "Find Player",
                  ),
                  Tab(
                    text: "Find Opponent",
                  ),
                ],
              ),
            ),
            BlocBuilder<AnnouncementBloc, AnnouncementState>(
              builder: (context, state) {
                return Expanded(
                  child: Container(
                    color: Colors.white,
                    child: TabBarView(
                      children: [
                        state.isLoading
                            ? const SpinnerSmall()
                            : AnnouncementList(
                                playerAnnouncementModels: context
                                    .read<AnnouncementBloc>()
                                    .state
                                    .playerAnnouncements),
                        state.isLoading
                            ? const SpinnerSmall()
                            : AnnouncementList(
                                opponentAnnouncementModels: context
                                    .read<AnnouncementBloc>()
                                    .state
                                    .opponentAnnouncements),
                      ],
                    ),
                  ),
                );
              },
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
                  _buildMyAnnouncementsButton(context),
                  const SizedBox.square(dimension: 10),
                  _buildNewAnnouncementButton(context),
                  const SizedBox.square(dimension: 5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMyAnnouncementsButton(BuildContext context) {
    return Expanded(
      child: Material(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: () {
            /*
            //TODO: my announcements
            //TODO remove this
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => PositionSelectionPage(
                      onCallback: (List<String> positions) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => SkillSelectionPage(
                                  onCallback:
                                      (List<String> feet, List<String> skills) {
                                    //TODO: all registration information is here
                                    print(positions);
                                    print(feet);
                                    print(skills);
                                  },
                                )));
                      },
                    )));*/
          },
          child: SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                "My Announcements",
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Colors.white),
              ))),
        ),
      ),
    );
  }

  Widget _buildNewAnnouncementButton(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {
          ProgramConstants.showBlurryBackground(
              context: context, child: const NewAnnouncementTypePanel());
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

/* Some Notes
FIND PLAYER ANNOUNCEMENT FLOW

-> Pasife alma flowu yap

-> Accepted players dolduğunda pasife al










 */
