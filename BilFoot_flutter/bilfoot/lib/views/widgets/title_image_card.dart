import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:flutter/material.dart';

class TitleImageCard extends StatelessWidget {
  final String? imagePath;
  final String label;
  final double iconSize;
  final bool isSelected;
  final Function(String)? onClicked;

  final isSelectable;

  const TitleImageCard({
    this.imagePath,
    required this.label,
    this.iconSize = 30,
    this.isSelectable = true,
    this.isSelected = false,
    this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onClicked != null) {
          onClicked!(label);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            color: !isSelected ? Colors.white : Theme.of(context).primaryColor,
            boxShadow: ProgramConstants.getDefaultBoxShadow(context),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: imagePath == null ? 9 : 6,
              child: Container(
                padding: EdgeInsets.only(bottom: iconSize * 0.6),
                alignment: Alignment.topLeft,
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).textTheme.bodyText1!.color),
                ),
              ),
            ),
            const SizedBox.square(dimension: 20),
            imagePath == null
                ? Container()
                : Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(top: iconSize),
                      child: Image.asset(
                        imagePath!,
                        color: isSelected ? Colors.white : Colors.black,
                        height: iconSize,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
