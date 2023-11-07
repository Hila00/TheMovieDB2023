import 'package:flutter/material.dart';

import '../../../core/bloc/i_movies_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/error_message_widget.dart';
import '../../../domain/entity/app_event.dart';
import '../../../domain/entity/movie.dart';
import '../../view/app_movie_info_screen.dart';
import '../app_circular_progress_indicator.dart';
import 'category_title.dart';
import 'favorites_button.dart';
import 'movie_card.dart';

class MovieListWidget extends StatefulWidget {
  static const double containerHeightDefaultValue = 300;
  static const double containerPadding = 10;
  static const int gridViewCrossAxisCount = 1;
  static const double listTitleFontSizeDefaultValue = 30;
  final double listTitleFontSize;
  final double containerHeight;
  final String categoryTitle;
  final IMoviesBloc moviesBloc;
  final Stream<AppEvent> moviesStream;
  final String endPoint;

  const MovieListWidget({
    this.containerHeight = containerHeightDefaultValue,
    this.listTitleFontSize = listTitleFontSizeDefaultValue,
    required this.endPoint,
    required this.moviesBloc,
    required this.moviesStream,
    required this.categoryTitle,
    super.key,
  });

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.moviesStream,
      builder: (
        BuildContext context,
        AsyncSnapshot<AppEvent> snapshot,
      ) {
        if (snapshot.data == null) {
          widget.moviesBloc.fetchMovies(widget.endPoint);
        }

        if (snapshot.data?.status == Status.success) {
          List<Movie> movies = snapshot.data?.data;

          return Column(
            children: [
              CategoryTitle(
                title: widget.categoryTitle,
                titleFontSize: widget.listTitleFontSize,
              ),
              Container(
                height: widget.containerHeight,
                color: const Color(AppConstants.appItemsBackgroundColor),
                padding: const EdgeInsets.all(MovieListWidget.containerPadding),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MovieListWidget.gridViewCrossAxisCount,
                  ),
                  itemCount: movies.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return Column(
                      children: [
                        GestureDetector(
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
                        ),
                        const FavoriteButton(),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.data?.status == Status.error ||
            snapshot.data?.status == Status.empty) {
          return const ErrorMessage();
        } else {
          return Column(
            children: [
              const Center(
                child: CustomCircularProgressIndicator(),
              ),
              SizedBox(
                height: widget.containerHeight,
              ),
            ],
          );
        }
      },
    );
  }
}
