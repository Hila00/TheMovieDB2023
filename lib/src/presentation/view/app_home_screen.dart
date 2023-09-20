import 'package:flutter/material.dart';
import '../../core/util/api_constants.dart';
import '../../core/util/categories.dart';
import '../../data/datasource/remote/api_movie_service.dart';
import '../../data/repository/movie_repository_impl.dart';
import '../../domain/usecase/implementation/movies_use_case.dart';
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

  final MoviesBloc bloc = MoviesBloc(
    popularMoviesUseCase: MoviesUseCase(
      movieRepository: MovieRepositoryImpl(
        movieService:
            ApiMovieService(endPoint: ApiConstants.popularMoviesEndPoint),
      ),
    ),
    topRatedMoviesUseCase: MoviesUseCase(
      movieRepository: MovieRepositoryImpl(
        movieService:
            ApiMovieService(endPoint: ApiConstants.topRatedMoviesEndPoint),
      ),
    ),
    nowPlayingMoviesUseCase: MoviesUseCase(
      movieRepository: MovieRepositoryImpl(
        movieService:
            ApiMovieService(endPoint: ApiConstants.nowPlayingMoviesEndPoint),
      ),
    ),
  );

  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    widget.bloc.fetchNowPlayingMovies();
    widget.bloc.fetchPopularMovies();
    widget.bloc.fetchTopRatedMovies();
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    moviesStream: widget.bloc.allTopRatedMovies,
                    moviesBloc: widget.bloc,
                  ),
                  const SizedBox(
                    height: HomeScreen.sizedBoxSize,
                  ),
                  const CategoryOutstandingTitle(
                    title: Categories.popular,
                  ),
                  MovieListWidget(
                    moviesStream: widget.bloc.allPopularMovies,
                    moviesBloc: widget.bloc,
                    containerHeight: HomeScreen.outstandingListHeight,
                  ),
                  const CategoryTitle(
                    title: Categories.nowPlaying,
                  ),
                  MovieListWidget(
                    moviesStream: widget.bloc.allNowPlayingMovies,
                    moviesBloc: widget.bloc,
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
