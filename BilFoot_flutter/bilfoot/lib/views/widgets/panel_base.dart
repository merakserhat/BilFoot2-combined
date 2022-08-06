import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:flutter/material.dart';

///Base Component to show a panel above the blurry background
class PanelBase extends StatelessWidget {
  const PanelBase({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: ProgramConstants.getDefaultBoxShadow(context)),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
