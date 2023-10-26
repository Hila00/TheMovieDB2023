import 'package:flutter/material.dart';
import 'src/core/util/bloc_singleton_dependencies.dart';
import 'src/config/route/app_routes.dart';
import 'src/core/util/constants.dart';
import 'src/presentation/view/app_home_screen.dart';
import 'src/presentation/view/app_trailers_screen.dart';
import 'package:provider/provider.dart';

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
        AppRoutes.homeScreenRoute: (context) => Provider(
              create: (_) => BlocSingletonDependencies.moviesBloc,
              child: const HomeScreen(),
            ),
        AppRoutes.trailersRoute: (context) => Provider(
              create: (_) => BlocSingletonDependencies.trailersBloc,
              child: const AppTrailersScreen(),
            ),
      },
    );
  }
}
