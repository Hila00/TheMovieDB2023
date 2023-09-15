import 'package:flutter/material.dart';
import '../../../domain/repository/i_repository.dart';
import '../custom_text_widget.dart';
import '../../../domain/entity/genre.dart';
import '../../../data/repository/genre_repository_impl.dart';
import '../../../core/util/constants.dart';

class GenresList extends StatelessWidget {
  static const double containerBorderRadius = 15;
  static const double containerPadding = 5;
  static const double containerMargin = 6;
  static const double itemsFontSize = 15;
  final List<num> genresIds;
  IRepository<List<Genre>> genreRepository = GenreRepositoryImpl();

  GenresList({
    required this.genresIds,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: genreRepository.getData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Genre>> data,
      ) {
        if (data.hasError) {
          return Text('${data.error}');
        } else if (data.hasData) {
          List<Genre> genres = data.data as List<Genre>;
          List<String> movieRelatedGenres =
              GenreRepositoryImpl().getRelatedGenres(genres, genresIds);

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (String genre in movieRelatedGenres)
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(
                        AppConstants.appItemsBackgroundColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        containerBorderRadius,
                      ),
                    ),
                    padding: const EdgeInsets.all(
                      containerPadding,
                    ),
                    margin: const EdgeInsets.all(
                      containerMargin,
                    ),
                    child: CustomText(
                      text: genre,
                      fontSize: itemsFontSize,
                    ),
                  ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
