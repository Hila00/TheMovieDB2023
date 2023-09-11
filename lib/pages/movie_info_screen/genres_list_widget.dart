import 'package:flutter/material.dart';
import '/custom_text_widget.dart';
import '/model/genre_data_model.dart';
import '/repository/genre_repository.dart';
import '/constants.dart';

class GenresList extends StatelessWidget {
  static const double containerBorderRadius = 15;
  static const double containerPadding = 5;
  static const double containerMargin = 6;
  static const double itemsFontSize = 15;
  final List<num> genresIds;
  GenreRepository genreRepository = GenreRepository();

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
        AsyncSnapshot<List<GenreDataModel>> data,
      ) {
        if (data.hasError) {
          return Text('${data.error}');
        } else if (data.hasData) {
          List<GenreDataModel> genres = data.data as List<GenreDataModel>;
          List<String> movieRelatedGenres = GenreRepository().getRelatedGenres(
            genres,
            genresIds,
          );

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
