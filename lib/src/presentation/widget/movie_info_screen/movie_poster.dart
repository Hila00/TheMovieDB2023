import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../app_circular_progress_indicator.dart';

class MoviePoster extends StatelessWidget {
  final String posterImageUrl;
  final double posterImageWidth;
  final double posterImageHeight;

  const MoviePoster({
    required this.posterImageUrl,
    required this.posterImageWidth,
    required this.posterImageHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: posterImageUrl,
      height: posterImageHeight,
      width: posterImageWidth,
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
