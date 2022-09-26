import 'package:bilfoot/views/routes/router.dart';
import 'package:bilfoot/views/screens/auth_page/auth_page.dart';
import 'package:bilfoot/views/screens/auth_page/auth_verification_page.dart';
import 'package:bilfoot/views/screens/auth_page/bloc/authentication_bloc.dart';
import 'package:bilfoot/views/screens/defining_page/bloc/defining_bloc.dart';
import 'package:bilfoot/views/screens/defining_page/defining_page.dart';
import 'package:bilfoot/views/screens/main_page/main_control_page.dart';
import 'package:bilfoot/views/screens/match_page/bloc/match_bloc.dart';
import 'package:bilfoot/views/screens/team_page/bloc/team_bloc.dart';
import 'package:bilfoot/views/themes/my_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(),
        ),
        BlocProvider<DefiningBloc>(
          create: (BuildContext context) => DefiningBloc(),
        ),
        BlocProvider<TeamBloc>(
          create: (BuildContext context) => TeamBloc(),
        ),
        BlocProvider<MatchBloc>(
          create: (BuildContext context) => MatchBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'First Page',
        theme: MyThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: PageRouter.generateRoute,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            print("state");
            print(state);
            if (state is AuthenticationUninitialized) {
              print("buraya nasıl girdi amk ");
              print(state);
              return const Text("Loading");
            } else if (state is AuthenticationAuthenticated) {
              if (!state.emailVerified) {
                print("email not verified");
                return const AuthVerificationPage();
              }

              if (state.homeDataLoading) {
                print("home data loading");
                return const CircularProgressIndicator();
              }

              if (state.playerModel == null) {
                print("player modal");

                return const DefiningPage();
              }

              return const MainControlPage();
            }
            return const AuthPage();
          },
        ),
      ),
    );
  }
}
