import 'package:flutter/material.dart';

import '../../../core/util/constants.dart';
import '../custom_text_widget.dart';

class MovieDetails extends StatelessWidget {
  final String movieTitle;
  final String movieReleaseDate;
  final double movieVoteAverage;
  static const String releaseDateText = 'Release date: ';
  static const String movieTitleKey = 'MovieTitleKey';
  static const double movieTitleSize = 36;
  static const double movieReleaseDateSize = 18;
  static const double movieVoteAverageSize = 25;
  static const double starIconSize = 45;
  static const int voteAverageSubstringStart = 0;
  static const int voteAverageSubstringEnd = 3;

  const MovieDetails({
    required this.movieTitle,
    required this.movieReleaseDate,
    required this.movieVoteAverage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: movieTitle,
          fontSize: movieTitleSize,
          key: const Key(movieTitleKey),
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
              text: movieVoteAverage.toString().substring(
                    voteAverageSubstringStart,
                    voteAverageSubstringEnd,
                  ),
              fontSize: movieVoteAverageSize,
            ),
          ],
        ),
        CustomText(
          text: '$releaseDateText $movieReleaseDate',
          fontSize: movieReleaseDateSize,
        ),
      ],
    );
  }
}
