import 'package:flutter/material.dart';
import 'constants.dart';
import 'my_home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MyHomePage(),
    );
  }
}
