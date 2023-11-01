import 'dart:async';
import '../../core/bloc/i_movies_bloc.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/app_event.dart';
import '../../domain/usecase/usecase_interface.dart';

class MoviesBloc extends IMoviesBloc {
  IUseCase popularMoviesUseCase;
  IUseCase topRatedMoviesUseCase;
  IUseCase nowPlayingMoviesUseCase;
  IUseCase savedMoviesFromDbUseCase;

  MoviesBloc({
    required this.popularMoviesUseCase,
    required this.topRatedMoviesUseCase,
    required this.nowPlayingMoviesUseCase,
    required this.savedMoviesFromDbUseCase,
  });

  final _topRatedMoviesController = StreamController<AppEvent>.broadcast();
  final _popularMoviesController = StreamController<AppEvent>.broadcast();
  final _nowPlayingMoviesController = StreamController<AppEvent>.broadcast();
  final _savedMoviesFromDbController = StreamController<AppEvent>.broadcast();

  Stream<AppEvent> get allTopRatedMovies => _topRatedMoviesController.stream;

  Stream<AppEvent> get allPopularMovies => _popularMoviesController.stream;

  Stream<AppEvent> get allNowPlayingMovies =>
      _nowPlayingMoviesController.stream;

  Stream<AppEvent> get allSavedMoviesFromDb =>
      _savedMoviesFromDbController.stream;

  @override
  void dispose() {
    _topRatedMoviesController.close();
    _popularMoviesController.close();
    _nowPlayingMoviesController.close();
    _savedMoviesFromDbController.close();
  }

  @override
  void initialize() {
    // TODO: implement initialize
  }

  @override
  void fetchNowPlayingMovies() async {
    DataState nowPlayingMoviesState = await nowPlayingMoviesUseCase.call();

    if (nowPlayingMoviesState is DataSuccess) {
      _nowPlayingMoviesController.sink.add(
        AppEvent(
          status: nowPlayingMoviesState.data.isNotEmpty
              ? Status.success
              : Status.empty,
          data: nowPlayingMoviesState.data,
        ),
      );
    } else {
      _nowPlayingMoviesController.sink.add(
        AppEvent(
          status: Status.error,
        ),
      );
    }
  }

  @override
  void fetchPopularMovies() async {
    DataState popularMoviesState = await popularMoviesUseCase.call();

    if (popularMoviesState is DataSuccess) {
      _popularMoviesController.sink.add(
        AppEvent(
          status: popularMoviesState.data.isNotEmpty
              ? Status.success
              : Status.empty,
          data: popularMoviesState.data,
        ),
      );
    } else {
      _popularMoviesController.sink.add(
        AppEvent(
          status: Status.error,
        ),
      );
    }
  }

  @override
  void fetchTopRatedMovies() async {
    DataState topRatedMoviesState = await topRatedMoviesUseCase.call();

    if (topRatedMoviesState is DataSuccess) {
      _topRatedMoviesController.sink.add(
        AppEvent(
          status: topRatedMoviesState.data.isNotEmpty
              ? Status.success
              : Status.empty,
          data: topRatedMoviesState.data,
        ),
      );
    } else {
      _topRatedMoviesController.sink.add(
        AppEvent(
          status: Status.error,
        ),
      );
    }
  }

  @override
  void fetchSavedMoviesFromDb() async {
    DataState savedMoviesFromDbState = await savedMoviesFromDbUseCase.call();

    if (savedMoviesFromDbState is DataSuccess) {
      _savedMoviesFromDbController.sink.add(
        AppEvent(
          status: savedMoviesFromDbState.data.isNotEmpty
              ? Status.success
              : Status.empty,
          data: savedMoviesFromDbState.data,
        ),
      );
    } else {
      _savedMoviesFromDbController.sink.add(
        AppEvent(
          status: Status.error,
        ),
      );
    }
  }
}
