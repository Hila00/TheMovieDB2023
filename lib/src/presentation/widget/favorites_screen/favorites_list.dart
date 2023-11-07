import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/util/constants.dart';
import '../../../core/util/error_message_widget.dart';
import '../../../domain/entity/app_event.dart';
import '../../../domain/entity/movie.dart';
import '../../bloc/favorites_bloc.dart';
import '../../view/app_movie_info_screen.dart';
import '../app_circular_progress_indicator.dart';
import '../home_screen/category_title.dart';
import '../home_screen/movie_card.dart';

class FavoritesList extends StatefulWidget {
  static const double containerHeightDefaultValue = 700;
  static const double containerPadding = 10;
  static const int gridViewCrossAxisCount = 2;
  static const double listTitleFontSizeDefaultValue = 40;
  static const double posterImageWidth = 220;
  static const double posterImageHeight = 270;
  final double listTitleFontSize;
  final double containerHeight;
  final String categoryTitle;

  const FavoritesList({
    this.containerHeight = containerHeightDefaultValue,
    this.listTitleFontSize = listTitleFontSizeDefaultValue,
    required this.categoryTitle,
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
          title: widget.categoryTitle,
          titleFontSize: widget.listTitleFontSize,
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

            print(snapshot.data);

            if (snapshot.data?.status == Status.success) {
              List<Movie> movies = snapshot.data?.data;

              return Column(
                children: [
                  Container(
                    height: widget.containerHeight,
                    color: const Color(AppConstants.appItemsBackgroundColor),
                    padding:
                        const EdgeInsets.all(FavoritesList.containerPadding),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: FavoritesList.gridViewCrossAxisCount,
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
                                    builder: (BuildContext context) =>
                                        AppMovieInfo(
                                      movie: movies[index],
                                    ),
                                  ),
                                );
                              },
                              child: MovieCard(
                                moviePosterUrl: movies[index].posterUrl,
                                imageWidth: FavoritesList.posterImageWidth,
                                imageHeight: FavoritesList.posterImageHeight,
                              ),
                            ),
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
        ),
      ],
    );
  }
}
