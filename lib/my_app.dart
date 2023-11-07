import 'package:flutter/material.dart';

import 'src/config/route/app_routes.dart';
import 'src/core/util/constants.dart';
import 'src/presentation/view/app_favorite_movies_screen.dart';
import 'src/presentation/view/app_home_screen.dart';
import 'src/presentation/view/app_trailers_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(
            AppConstants.appBackgroundColor,
          ),
        ),
        scaffoldBackgroundColor: const Color(
          AppConstants.appBackgroundColor,
        ),
      ),
      initialRoute: AppRoutes.homeScreenRoute,
      routes: {
        AppRoutes.homeScreenRoute: (BuildContext context) => const HomeScreen(),
        AppRoutes.trailersRoute: (BuildContext context) =>
            const AppTrailersScreen(),
        AppRoutes.favoritesRoute: (BuildContext context) =>
            const FavoriteMoviesScreen(),
      },
    );
  }
}
