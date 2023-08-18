import 'package:flutter/material.dart';
import 'constants.dart';
import 'movie_title_and_releasedate.dart';
import 'movie_poster.dart';
import 'movie_like_button.dart';

class MovieInfoContainer extends StatefulWidget {
  const MovieInfoContainer({super.key});

  @override
  State<MovieInfoContainer> createState() => _MovieInfoContainerState();
}

class _MovieInfoContainerState extends State<MovieInfoContainer> {
  static const double containerBorderRadius = 10;
  static const double containerBorderWidth = 5;
  static const double containerMargin = 5;
  static const double containerPaddingLeft = 5;
  static const double containerPaddingTop = 20;
  static const double containerPaddingRight = 5;
  static const double containerPaddingBottom = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(
          AppConstants.appAccentColor,
        ),
        border: Border.all(
          width: containerBorderWidth,
          color: const Color(
            AppConstants.appFontColor,
          ),
        ),
        borderRadius: BorderRadius.circular(
          containerBorderRadius,
        ),
      ),
      margin: const EdgeInsets.all(
        containerMargin,
      ),
      padding: const EdgeInsets.fromLTRB(
        containerPaddingLeft,
        containerPaddingTop,
        containerPaddingRight,
        containerPaddingBottom,
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              MoviePoster(),
              MovieLikeButton(),
            ],
          ),
          Expanded(
            child: MovieTitleAndReleaseDate(),
          ),
        ],
      ),
    );
  }
}
