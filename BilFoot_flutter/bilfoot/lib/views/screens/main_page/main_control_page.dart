import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bilfoot/views/screens/first_page/first_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import "package:flutter/material.dart";

// ignore: constant_identifier_names
enum MainPages { HOME_PAGE, PROFILE_PAGE }

class MainControlPage extends StatefulWidget {
  static const String routeName = "/main_control_page";

  const MainControlPage({Key? key}) : super(key: key);

  @override
  _MainControlPageState createState() => _MainControlPageState();
}

class _MainControlPageState extends State<MainControlPage>
    with TickerProviderStateMixin {
  //#region bar items
  final List<TabItem> _bottomBarItems = [
    TabItem(
      icon: Image.asset(
        "assets/images/nav_buttons/home_icon.png",
        height: 20,
      ),
      activeIcon: Image.asset(
        "assets/images/nav_buttons/home_icon_gr.png",
        height: 20,
      ),
    ),
    TabItem(
      icon: Image.asset(
        "assets/images/nav_buttons/profile_icon.png",
        height: 20,
      ),
      activeIcon: Image.asset(
        "assets/images/nav_buttons/profile_icon_gr.png",
        height: 20,
      ),
    ),
  ];

  //#endregion

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  int _currentIndex = 0;
  bool backLayerOpen = false;
  late final TabController tabController;

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
      // appBar: BackdropAppBar(
      //   title: Text("Navigation Example"),
      //   actions: <Widget>[
      //     BackdropToggleButton(
      //       icon: AnimatedIcons.list_view,
      //     )
      //   ],
      // ),
    );
  }

  ///Creates bottom bar
  Widget _getBottomBar() {
    tabController.index = _currentIndex;

    var bottomNav = StyleProvider(
      style: MyStyleHook(),
      child: ConvexAppBar(
        controller: tabController,
        activeColor: Colors.white.withOpacity(0.8),
        color: Colors.transparent,
        style: TabStyle.fixedCircle,
        curveSize: 0,
        top: -20,
        backgroundColor: Colors.yellow,
        elevation: 0,
        height: 60,
        // initialActiveIndex: navigationProvider.isDrawerPressed
        //     ? _bottomBarInitialIndex()
        //     : isVideoPage
        //         ? 3
        //         : currentPage,
        items: _bottomBarItems,
        onTap: (int i) {
          /*context
              .read<MainControlBloc>()
              .add(ChangePage(mainPage: MainPages.values[i]));*/
          setState(() {
            _currentIndex = i;
          });
        },
      ),
    );
    return bottomNav;
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
/*
  /// Havalı comment line ile appbardaki iconu belirliyoruz
  List<Widget> _getActionBarIcon(MainPages activePage) {
    switch (activePage) {
      case MainPages.PROFILE_PAGE:
        return [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(ProfileSettingsPage.routeName);
                },
                icon: Icon(
                  Icons.settings,
                  color: ProgramColors.of(context)
                      .defaultTextColor
                      .withOpacity(0.8),
                )),
          )
        ];
      case MainPages.DERMATOLOGIST_PAGE:
        return [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(ConversationHistoryPage.routeName);
              },
              icon: Icon(
                CustomIcons.chat,
                color:
                    ProgramColors.of(context).defaultTextColor.withOpacity(0.8),
              ),
            ),
          )
        ];
      case MainPages.HOME_PAGE:
        return [
          !Program.program.isPremium
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(PremiumPage.routeName);
                  },
                  icon: Container(
                    width: 25,
                    height: 25,
                    child: Image.asset(
                      "assets/images/diamond.png",
                      color: ProgramColors.of(context)
                          .defaultTextColor
                          .withOpacity(0.8),
                    ),
                  ),
                )
              : Container(),
          BackdropToggleButton(
            icon: AnimatedIcons.ellipsis_search,
            color: ProgramColors.of(context).defaultTextColor.withOpacity(0.8),
          )
        ];
      default:
        return [];
    }
  }*/
}

///Basic settings for bottom  navigation bar
class MyStyleHook extends StyleHook {
  @override
  double get activeIconSize => 26;

  @override
  double get activeIconMargin => 0;

  @override
  double get iconSize => 22;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 10, color: color);
  }
}
