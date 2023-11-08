import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/util/categories.dart';
import '../../../domain/entity/app_event.dart';
import '../../../domain/entity/movie.dart';
import '../../bloc/favorites_bloc.dart';
import '../../view/app_movie_info_screen.dart';
import '../app_circular_progress_indicator.dart';
import '../home_screen/category_title.dart';
import '../home_screen/favorites_button.dart';
import '../home_screen/movie_card.dart';
import 'empty_favorite_movies_message.dart';

class FavoritesList extends StatefulWidget {
  static const double containerHeightDefaultValue = 558;
  static const double containerPadding = 10;
  static const int gridViewCrossAxisCount = 1;
  static const double listTitleFontSizeDefaultValue = 40;
  static const double posterImageWidth = 220;
  static const double posterImageHeight = 300;
  static const double sizedBoxHeight = 25;
  final double listTitleFontSize;
  final double containerHeight;

  const FavoritesList({
    this.containerHeight = containerHeightDefaultValue,
    this.listTitleFontSize = listTitleFontSizeDefaultValue,
    super.key,
  });

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    FavoritesBloc bloc = Provider.of<FavoritesBloc>(context);

    return Column(
      children: [
        CategoryTitle(
          title: Categories.favoriteMovies,
          titleFontSize: widget.listTitleFontSize,
        ),
        const SizedBox(
          height: FavoritesList.sizedBoxHeight,
        ),
        StreamBuilder(
          stream: bloc.allFavoriteMovies,
          builder: (
            BuildContext context,
            AsyncSnapshot<AppEvent> snapshot,
          ) {
            if (snapshot.data == null) {
              bloc.fetchFavoriteMovies();
            }

            if (snapshot.data?.status == Status.success) {
              List<Movie> movies = snapshot.data?.data;
              return SizedBox(
                height: widget.containerHeight,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: FavoritesList.gridViewCrossAxisCount,
                  ),
                  itemCount: movies.length,
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
                      child: Column(
                        children: [
                          MovieCard(
                            moviePosterUrl: movies[index].posterUrl,
                            imageWidth: FavoritesList.posterImageWidth,
                            imageHeight: FavoritesList.posterImageHeight,
                          ),
                          FavoriteButton(
                            attachedMovie: movies[index],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.data?.status == Status.error ||
                snapshot.data?.status == Status.empty) {
              return const EmptyFavoriteList();
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
        ),
      ],
    );
  }
}
