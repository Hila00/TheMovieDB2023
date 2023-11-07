import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../config/route/app_routes.dart';
import '../../core/util/api_constants.dart';
import '../../core/util/categories.dart';
import '../bloc/movies_bloc.dart';
import '../widget/app_drawer.dart';
import '../widget/app_header.dart';
import '../widget/home_screen/home_search_bar.dart';
import '../widget/home_screen/movie_list_widget.dart';

class HomeScreen extends StatefulWidget {
  static const double sizedBoxSize = 12;
  static const double outstandingListHeight = 450;
  static const double errorMessageFontSize = 20;
  static const double wifiOffIconSize = 50;
  static const double outStandingTitleListFontSize = 40;
  static const int refreshIndicatorTimeInSeconds = 0;

  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        seconds: HomeScreen.refreshIndicatorTimeInSeconds,
      ),
      () {
        Navigator.pushNamed(
          context,
          AppRoutes.homeScreenRoute,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MoviesBloc bloc = Provider.of<MoviesBloc>(context);

    return Scaffold(
      drawer: const AppDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AppHeader(),
                const HomeScreenSearchBar(),
                Column(
                  children: [
                    MovieListWidget(
                      moviesStream: bloc.allTopRatedMovies,
                      moviesBloc: bloc,
                      endPoint: ApiConstants.topRatedMoviesEndPoint,
                      categoryTitle: Categories.topRated,
                    ),
                    const SizedBox(
                      height: HomeScreen.sizedBoxSize,
                    ),
                    MovieListWidget(
                      moviesStream: bloc.allPopularMovies,
                      moviesBloc: bloc,
                      endPoint: ApiConstants.popularMoviesEndPoint,
                      categoryTitle: Categories.popular,
                    ),
                    MovieListWidget(
                      moviesStream: bloc.allNowPlayingMovies,
                      endPoint: ApiConstants.nowPlayingMoviesEndPoint,
                      moviesBloc: bloc,
                      categoryTitle: Categories.nowPlaying,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
