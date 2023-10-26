import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/util/categories.dart';
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

    return Scaffold(
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppHeader(),
              const HomeScreenSearchBar(),
              Column(
                children: [
                  const CategoryTitle(title: Categories.topRated),
                  MovieListWidget(
                    moviesStream: bloc.allTopRatedMovies,
                    moviesBloc: bloc,
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
                    containerHeight: HomeScreen.outstandingListHeight,
                  ),
                  const CategoryTitle(
                    title: Categories.nowPlaying,
                  ),
                  MovieListWidget(
                    moviesStream: bloc.allNowPlayingMovies,
                    moviesBloc: bloc,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
