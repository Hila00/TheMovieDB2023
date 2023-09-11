import 'package:flutter/material.dart';
import 'pages/home_screen/app_home_screen.dart';
import 'constants.dart';
import 'pages/movie_info_screen/app_movie_info.dart';

class MyApp extends StatelessWidget {
  static const String initialRoute = '/';
  static const String movieInfoRoute = '/movie';

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
      initialRoute: initialRoute,
      routes: {
        initialRoute: (context) => const AppHomeScreen(),
        movieInfoRoute: (context) => const AppMovieInfo(),
      },
    );
  }
}