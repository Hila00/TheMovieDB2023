import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/util/constants.dart';
import '../../../domain/entity/movie.dart';
import '../app_circular_progress_indicator.dart';
import '../custom_text_widget.dart';

class TrailerCard extends StatelessWidget {
  static const double generalContainerPadding = 30;
  static const double generalContainerMarginTop = 10;
  static const double movieTitleFontSize = 20;
  static const double sizedBoxHeight = 10;
  static const double movieImageHeight = 300;
  static const double movieImageBlurSigmaX = 1.7;
  static const double movieImageBlurSigmaY = 2;
  static const double playIconSize = 100;
  static const double playIconHeightFactor = 2.9;
  final Movie movie;

  const TrailerCard({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: generalContainerMarginTop,
      ),
      color: const Color(
        AppConstants.appAccentColor,
      ),
      padding: const EdgeInsets.all(
        generalContainerPadding,
      ),
      child: Column(
        children: [
          Flexible(
            child: CustomText(
              text: movie.title,
              fontSize: movieTitleFontSize,
            ),
          ),
          const SizedBox(
            height: sizedBoxHeight,
          ),
          Stack(
            children: [
              Center(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: movieImageBlurSigmaX,
                    sigmaY: movieImageBlurSigmaY,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: movie.posterUrl,
                    height: movieImageHeight,
                    fit: BoxFit.fitHeight,
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
                  ),
                ),
              ),
              const Center(
                heightFactor: playIconHeightFactor,
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: playIconSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
