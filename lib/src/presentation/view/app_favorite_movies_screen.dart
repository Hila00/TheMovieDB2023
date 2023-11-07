import 'package:flutter/material.dart';

import '../../config/route/app_routes.dart';
import '../widget/app_drawer.dart';
import '../widget/app_header.dart';
import '../widget/favorites_screen/favorites_list.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  static const int refreshIndicatorTimeInSeconds = 0;

  const FavoriteMoviesScreen({super.key});

  @override
  State<FavoriteMoviesScreen> createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refresh() {
    return Future.delayed(
      const Duration(
        seconds: FavoriteMoviesScreen.refreshIndicatorTimeInSeconds,
      ),
      () {
        Navigator.pushNamed(
          context,
          AppRoutes.favoritesRoute,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppHeader(),
                FavoritesList(
                  categoryTitle: 'Favorite movies',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
