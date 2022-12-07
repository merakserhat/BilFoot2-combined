import 'package:bilfoot/config/constants/program_colors.dart';
import 'package:bilfoot/views/widgets/bilfoot_button.dart';
import "package:flutter/material.dart";
import 'dart:math' as math;

class Mirza extends StatefulWidget {
  const Mirza(
      {Key? key,
      required this.content,
      required this.titles,
      required this.msgSend})
      : super(key: key);
  final Widget content;
  final List<String> titles;
  final String msgSend;

  @override
  State<Mirza> createState() => _MirzaState();
}

class _MirzaState extends State<Mirza> {
  int selectedIndex = 2;
  final double size = 40;
  final Color borderColor = const Color(0xFFDDDDDD);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex++;

          if (selectedIndex == widget.titles.length) selectedIndex = 0;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: size,
                width: double.infinity,
                child: Stack(
                  children: [
                    ...widget.titles
                        .getRange(selectedIndex + 1, widget.titles.length)
                        .toList()
                        .reversed
                        .map((e) =>
                            getSmallBox(currentIndex: widget.titles.indexOf(e)))
                        .toList(),
                    getCurrentBox(),
                    ...widget.titles
                        .getRange(0, selectedIndex)
                        .toList()
                        .reversed
                        .map((e) =>
                            getSmallBox(currentIndex: widget.titles.indexOf(e)))
                        .toList(),
                  ],
                ),
              ),
              const SizedBox.square(dimension: 10),
              widget.content,
              const SizedBox.square(dimension: 10),
              BilfootButton(
                label: selectedIndex == widget.titles.length - 1
                    ? widget.msgSend
                    : "Continue",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCurrentBox() {
    double currentWidth =
        MediaQuery.of(context).size.width - (widget.titles.length - 1) * size;
    double arrowHeight = (size * math.sqrt(2)) / 2;

    return Positioned(
      right: (widget.titles.length - 1 - selectedIndex) * size,
      child: SizedBox(
          width: currentWidth,
          height: size,
          child: Stack(
            children: [
              widget.titles.length - 1 == selectedIndex
                  ? Container()
                  : Positioned(
                      top: (size - arrowHeight) / 2,
                      right: 0,
                      child: Transform.rotate(
                        angle: math.pi / 4,
                        child: SizedBox(
                          width: arrowHeight,
                          height: arrowHeight,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor),
                              color: ProgramColors.bilkentPalette[1],
                            ),
                          ),
                        ),
                      ),
                    ),
              Container(
                width: widget.titles.length - 1 == selectedIndex
                    ? currentWidth
                    : currentWidth - arrowHeight / 2,
                height: size,
                decoration: BoxDecoration(
                  color: ProgramColors.bilkentPalette[1],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox.square(dimension: size),
                    Text(
                      //"${selectedIndex + 1}) ${widget.titles[selectedIndex]}",
                      "${widget.titles[selectedIndex]}",
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget getSmallBox({required int currentIndex}) {
    print(currentIndex);
    double arrowHeight = (size * math.sqrt(2)) / 2;

    return Positioned(
      left: currentIndex < selectedIndex ? currentIndex * size : null,
      right: currentIndex > selectedIndex
          ? (widget.titles.length - 1 - currentIndex) * size
          : null,
      child: SizedBox(
        width: size + arrowHeight / 2,
        height: size,
        child: Stack(
          children: [
            widget.titles.length - 1 == currentIndex
                ? Container(
                    width: widget.titles.length - 1 == currentIndex
                        ? size + arrowHeight / 2
                        : size,
                    color: selectedIndex > currentIndex
                        ? ProgramColors.bilkentPalette[6]
                        : Color(0xFF444444),
                  )
                : Positioned(
                    top: (size - arrowHeight) / 2,
                    left: size - arrowHeight / 2,
                    child: Transform.rotate(
                      angle: math.pi / 4,
                      child: SizedBox(
                        width: arrowHeight,
                        height: arrowHeight,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            color: selectedIndex > currentIndex
                                ? ProgramColors.bilkentPalette[6]
                                : Color(0xFF444444),
                          ),
                        ),
                      ),
                    ),
                  ),
            Positioned(
              right: widget.titles.length - 1 == currentIndex ? 0 : null,
              child: SizedBox(
                width: size,
                height: size,
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedIndex > currentIndex
                        ? ProgramColors.bilkentPalette[6]
                        : Color(0xFF444444),
                  ),
                  child: Align(
                    alignment: widget.titles.length - 1 == currentIndex ||
                            currentIndex == 0
                        ? Alignment.center
                        : Alignment.centerRight,
                    child: Text(
                      (currentIndex + 1).toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
