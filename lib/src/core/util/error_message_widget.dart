import 'package:flutter/material.dart';

import '../../config/route/app_routes.dart';
import '../../presentation/widget/custom_text_widget.dart';
import 'constants.dart';

class ErrorMessage extends StatelessWidget {
  static const double containerBorderRadius = 20;
  static const double containerPadding = 20;
  static const double containerMargin = 30;
  static const double errorMessageFontSize = 30;
  static const double wifiOffIconSize = 100;
  static const double sizedBoxHeight = 20;
  static const String yourSavedMoviesString = 'Your saved movies';
  static const double yourSavedMoviesStringFontSize = 25;
  static const String favoriteMoviesButtonText = 'Favorite movies';
  static const double favoriteMoviesButtonTextFontSize = 25;
  static const double favoriteMoviesButtonBorderRadius = 20;
  static const double favoriteMoviesButtonMarginTop = 25;
  static const double favoriteMoviesButtonPadding = 20;
  static const double iconArrowDownSize = 45;

  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(
          AppConstants.appItemsBackgroundColor,
        ),
        borderRadius: BorderRadius.circular(
          containerBorderRadius,
        ),
      ),
      padding: const EdgeInsets.all(
        containerPadding,
      ),
      margin: const EdgeInsets.all(
        containerMargin,
      ),
      child: Column(
        children: [
          const Center(
            child: CustomText(
              text: AppConstants.errorMessage,
              fontSize: errorMessageFontSize,
            ),
          ),
          const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: wifiOffIconSize,
          ),
          const SizedBox(
            height: sizedBoxHeight,
          ),
          const CustomText(
            text: yourSavedMoviesString,
            fontSize: yourSavedMoviesStringFontSize,
          ),
          const SizedBox(
            height: sizedBoxHeight,
          ),
          const Icon(
            Icons.arrow_downward_rounded,
            color: Color(
              AppConstants.appFontColor,
            ),
            size: iconArrowDownSize,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.favoritesRoute,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(
                  favoriteMoviesButtonBorderRadius,
                ),
              ),
              margin: const EdgeInsets.only(
                top: favoriteMoviesButtonMarginTop,
              ),
              padding: const EdgeInsets.all(
                favoriteMoviesButtonPadding,
              ),
              child: const CustomText(
                text: favoriteMoviesButtonText,
                fontSize: favoriteMoviesButtonTextFontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
