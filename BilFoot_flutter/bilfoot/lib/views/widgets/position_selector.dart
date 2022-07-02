import 'package:flutter/material.dart';

class PositionSelector extends StatefulWidget {
  const PositionSelector({Key? key, required this.onSelectionChange})
      : super(key: key);

  final Function(List<String> positions) onSelectionChange;

  @override
  State<PositionSelector> createState() => _PositionSelectorState();
}

class _PositionSelectorState extends State<PositionSelector> {
  //default
  List<String> selectedPositions = ["CM"];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset("assets/images/football_pitch.png"),
          ),
          Positioned(
              top: 50,
              child: PositionCircle(
                title: "ST",
                onClick: changeSelection,
              )),
          Positioned(
              right: 50,
              top: 120,
              child: PositionCircle(
                title: "RW",
                onClick: changeSelection,
              )),
          Positioned(
              left: 50,
              top: 120,
              child: PositionCircle(
                title: "LW",
                onClick: changeSelection,
              )),
          PositionCircle(
            title: "CM",
            onClick: changeSelection,
          ),
          Positioned(
              bottom: 100,
              child: PositionCircle(
                title: "CB",
                onClick: changeSelection,
              )),
          Positioned(
              bottom: 30,
              child: PositionCircle(
                title: "GK",
                onClick: changeSelection,
              )),
        ],
      ),
    );
  }

  void changeSelection(String value, bool isSelected) {
    if (isSelected) {
      selectedPositions.add(value);
    } else {
      selectedPositions.remove(value);
    }

    widget.onSelectionChange(selectedPositions);
  }
}

class PositionCircle extends StatefulWidget {
  const PositionCircle({Key? key, required this.title, required this.onClick})
      : super(key: key);

  final String title;
  final Function(String, bool) onClick;

  @override
  State<PositionCircle> createState() => _PositionCircleState();
}

class _PositionCircleState extends State<PositionCircle> {
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    //Default value
    if (widget.title == "CM") {
      isActive = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isActive = !isActive;
          widget.onClick(widget.title, isActive);
        });
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color:
                      isActive ? Colors.black : Colors.black.withOpacity(0.5),
                ),
          ),
        ),
      ),
    );
  }
}
