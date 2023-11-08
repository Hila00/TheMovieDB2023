import 'package:flutter/material.dart';

import '../../../core/util/constants.dart';
import '../custom_text_widget.dart';

class EmptyFavoriteList extends StatelessWidget {
  static const double containerBorderRadius = 20;
  static const double containerPadding = 20;
  static const double containerMargin = 10;
  static const double noFavoriteMoviesMessageFontSize = 40;
  static const String noFavoriteMoviesMessage =
      "You don't have favorite movies saved";
  static const double heartBrokenIconSize = 100;

  const EmptyFavoriteList({super.key});

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
      padding: const EdgeInsets.all(
        containerPadding,
      ),
      margin: const EdgeInsets.all(
        containerMargin,
      ),
      child: const Column(
        children: [
          CustomText(
            text: noFavoriteMoviesMessage,
            fontSize: noFavoriteMoviesMessageFontSize,
          ),
          Icon(
            Icons.heart_broken_sharp,
            color: Colors.white,
            size: heartBrokenIconSize,
          ),
        ],
      ),
    );
  }
}
