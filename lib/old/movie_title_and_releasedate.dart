import 'package:flutter/material.dart';
import '../constants.dart';

class MovieTitleAndReleaseDate extends StatelessWidget {
  const MovieTitleAndReleaseDate({super.key});

  static const String movieTitle = 'The Super Mario Bros. Movie';
  static const String movieReleaseDate = 'Release date: 2023/04/05';
  static const double movieTitleSize = 36;
  static const double movieReleaseDateSize = 16;

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movieTitle,
          style: TextStyle(
            color: Color(
              AppConstants.appFontColor,
            ),
            fontSize: movieTitleSize,
          ),
        ),
        Text(
          movieReleaseDate,
          style: TextStyle(
            color: Color(
              AppConstants.appFontColor,
            ),
            fontSize: movieReleaseDateSize,
          ),
        ),
      ],
    );
  }
}
