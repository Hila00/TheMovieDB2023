import 'package:flutter/material.dart';
import '../constants.dart';

class GenresList extends StatelessWidget {
  const GenresList({super.key});

  static const double containerBorderRadius = 15;
  static const double containerPadding = 5;
  static const double containerMargin = 6;
  static const double itemsFontSize = 15;
  static const List<String> genres = [
    'Animation',
    'Family',
    'Adventure',
    'Fantasy',
    'Comedy',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (String genre in genres)
          Container(
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
            child: Text(
              genre,
              style: const TextStyle(
                color: Color(
                  AppConstants.appFontColor,
                ),
                fontSize: itemsFontSize,
              ),
            ),
          ),
      ],
    );
  }
}
