import 'package:flutter/material.dart';
import '../custom_text_widget.dart';
import '../movie_poster.dart';
import '../../../domain/entity/movie.dart';
import '../../../core/util/constants.dart';

class MovieListCard extends StatelessWidget {
  static const double movieCardBorderRadius = 5;
  static const double movieCardPadding = 10;
  static const double movieCardMargin = 5;
  static const double movieTitlePaddingTop = 10;
  static const double movieTitlePaddingBottom = 3;
  static const double movieTitlePaddingLeft = 6;
  static const double movieTitleFontSize = 24;
  static const double movieOverviewFontSize = 13;
  static const double movieOverviewPaddingLeft = 8;
  static const double movieOverviewPaddingBottom = 15;
  static const int movieOverviewMaxLines = 3;
  static const double moviePosterHeight = 150;
  static const double moviePosterWidth = 100;
  static const double movieVoteAverageFontSize = 20;
  static const double starIconSize = 35;
  Movie movie;

  MovieListCard({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          movieCardBorderRadius,
        ),
        color: const Color(
          AppConstants.appAccentColor,
        ),
      ),
      padding: const EdgeInsets.all(
        movieCardPadding,
      ),
      margin: const EdgeInsets.all(
        movieCardMargin,
      ),
      child: Row(
        children: [
          MoviePoster(
            posterImageUrl: movie.posterUrl,
            posterImageWidth: moviePosterWidth,
            posterImageHeight: moviePosterHeight,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: movieTitlePaddingTop,
                    left: movieTitlePaddingLeft,
                    bottom: movieTitlePaddingBottom,
                  ),
                  child: CustomText(
                    text: movie.title,
                    fontSize: movieTitleFontSize,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: movieOverviewPaddingLeft,
                    bottom: movieOverviewPaddingBottom,
                  ),
                  child: Text(
                    movie.overview,
                    style: const TextStyle(
                      color: Color(
                        AppConstants.appFontColor,
                      ),
                      fontSize: movieOverviewFontSize,
                    ),
                    maxLines: movieOverviewMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_half,
                      color: Color(
                        AppConstants.starColor,
                      ),
                      size: starIconSize,
                    ),
                    CustomText(
                      text: '${movie.voteAverage}',
                      fontSize: movieVoteAverageFontSize,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Color(
              AppConstants.appFontColor,
            ),
          ),
        ],
      ),
    );
  }
}
