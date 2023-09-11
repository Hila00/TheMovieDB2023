import 'package:flutter/material.dart';
import '/constants.dart';

class MoviePoster extends StatelessWidget {
  String posterImageUrl;
  double posterImageWidth;
  double posterImageHeight;
  static const double paddingCircleProgressIndicator = 16;

  MoviePoster({
    required this.posterImageUrl,
    required this.posterImageWidth,
    required this.posterImageHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      posterImageUrl,
      width: posterImageWidth,
      height: posterImageHeight,
      loadingBuilder: (
          BuildContext context,
          Widget child,
          ImageChunkEvent? loadingProgress,
          ) {
        if (loadingProgress != null) {
          return const Padding(
            padding: EdgeInsets.all(
              paddingCircleProgressIndicator,
            ),
            child: CircularProgressIndicator(
              color: Color(
                AppConstants.appItemsBackgroundColor,
              ),
            ),
          );
        }
        else {
          return child;
        }
      },
    );
  }
}