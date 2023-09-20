import 'package:flutter/material.dart';
import '../../core/util/constants.dart';

class AppHeader extends StatelessWidget {
  static const double containerPadding = 8;
  static const double titleLeftPadding = 29;
  static const double titleSize = 33;
  static const double menuIconSize = 35;
  static const IconData menuIcon = Icons.menu;

  const AppHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(
        AppConstants.appItemsBackgroundColor,
      ),
      padding: const EdgeInsets.all(
        containerPadding,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(
              menuIcon,
              color: Color(
                AppConstants.appFontColor,
              ),
              size: menuIconSize,
            ),
          ),
          const Padding(
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
