import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/widgets/spinners/spinner_small.dart';
import "package:flutter/material.dart";

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/logo_huge.png",
            color: Colors.black.withOpacity(0.03),
          ),
          Padding(
            padding: ProgramConstants.pagePadding,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 80, bottom: 20),
                  width: 160,
                  child: Image.asset(
                    'assets/images/just_logo.png',
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "BilFoot",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 40),
                ),
                Expanded(child: Container()),
                const Center(
                  child: SpinnerSmall(),
                ),
                const SizedBox.square(dimension: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
