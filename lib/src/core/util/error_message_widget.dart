import 'package:flutter/material.dart';
import 'constants.dart';
import '../../presentation/widget/custom_text_widget.dart';

class ErrorMessage extends StatelessWidget {
  static const double containerBorderRadius = 20;
  static const double containerPadding = 20;
  static const double containerMargin = 30;
  static const double errorMessageFontSize = 30;
  static const double iconSize = 100;

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
      child: const Column(
        children: [
          Center(
            child: CustomText(
              text: AppConstants.errorMessage,
              fontSize: errorMessageFontSize,
            ),
          ),
          Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: iconSize,
          ),
        ],
      ),
    );
  }
}
