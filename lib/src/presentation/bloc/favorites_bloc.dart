import 'dart:async';

import '../../core/bloc/i_bloc.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/app_event.dart';
import '../../domain/entity/movie.dart';
import '../../domain/usecase/usecase_interface.dart';

class FavoritesBloc extends IBloc {
  IUseCase favoriteMoviesUseCase;
  IUseCase addFavoriteUseCase;
  IUseCase removeFavoriteUseCase;

  FavoritesBloc({
    required this.favoriteMoviesUseCase,
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
  });

  final _favoriteMoviesController = StreamController<AppEvent>.broadcast();

  Stream<AppEvent> get allFavoriteMovies => _favoriteMoviesController.stream;

  @override
  void dispose() {
    _favoriteMoviesController.close();
  }

  @override
  void initialize() {
    // TODO: implement initialize
  }

  void fetchFavoriteMovies() async {
    DataState dataState = await favoriteMoviesUseCase.call();

    if (dataState is DataSuccess) {
      _favoriteMoviesController.sink.add(
        AppEvent(
          status: dataState.data.isNotEmpty ? Status.success : Status.empty,
          data: dataState.data,
        ),
      );
    } else {
      _favoriteMoviesController.sink.add(
        AppEvent(
          status: Status.error,
        ),
      );
    }
  }

  void addMovieToFavorites(Movie favMovie) {
    addFavoriteUseCase.call(favMovie);
  }

  void removeMovieFromFavorites(Movie movieToRemove) {
    removeFavoriteUseCase.call(movieToRemove);
  }
}
