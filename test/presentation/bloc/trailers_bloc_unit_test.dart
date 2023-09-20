import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db_module2_part1/src/core/util/api_constants.dart';
import 'package:the_movie_db_module2_part1/src/core/util/data_state.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/app_event.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/movie.dart';
import 'package:the_movie_db_module2_part1/src/presentation/bloc/trailers_screen_bloc.dart';
import '../../mocks/movie_mocks.dart';
import 'movies_bloc_unit_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late TrailersBloc trailersBloc;
  late MockedMoviesUseCase mockedUseCase;

  setUp(
    () {
      mockedUseCase = MockedMoviesUseCase();
      trailersBloc = TrailersBloc(
        useCase: mockedUseCase,
      );
    },
  );

  group(
    'Trailers BLoC testing',
    () {
      test(
        'fetchAllTrailers() is calling properly UseCase call() method',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) async => DataSuccess(
              MovieMocks.mockedMovieList,
            ),
          );

          trailersBloc.fetchAllTrailers();
          verify(() => mockedUseCase.call()).called(1);
        },
      );

      test(
        'trailersBloc allTrailers get method,'
        'should stream an AppEvent instance',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) => DataState,
          );
          StreamSubscription<AppEvent> subscription;
          subscription = trailersBloc.allTrailers.listen(
            (moviesState) {
              expect(moviesState, isA<AppEvent>());
            },
          );
          subscription.cancel();
        },
      );

      test(
        'trailersBloc receives a DataError from use case,'
        'should stream an Error AppEvent',
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
          subscription = trailersBloc.allTrailers.listen(
            (movieState) {
              expect(movieState, isA<DataError>);
              expect(movieState.status, Status.error);
            },
          );
          subscription.cancel();
        },
      );

      test(
        'trailersBloc receives a DataSuccess from use case,'
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
          subscription = trailersBloc.allTrailers.listen(
            (moviesState) {
              expect(moviesState.data, isNotEmpty);
              expect(moviesState.data, isA<List<Movie>>());
              expect(moviesState.status, Status.success);
            },
          );
          subscription.cancel();
        },
      );
    },
  );
}
