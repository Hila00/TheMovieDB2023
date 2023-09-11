import 'package:flutter/material.dart';
import '../constants.dart';

class MovieDescription extends StatelessWidget {
  const MovieDescription({super.key});

  static const double overviewFontSize = 18;
  static const double containerBorderRadius = 30;
  static const double containerMargin = 10;
  static const double containerPadding = 15;
  static const String overview =
      'While working underground to fix a water main, '
      'Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander'
      ' into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to '
      'find Luigi.';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(
          AppConstants.appItemsBackgroundColor,
        ),
        borderRadius: BorderRadius.circular(
          containerBorderRadius,
        ),
      ),
      margin: const EdgeInsets.all(
        containerPadding,
      ),
      padding: const EdgeInsets.all(
        containerMargin,
      ),
      child: const Text(
        overview,
        style: TextStyle(
          color: Color(AppConstants.appFontColor),
          fontSize: overviewFontSize,
        ),
      ),
    );
  }
}
