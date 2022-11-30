import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/views/widgets/match_component/match_comp_square.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MatchSelector extends StatefulWidget {
  const MatchSelector(
      {Key? key, required this.matches, required this.onSelectionChanged})
      : super(key: key);
  final List<MatchModel> matches;
  final Function(MatchModel) onSelectionChanged;

  @override
  State<MatchSelector> createState() => _MatchSelectorState();
}

class _MatchSelectorState extends State<MatchSelector> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          viewportFraction: 0.42,
          aspectRatio: 3.5,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          onPageChanged: (index, _) {
            widget.onSelectionChanged(widget.matches[index]);
          }),
      items: widget.matches.map((match) {
        return Container(
          decoration:
              BoxDecoration(border: Border(right: BorderSide(width: 0))),
          child: MatchComponentSquare(
            matchModel: match,
          ),
        );
      }).toList(),
    );
  }
}
