import 'package:flutter/material.dart';
import 'category_title.dart';

class CategoryOutstandingTitle extends CategoryTitle {
  static const double fontSize = 40;
  static const double iconSize = 36;

  const CategoryOutstandingTitle({
    required super.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CategoryTitle(
      title: title,
      titleFontSize: fontSize,
      arrowIconSize: iconSize,
    );
  }
}
