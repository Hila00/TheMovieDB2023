import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/util/constants.dart';
import '../app_circular_progress_indicator.dart';

class MovieCard extends StatelessWidget {
  final String moviePosterUrl;
  static const double imageWidthDefaultValue = 170;
  static const double imageHeightDefaultValue = 230;
  final double imageWidth;
  final double imageHeight;

  const MovieCard({
    required this.moviePosterUrl,
    this.imageWidth = imageWidthDefaultValue,
    this.imageHeight = imageHeightDefaultValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: moviePosterUrl,
      width: imageWidth,
      height: imageHeight,
      placeholder: (
        BuildContext context,
        String url,
      ) =>
          const Center(
        child: CustomCircularProgressIndicator(),
      ),
      errorWidget: (
        BuildContext context,
        String url,
        error,
      ) =>
          const Icon(
        Icons.error,
        color: Color(AppConstants.appFontColor),
      ),
    );
  }
}
