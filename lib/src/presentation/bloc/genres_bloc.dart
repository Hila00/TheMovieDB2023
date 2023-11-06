import 'dart:async';

import '../../core/bloc/i_bloc.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/app_event.dart';
import '../../domain/entity/genre.dart';
import '../../domain/usecase/usecase_interface.dart';

class GenresBloc extends IBloc {
  IUseCase genresUseCase;

  GenresBloc({
    required this.genresUseCase,
  });

  final _genresController = StreamController<AppEvent>.broadcast();

  Stream<AppEvent> get allGenres => _genresController.stream;

  @override
  void dispose() {
    _genresController.close();
  }

  @override
  void initialize() {
    // TODO: implement initialize
  }

  void fetchAllGenres() async {
    DataState dataState = await genresUseCase.call();
    if (dataState is DataSuccess) {
      _genresController.sink.add(
        AppEvent(
          status: dataState.data.isNotEmpty ? Status.success : Status.empty,
          data: dataState.data,
        ),
      );
    } else if (dataState is DataError) {
      _genresController.sink.add(
        AppEvent(
          status: Status.error,
        ),
      );
    }
  }

  List<String> getRelatedGenres(
    List<Genre> genres,
    List<int> movieGenresIds,
  ) {
    List<String> movieRelatedGenres = [];
    movieRelatedGenres = genres
        .where(
          (genre) => movieGenresIds.contains(genre.id),
        )
        .map((genre) => genre.name)
        .toList();

    return movieRelatedGenres;
  }
}
