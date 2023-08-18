import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key});

  static const String posterImagePath = 'assets/images/posterImage.jpg';
  static const double posterImageWidth = 150;
  static const double posterImageHeight = 200;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      posterImagePath,
      width: posterImageWidth,
      height: posterImageHeight,
    );
  }
}
