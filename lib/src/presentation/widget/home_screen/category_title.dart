import 'package:flutter/material.dart';
import '../custom_text_widget.dart';

class CategoryTitle extends StatelessWidget {
  final String title;
  final double titleFontSize;
  final double arrowIconSize;
  static const double defaultTitleFontSize = 27;
  static const double titleRowTopMargin = 20;
  static const double titleRowBottomMargin = 1;
  static const double titleRowLeftPadding = 10;
  static const double iconLeftMargin = 5;
  static const double defaultArrowIconSize = 24;
  static const double tapToDetailsLeftMargin = 12;
  static const String tapToDetailsTitle = 'Tap movie to see details';
  static const double tapToDetailsTitleSize = 17;

  const CategoryTitle({
    required this.title,
    this.titleFontSize = defaultTitleFontSize,
    this.arrowIconSize = defaultArrowIconSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: titleRowTopMargin,
            bottom: titleRowBottomMargin,
          ),
          padding: const EdgeInsets.only(
            left: titleRowLeftPadding,
          ),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: iconLeftMargin,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: arrowIconSize,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: tapToDetailsLeftMargin,
          ),
          child: const Row(
            children: [
              CustomText(
                text: tapToDetailsTitle,
                fontSize: tapToDetailsTitleSize,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
