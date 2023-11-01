import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db_module2_part1/src/core/util/api_constants.dart';
import 'package:the_movie_db_module2_part1/src/core/util/data_state.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/app_event.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/movie.dart';
import 'package:the_movie_db_module2_part1/src/domain/usecase/usecase_interface.dart';
import 'package:the_movie_db_module2_part1/src/presentation/bloc/movies_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/movie_mocks.dart';

class MockedMoviesUseCase extends Mock implements IUseCase {}

void main() async {
  late MoviesBloc moviesBloc;
  late MockedMoviesUseCase mockedUseCase;

  setUp(
    () {
      mockedUseCase = MockedMoviesUseCase();
      moviesBloc = MoviesBloc(
        popularMoviesUseCase: mockedUseCase,
        topRatedMoviesUseCase: mockedUseCase,
        nowPlayingMoviesUseCase: mockedUseCase,
        savedMoviesFromDbUseCase: mockedUseCase,
      );
    },
  );

  group(
    'Movies BLoC testing',
    () {
      test(
        'fetch() methods are properly calling UseCase call() method',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) async => DataSuccess(
              MovieMocks.mockedMovieList,
            ),
          );

          moviesBloc.fetchNowPlayingMovies();
          moviesBloc.fetchPopularMovies();
          moviesBloc.fetchTopRatedMovies();
          verify(() => mockedUseCase.call()).called(3);
        },
      );

      test(
        'movieBloc allPopularMovies get method,'
        'should stream an AppEvent instance',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) => DataState,
          );
          StreamSubscription<AppEvent> subscription;
          subscription = moviesBloc.allPopularMovies.listen(
            (moviesState) {
              expect(moviesState, isA<AppEvent>());
            },
          );
          subscription.cancel();
        },
      );

      test(
        'movieBloc allTopRatedMovies get method,'
        'should stream an AppEvent instance',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) => DataState,
          );
          StreamSubscription<AppEvent> subscription;
          subscription = moviesBloc.allTopRatedMovies.listen(
            (moviesState) {
              expect(moviesState, isA<AppEvent>());
            },
          );
          subscription.cancel();
        },
      );

      test(
        'movieBloc allNowPlayingMovies get method,'
        'should stream an AppEvent instance',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) => DataState,
          );
          StreamSubscription<AppEvent> subscription;
          subscription = moviesBloc.allNowPlayingMovies.listen(
            (moviesState) {
              expect(moviesState, isA<AppEvent>());
            },
          );
          subscription.cancel();
        },
      );

      test(
        'movieBloc receives a DataError from use case,'
        'popularMovies stream should stream an AppEvent error',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) => DataError(
              Exception(
                ApiConstants.errorMessage,
              ),
            ),
          );
          StreamSubscription<AppEvent> subscription;
          subscription = moviesBloc.allPopularMovies.listen(
            (movieState) {
              expect(movieState, isA<AppEvent>);
              expect(movieState.status, Status.error);
            },
          );
          subscription.cancel();
        },
      );

      test(
        'movieBloc receives a DataError from use case,'
        'topRatedMovies stream should stream an AppEvent error',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) => DataError(
              Exception(
                ApiConstants.errorMessage,
              ),
            ),
          );
          StreamSubscription<AppEvent> subscription;
          subscription = moviesBloc.allTopRatedMovies.listen(
            (movieState) {
              expect(movieState, isA<AppEvent>);
              expect(movieState.status, Status.error);
            },
          );
          subscription.cancel();
        },
      );

      test(
        'movieBloc receives a DataError from use case,'
        'nowPlayingMovies stream should stream an AppEvent error',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) => DataError(
              Exception(
                ApiConstants.errorMessage,
              ),
            ),
          );
          StreamSubscription<AppEvent> subscription;
          subscription = moviesBloc.allNowPlayingMovies.listen(
            (movieState) {
              expect(movieState, isA<AppEvent>);
              expect(movieState.status, Status.error);
            },
          );
          subscription.cancel();
        },
      );

      test(
        'movieBloc receives a DataSuccess from use case,'
        'streamed success AppEvent<List<Movie> should have items',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) => DataSuccess<List<Movie>>(
              MovieMocks.mockedMovieList,
            ),
          );
          StreamSubscription<AppEvent> subscription;
          subscription = moviesBloc.allPopularMovies.listen(
            (moviesState) {
              List<Movie> movies = moviesState.data;
              expect(moviesState.status, Status.success);
              expect(movies, isA<List<Movie>>());
              expect(movies.first, isA<Movie>());
            },
          );
          subscription.cancel();
        },
      );
    },
  );
}
