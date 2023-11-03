import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';

import '../../core/util/api_constants.dart';
import '../../core/util/categories.dart';
import '../../core/util/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    MoviesBloc bloc = Provider.of<MoviesBloc>(context);
    Future<ConnectivityResult> connectivity =
        Connectivity().checkConnectivity();

    return Scaffold(
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppHeader(),
              const HomeScreenSearchBar(),
              FutureBuilder(
                future: connectivity,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<ConnectivityResult> snapshot,
                ) {
                  if (snapshot.data == ConnectivityResult.none) {
                    return Column(
                      children: [
                        const Icon(
                          Icons.wifi_off,
                          color: Color(AppConstants.appFontColor),
                          size: HomeScreen.wifiOffIconSize,
                        ),
                        MovieListWidget(
                          moviesStream: bloc.allSavedMoviesFromDb,
                          moviesBloc: bloc,
                          endPoint: Categories.savedMovies,
                          categoryTitle: Categories.savedMovies,
                        ),
                      ],
                    );
                  } else {
                    return Column(
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
                          containerHeight: HomeScreen.outstandingListHeight,
                          listTitleFontSize:
                              HomeScreen.outStandingTitleListFontSize,
                          categoryTitle: Categories.popular,
                        ),
                        MovieListWidget(
                          moviesStream: bloc.allNowPlayingMovies,
                          endPoint: ApiConstants.nowPlayingMoviesEndPoint,
                          moviesBloc: bloc,
                          categoryTitle: Categories.nowPlaying,
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
