import 'package:flutter/material.dart';
import '../widget/home_screen/home_search_bar.dart';
import '../widget/home_screen/movie_list_widget.dart';
import '../widget/app_header.dart';

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({
    super.key,
  });

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(),
            HomeScreenSearchBar(),
            Flexible(
              child: MovieListScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
