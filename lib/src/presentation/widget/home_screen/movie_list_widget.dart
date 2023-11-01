import 'package:flutter/material.dart';
import '../../../core/bloc/i_movies_bloc.dart';
import '../../../core/util/categories.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/error_message_widget.dart';
import '../../../domain/entity/app_event.dart';
import '../../../domain/entity/movie.dart';
import '../../view/app_movie_info_screen.dart';
import '../app_circular_progress_indicator.dart';
import 'movie_card.dart';

class MovieListWidget extends StatelessWidget {
  static const double containerHeightDefaultValue = 300;
  static const double containerPadding = 10;
  static const int gridViewCrossAxisCount = 1;
  final double containerHeight;
  final IMoviesBloc moviesBloc;
  final Stream<AppEvent> moviesStream;
  final String? type;

  const MovieListWidget({
    this.containerHeight = containerHeightDefaultValue,
    this.type,
    required this.moviesBloc,
    required this.moviesStream,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: moviesStream,
      builder: (
        BuildContext context,
        AsyncSnapshot<AppEvent> snapshot,
      ) {
        if (snapshot.data == null) {
          switch (type) {
            case Categories.topRated:
              {
                moviesBloc.fetchTopRatedMovies();
                break;
              }
            case Categories.nowPlaying:
              {
                moviesBloc.fetchNowPlayingMovies();
                break;
              }
            case Categories.popular:
              {
                moviesBloc.fetchPopularMovies();
                break;
              }
            case Categories.savedMovies:
              {
                moviesBloc.fetchSavedMoviesFromDb();
                break;
              }
          }
        }

        if (snapshot.data?.status == Status.success) {
          List<Movie> movies = snapshot.data?.data;

          return Container(
            height: containerHeight,
            color: const Color(AppConstants.appItemsBackgroundColor),
            padding: const EdgeInsets.all(containerPadding),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridViewCrossAxisCount,
              ),
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => AppMovieInfo(
                          movie: movies[index],
                        ),
                      ),
                    );
                  },
                  child: MovieCard(
                    moviePosterUrl: movies[index].posterUrl,
                  ),
                );
              },
            ),
          );
        } else if (snapshot.data?.status == Status.error ||
            snapshot.data?.status == Status.empty) {
          return const ErrorMessage();
        } else {
          return const CustomCircularProgressIndicator();
        }
      },
    );
  }
}
