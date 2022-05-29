import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bilfoot/views/routes/router.dart';
import 'package:bilfoot/views/themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      dark: MyThemes.darkTheme,
      light: MyThemes.lightTheme,
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'First Page',
        theme: darkTheme,
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme,
        onGenerateRoute: PageRouter.generateRoute,
      ),
    );
  }
}
