import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:the_movie_db_module2_part1/src/core/util/api_constants.dart';
import 'package:the_movie_db_module2_part1/src/core/util/data_state.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/app_event.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/movie.dart';
import 'package:the_movie_db_module2_part1/src/domain/usecase/implementation/movies_use_case.dart';
import 'package:the_movie_db_module2_part1/src/presentation/bloc/movies_bloc.dart';
import '../../mocks/movie_mocks.dart';

class MockedMoviesUseCase extends Mock implements MoviesUseCase {}

void main() async {
  const mockedEndpoint = 'mocked_endpoint';
  late MoviesBloc moviesBloc;
  late MockedMoviesUseCase mockedUseCase;

  setUp(
    () {
      mockedUseCase = MockedMoviesUseCase();
      moviesBloc = MoviesBloc(
        moviesUseCase: mockedUseCase,
      );
    },
  );

  group(
    'Movies BLoC testing',
    () {
      test(
        'fetchMovies() method is properly calling UseCase call() method',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) async => DataSuccess(
              MovieMocks.mockedMovieList,
            ),
          );

          moviesBloc.fetchMovies(mockedEndpoint);
          verify(() => mockedUseCase.call()).called(1);
        },
      );

      test(
        'movieBloc allPopularMovies get method,'
        'should stream an AppEvent instance',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) => Future.value(
              DataSuccess<List<Movie>>(
                MovieMocks.mockedMovieList,
              ),
            ),
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
            (_) => Future.value(
              DataSuccess<List<Movie>>(
                MovieMocks.mockedMovieList,
              ),
            ),
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
            (_) => Future.value(
              DataSuccess<List<Movie>>(
                MovieMocks.mockedMovieList,
              ),
            ),
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
            (_) => Future.value(
              DataError<List<Movie>>(
                Exception(
                  ApiConstants.errorMessage,
                ),
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
            (_) => Future.value(
              DataError<List<Movie>>(
                Exception(
                  ApiConstants.errorMessage,
                ),
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
            (_) => Future.value(
              DataError<List<Movie>>(
                Exception(
                  ApiConstants.errorMessage,
                ),
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
            (_) => Future.value(
              DataSuccess<List<Movie>>(
                MovieMocks.mockedMovieList,
              ),
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
