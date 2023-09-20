import 'package:flutter/material.dart';
import '../../config/route/app_routes.dart';
import '../../core/util/constants.dart';
import 'custom_text_widget.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const double drawerHeaderHeight = 100;
  static const double headerIconSize = 30;
  static const String drawerTitle = 'Welcome back user!';
  static const double drawerHeaderFontSize = 25;
  static const String homeScreenTileName = 'Home page';
  static const String trailersScreenTileName = 'Trailers';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: const Color(
            AppConstants.appItemsBackgroundColor,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              SizedBox(
                height: drawerHeaderHeight,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(
                      AppConstants.appAccentColor,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: headerIconSize,
                          color: Colors.white,
                        ),
                        Text(
                          drawerTitle,
                          style: TextStyle(
                            color: Color(
                              AppConstants.appFontColor,
                            ),
                            fontSize: drawerHeaderFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              DrawerListTile(
                icon: Icons.home,
                title: homeScreenTileName,
                pointedRoute: AppRoutes.homeScreenRoute,
              ),
              DrawerListTile(
                icon: Icons.movie,
                title: trailersScreenTileName,
                pointedRoute: AppRoutes.trailersRoute,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String pointedRoute;
  static const double titleFontSize = 20;
  static const double iconSize = 30;

  const DrawerListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.pointedRoute,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(
          AppConstants.appFontColor,
        ),
        size: iconSize,
      ),
      title: CustomText(
        text: title,
        fontSize: titleFontSize,
      ),
      onTap: () {
        Navigator.popAndPushNamed(
          context,
          pointedRoute,
        );
      },
    );
  }
}
