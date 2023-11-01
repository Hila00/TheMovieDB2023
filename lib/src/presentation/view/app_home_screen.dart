import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/util/categories.dart';
import '../../core/util/constants.dart';
import '../bloc/movies_bloc.dart';
import '../widget/app_drawer.dart';
import '../widget/app_header.dart';
import '../widget/home_screen/category_title.dart';
import '../widget/home_screen/category_outstanding_title.dart';
import '../widget/home_screen/home_search_bar.dart';
import '../widget/home_screen/movie_list_widget.dart';

class HomeScreen extends StatefulWidget {
  static const double sizedBoxSize = 12;
  static const double outstandingListHeight = 450;
  static const double errorMessageFontSize = 20;
  static const double wifiOffIconSize = 50;

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
                        const CategoryOutstandingTitle(
                          title: Categories.savedMovies,
                        ),
                        MovieListWidget(
                          moviesStream: bloc.allSavedMoviesFromDb,
                          moviesBloc: bloc,
                          type: Categories.savedMovies,
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        const CategoryTitle(title: Categories.topRated),
                        MovieListWidget(
                          moviesStream: bloc.allTopRatedMovies,
                          moviesBloc: bloc,
                          type: Categories.topRated,
                        ),
                        const SizedBox(
                          height: HomeScreen.sizedBoxSize,
                        ),
                        const CategoryOutstandingTitle(
                          title: Categories.popular,
                        ),
                        MovieListWidget(
                          moviesStream: bloc.allPopularMovies,
                          moviesBloc: bloc,
                          type: Categories.popular,
                          containerHeight: HomeScreen.outstandingListHeight,
                        ),
                        const CategoryTitle(
                          title: Categories.nowPlaying,
                        ),
                        MovieListWidget(
                          moviesStream: bloc.allNowPlayingMovies,
                          type: Categories.nowPlaying,
                          moviesBloc: bloc,
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
