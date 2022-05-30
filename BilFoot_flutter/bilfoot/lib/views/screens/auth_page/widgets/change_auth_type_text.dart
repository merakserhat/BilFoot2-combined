import 'package:bilfoot/views/screens/auth_page/auth_page.dart';
import 'package:flutter/material.dart';

class ChangeAuthTypeText extends StatelessWidget {
  const ChangeAuthTypeText(
      {Key? key, required this.currentAuthType, required this.changeAuthType})
      : super(key: key);

  final AuthType currentAuthType;
  final Function(AuthType) changeAuthType;

  @override
  Widget build(BuildContext context) {
    if (currentAuthType == AuthType.login) {
      return GestureDetector(
        onTap: () {
          changeAuthType(AuthType.register);
        },
        child: Column(
          children: [
            Text(
              "Don't you have an account",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              "Register Instead",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          changeAuthType(AuthType.login);
        },
        child: Column(
          children: [
            Text(
              "Already have an account",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              "Login Instead",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      );
    }
  }
}
