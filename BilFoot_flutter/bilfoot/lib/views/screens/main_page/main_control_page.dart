import 'package:bilfoot/config/utils/fcm_service.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/views/screens/chat_page/chat_people_page.dart';
import 'package:bilfoot/views/screens/announcements_page/announcements_page.dart';
import 'package:bilfoot/views/screens/home_page/home_page.dart';
import 'package:bilfoot/views/screens/match_page/match_list_page.dart';
import 'package:bilfoot/views/screens/notifications_page/notifications_page.dart';
import 'package:bilfoot/views/screens/profile_page/profile_page.dart';
import 'package:bilfoot/views/screens/settings_page/settings_page.dart';
import "package:flutter/material.dart";

// ignore: constant_identifier_names
enum MainPages { HOME_PAGE, ANOUNCEMENTS_PAGE, PROFILE_PAGE }

class MainControlPage extends StatefulWidget {
  static const String routeName = "/main_control_page";

  const MainControlPage({Key? key}) : super(key: key);

  @override
  _MainControlPageState createState() => _MainControlPageState();
}

class _MainControlPageState extends State<MainControlPage> {
  @override
  void initState() {
    super.initState();
    FCMService fcmService = FCMService(context: context);
    fcmService.init();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white.withOpacity(0),
      appBar: AppBar(
        title: const Text("BilFoot"),
        actions: _getAppBarActions(),
      ),
      body: _getPage(MainPages.values[_currentIndex]),
      bottomNavigationBar: _getBottomBar(),
    );
  }

  ///Creates bottom bar
  Widget _getBottomBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/images/nav_buttons/home_icon.png",
            height: 20,
          ),
          activeIcon: Image.asset(
            "assets/images/nav_buttons/home_icon_gr.png",
            height: 20,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/images/nav_buttons/announcement_grey.png",
            height: 25,
          ),
          activeIcon: Image.asset(
            "assets/images/nav_buttons/announcement_grey.png",
            height: 25,
          ),
          label: "Announcements",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/images/nav_buttons/profile_icon.png",
            height: 20,
          ),
          activeIcon: Image.asset(
            "assets/images/nav_buttons/profile_icon_gr.png",
            height: 20,
          ),
          label: "Profile",
        )
      ],
      currentIndex: _currentIndex,
      onTap: (int i) {
        setState(() {
          _currentIndex = i;
        });
      },
      showSelectedLabels: true,
      showUnselectedLabels: false,
      elevation: 0,
    );
  }

  ///returns active page based on [activePage]
  Widget _getPage(MainPages activePage) {
    switch (activePage) {
      case MainPages.HOME_PAGE:
        return const HomePage();
      case MainPages.ANOUNCEMENTS_PAGE:
        return const AnnouncementsPage();
      case MainPages.PROFILE_PAGE:
        return const ProfilePage();
      default:
        return const Text("Empty Page");
    }
  }

  List<Widget> _getAppBarActions() {
    var chat = GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ChatPeoplePage()));
      },
      child: const Icon(
        Icons.message_outlined,
        color: Colors.white,
      ),
    );

    var settings = GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SettingsPage()));
      },
      child: const Icon(
        Icons.settings,
        color: Colors.white,
      ),
    );
    var notifications = GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NotificationsPage()));
      },
      child: const Icon(
        Icons.notifications,
        color: Colors.white,
      ),
    );
    List<Widget> actions = [];
    if (_currentIndex == 0 || _currentIndex == 1) {
      actions.add(notifications);
      //actions.add(const SizedBox.square(dimension: 16));
      //TODO: open this when chat feature is ready
      //actions.add(chat);
    } else {
      actions.add(settings);
    }

    actions.add(const SizedBox.square(dimension: 16));

    return actions;
  }
}
