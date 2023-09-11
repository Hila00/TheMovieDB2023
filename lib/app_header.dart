import 'package:flutter/material.dart';
import 'constants.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  static const double containerPadding = 8;
  static const double titleLeftPadding = 29;
  static const double titleSize = 33;
  static const double menuIconSize = 35;
  static const IconData menuIcon = Icons.menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(
        AppConstants.appItemsBackgroundColor,
      ),
      padding: const EdgeInsets.all(containerPadding),
      child: const Row(
        children: [
          Icon(
            menuIcon,
            color: Color(
              AppConstants.appFontColor,
            ),
            size: menuIconSize,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: titleLeftPadding,
            ),
            child: Text(
              AppConstants.appTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: titleSize,
                color: Color(
                  AppConstants.appFontColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
