import 'package:flutter/material.dart';
import '../constants.dart';

class RelatedGenresTitle extends StatelessWidget {
  const RelatedGenresTitle({super.key});

  static const String title = 'Related genres';
  static const double leftPadding = 5;
  static const double topPadding = 2;
  static const double leftMargin = 3;
  static const double titleSize = 22;

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
      child: const Text(
        title,
        style: TextStyle(
          color: Color(
            AppConstants.appFontColor,
          ),
          fontSize: titleSize,
        ),
      ),
    );
  }
}
