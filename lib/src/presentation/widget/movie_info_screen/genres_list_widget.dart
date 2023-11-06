import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../core/util/constants.dart';
import '../../../domain/entity/app_event.dart';
import '../../../domain/entity/genre.dart';
import '../../bloc/genres_bloc.dart';
import '../app_circular_progress_indicator.dart';
import '../custom_text_widget.dart';

class GenresList extends StatefulWidget {
  static const double containerBorderRadius = 15;
  static const double containerPadding = 5;
  static const double containerMargin = 6;
  static const double itemsFontSize = 15;
  static const String errorMessage = 'Error: failed to load genres';
  final List<int> genresIds;

  const GenresList({
    required this.genresIds,
    super.key,
  });

  @override
  State<GenresList> createState() => _GenresListState();
}

class _GenresListState extends State<GenresList> {
  @override
  Widget build(BuildContext context) {
    GenresBloc bloc = Provider.of<GenresBloc>(context);

    return StreamBuilder(
      stream: bloc.allGenres,
      builder: (
        BuildContext context,
        AsyncSnapshot<AppEvent> snapshot,
      ) {
        if (snapshot.data == null) {
          bloc.fetchAllGenres();
        }

        if (snapshot.data?.status == Status.success) {
          AppEvent? dataSuccess = snapshot.data;
          List<Genre> genres = dataSuccess?.data;
          List<String> movieRelatedGenres =
              bloc.getRelatedGenres(genres, widget.genresIds);

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
                        GenresList.containerBorderRadius,
                      ),
                    ),
                    padding: const EdgeInsets.all(
                      GenresList.containerPadding,
                    ),
                    margin: const EdgeInsets.all(
                      GenresList.containerMargin,
                    ),
                    child: CustomText(
                      text: genre,
                      fontSize: GenresList.itemsFontSize,
                    ),
                  ),
              ],
            ),
          );
        } else if (snapshot.data?.status == Status.error ||
            snapshot.data?.status == Status.empty) {
          return const Center(
            child: CustomText(
              text: GenresList.errorMessage,
            ),
          );
        } else {
          return const Center(
            child: CustomCircularProgressIndicator(),
          );
        }
      },
    );
  }
}
