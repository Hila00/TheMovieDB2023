import 'package:flutter/material.dart';
import '/model/movie_data_model.dart';
import '/pages/movie_info_screen/genres_list_widget.dart';
import '/app_header.dart';
import 'related_genres_title.dart';
import 'movie_overview.dart';
import 'movie_info_container.dart';

class AppMovieInfo extends StatelessWidget {
  static const double sizedBoxHeight = 10;

  const AppMovieInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MovieDataModel movie =
        ModalRoute.of(context)?.settings.arguments as MovieDataModel;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const AppHeader(),
            Image.network(
              movie.backdropUrl,
            ),
            const RelatedGenresTitle(),
            GenresList(
              genresIds: movie.genreIds,
            ),
            const SizedBox(
              height: sizedBoxHeight,
            ),
            MovieInfoContainer(
              title: movie.title,
              posterUrl: movie.posterUrl,
              releaseDate: movie.releaseDate,
              voteAverage: movie.voteAverage,
            ),
            MovieOverview(
              overview: movie.overview,
            ),
          ],
        ),
      ),
    );
  }
}
