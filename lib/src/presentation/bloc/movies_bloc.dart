import 'dart:async';

import '../../core/bloc/i_movies_bloc.dart';
import '../../core/util/api_constants.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/app_event.dart';
import '../../domain/usecase/implementation/movies_use_case.dart';

class MoviesBloc extends IMoviesBloc {
  MoviesUseCase moviesUseCase;

  MoviesBloc({
    required this.moviesUseCase,
  });

  final _topRatedMoviesController = StreamController<AppEvent>.broadcast();
  final _popularMoviesController = StreamController<AppEvent>.broadcast();
  final _nowPlayingMoviesController = StreamController<AppEvent>.broadcast();

  Stream<AppEvent> get allTopRatedMovies => _topRatedMoviesController.stream;

  Stream<AppEvent> get allPopularMovies => _popularMoviesController.stream;

  Stream<AppEvent> get allNowPlayingMovies =>
      _nowPlayingMoviesController.stream;

  @override
  void dispose() {
    _topRatedMoviesController.close();
    _popularMoviesController.close();
    _nowPlayingMoviesController.close();
  }

  @override
  void initialize() {
    // TODO: implement initialize
  }

  @override
  void fetchMovies(String endPoint) async {
    switch (endPoint) {
      case ApiConstants.topRatedMoviesEndPoint:
        {
          moviesUseCase.categoryEndPoint = ApiConstants.topRatedMoviesEndPoint;
          DataState topRatedMoviesState = await moviesUseCase.call();
          _topRatedMoviesController.sink.add(
            _getMoviesStatusOnEvent(topRatedMoviesState),
          );
        }
      case ApiConstants.popularMoviesEndPoint:
        {
          moviesUseCase.categoryEndPoint = ApiConstants.popularMoviesEndPoint;
          DataState popularMoviesState = await moviesUseCase.call();
          _popularMoviesController.sink.add(
            _getMoviesStatusOnEvent(popularMoviesState),
          );
        }
      case ApiConstants.nowPlayingMoviesEndPoint:
        {
          moviesUseCase.categoryEndPoint =
              ApiConstants.nowPlayingMoviesEndPoint;
          DataState nowPlayingMoviesState = await moviesUseCase.call();
          _nowPlayingMoviesController.sink.add(
            _getMoviesStatusOnEvent(nowPlayingMoviesState),
          );
        }
    }
  }

  AppEvent _getMoviesStatusOnEvent(DataState moviesDataState) {
    if (moviesDataState is DataSuccess) {
      return AppEvent(
        status: moviesDataState.data.isNotEmpty ? Status.success : Status.empty,
        data: moviesDataState.data,
      );
    } else {
      return AppEvent(
        status: Status.error,
      );
    }
  }
}
