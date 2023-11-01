import 'package:flutter/material.dart';
import '../custom_text_widget.dart';
import '../../../core/util/constants.dart';

class MovieOverview extends StatelessWidget {
  static const double overviewFontSize = 18;
  static const double containerBorderRadius = 30;
  static const double containerMargin = 10;
  static const double containerPadding = 15;
  final String overview;

  const MovieOverview({
    required this.overview,
    super.key,
  });

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
      child: CustomText(
        text: overview,
        fontSize: overviewFontSize,
      ),
    );
  }
}
