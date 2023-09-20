import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../app_circular_progress_indicator.dart';

class MovieCard extends StatelessWidget {
  final String moviePosterUrl;
  static const double imageWidth = 150;
  static const double imageHeight = 200;

  const MovieCard({
    required this.moviePosterUrl,
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
      ),
    );
  }
}
