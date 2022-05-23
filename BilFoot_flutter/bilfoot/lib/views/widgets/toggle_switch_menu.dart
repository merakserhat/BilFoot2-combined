import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:flutter/material.dart';

class ToggleSwitchMenu extends StatefulWidget {
  const ToggleSwitchMenu(
      {Key? key, required this.options, required this.onToggleChanged})
      : super(key: key);

  final List<String> options;
  final Function(int index, String value) onToggleChanged;

  @override
  State<ToggleSwitchMenu> createState() => _ToggleSwitchMenuState();
}

class _ToggleSwitchMenuState extends State<ToggleSwitchMenu> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          //border: Border.all(width: 0, color: Theme.of(context).primaryColor),
          boxShadow: ProgramConstants.getDefaultBoxShadow(context),
          color: Colors.white),
      child: Row(
        children: List.generate(
          widget.options.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                widget.onToggleChanged(index, widget.options[index]);
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: selectedIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                ),
                child: Center(
                  child: Text(
                    widget.options[index],
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: selectedIndex == index
                            ? Colors.white
                            : Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
