import 'package:flutter/material.dart';
import '../../domain/entity/movie.dart';
import '../widget/movie_info_screen/genres_list_widget.dart';
import '../widget/app_header.dart';
import '../widget/movie_info_screen/related_genres_title.dart';
import '../widget/movie_info_screen/movie_overview.dart';
import '../widget/movie_info_screen/movie_info_container.dart';

class AppMovieInfo extends StatelessWidget {
  static const double sizedBoxHeight = 10;

  const AppMovieInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;

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
