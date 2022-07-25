import 'package:bilfoot/config/utils/auth_service.dart';
import 'package:bilfoot/views/routes/router.dart';
import 'package:bilfoot/views/screens/auth_page/auth_page.dart';
import 'package:bilfoot/views/screens/auth_page/auth_verification_page.dart';
import 'package:bilfoot/views/screens/auth_page/bloc/authentication_bloc.dart';
import 'package:bilfoot/views/screens/main_page/main_control_page.dart';
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
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: MaterialApp(
        title: 'First Page',
        theme: MyThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationUninitialized) {
              return const Text("Loading");
            } else if (state is AuthenticationAuthenticated) {
              if (!state.emailVerified) {
                return const AuthVerificationPage();
              }

              if (!state.homeDataLoading) {
                return const CircularProgressIndicator();
              }

              if (state.playerModel == null) {
                return const Text("User defining settings");
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
