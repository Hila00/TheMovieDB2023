import 'package:flutter/material.dart';
import '../../core/util/constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final int color;
  static const double fontSizeDefaultValue = 12;

  const CustomText({
    required this.text,
    this.fontSize = fontSizeDefaultValue,
    this.color = AppConstants.appFontColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color(
          color,
        ),
        fontSize: fontSize,
      ),
    );
  }
}
