import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/util/constants.dart';
import '../../data/datasource/remote/api_genres_service.dart';
import '../../data/repository/genre_repository_impl.dart';
import '../../domain/entity/movie.dart';
import '../../domain/usecase/implementation/genres_use_case.dart';
import '../bloc/genres_bloc.dart';
import '../widget/app_circular_progress_indicator.dart';
import '../widget/app_drawer.dart';
import '../widget/movie_info_screen/genres_list_widget.dart';
import '../widget/app_header.dart';
import '../widget/movie_info_screen/related_genres_title.dart';
import '../widget/movie_info_screen/movie_overview.dart';
import '../widget/movie_info_screen/movie_info_container.dart';

class AppMovieInfo extends StatelessWidget {
  static const double sizedBoxHeight = 10;
  final GenresBloc genresBloc = GenresBloc(
    genresUseCase: GenresUseCase(
      genreRepository: GenreRepositoryImpl(
        genresService: ApiGenresService(),
      ),
    ),
  );
  final Movie movie;

  AppMovieInfo({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: SafeArea(
        child: ListView(
          children: [
            const AppHeader(),
            CachedNetworkImage(
              imageUrl: movie.backdropUrl,
              placeholder: (
                BuildContext context,
                String url,
              ) =>
                  const Center(
                child: CustomCircularProgressIndicator(),
              ),
              errorWidget: (
                BuildContext context,
                String url,
                error,
              ) =>
                  const Icon(
                Icons.error,
                color: Color(AppConstants.appFontColor),
              ),
            ),
            const RelatedGenresTitle(),
            GenresList(
              bloc: genresBloc,
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
