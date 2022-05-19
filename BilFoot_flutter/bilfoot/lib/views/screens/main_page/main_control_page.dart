import 'package:bilfoot/views/screens/first_page/first_page.dart';
import "package:flutter/material.dart";

// ignore: constant_identifier_names
enum MainPages { HOME_PAGE, PROFILE_PAGE }

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
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white.withOpacity(0),
      appBar: AppBar(
        title: const Text("text"),
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
        return const FirstPage();
      case MainPages.PROFILE_PAGE:
        return const FirstPage();
      default:
        return const Text("Empty Page");
    }
  }
}
