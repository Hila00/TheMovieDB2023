import 'package:flutter/material.dart';
import '../../../core/util/constants.dart';
import 'movie_details.dart';
import 'movie_poster.dart';
import 'movie_like_button.dart';

class MovieInfoContainer extends StatelessWidget {
  final String title;
  final String posterUrl;
  final String releaseDate;
  final double voteAverage;
  static const double containerBorderRadius = 10;
  static const double containerBorderWidth = 5;
  static const double containerMargin = 5;
  static const double containerPaddingLeft = 5;
  static const double containerPaddingTop = 20;
  static const double containerPaddingRight = 5;
  static const double containerPaddingBottom = 10;
  static const double moviePosterWidth = 150;
  static const double moviePosterHeight = 200;

  const MovieInfoContainer({
    required this.title,
    required this.posterUrl,
    required this.releaseDate,
    required this.voteAverage,
    super.key,
  });

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              MoviePoster(
                posterImageUrl: posterUrl,
                posterImageWidth: moviePosterWidth,
                posterImageHeight: moviePosterHeight,
              ),
              const MovieLikeButton(),
            ],
          ),
          Expanded(
            child: MovieDetails(
              movieTitle: title,
              movieReleaseDate: releaseDate,
              movieVoteAverage: voteAverage,
            ),
          ),
        ],
      ),
    );
  }
}
