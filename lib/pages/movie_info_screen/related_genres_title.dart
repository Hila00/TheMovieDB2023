import 'package:flutter/material.dart';
import '/custom_text_widget.dart';

class RelatedGenresTitle extends StatelessWidget {
  static const String title = 'Related genres';
  static const double leftPadding = 5;
  static const double topPadding = 2;
  static const double leftMargin = 3;
  static const double titleSize = 22;

  const RelatedGenresTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: leftPadding,
        top: topPadding,
      ),
      margin: const EdgeInsets.only(
        left: leftMargin,
      ),
      child: const CustomText(
        text: title,
        fontSize: titleSize,
      ),
    );
  }
}
