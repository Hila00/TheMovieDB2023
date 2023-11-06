import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:the_movie_db_module2_part1/src/core/util/api_constants.dart';
import 'package:the_movie_db_module2_part1/src/core/util/data_state.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/app_event.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/genre.dart';
import 'package:the_movie_db_module2_part1/src/domain/usecase/usecase_interface.dart';
import 'package:the_movie_db_module2_part1/src/presentation/bloc/genres_bloc.dart';
import '../../mocks/genre_mocks.dart';

class MockedGenresUseCase extends Mock implements IUseCase {}

void main() async {
  late GenresBloc genresBloc;
  late MockedGenresUseCase mockedUseCase;

  setUp(
    () {
      mockedUseCase = MockedGenresUseCase();
      genresBloc = GenresBloc(genresUseCase: mockedUseCase);
    },
  );

  group(
    'Genres BLoC testing',
    () {
      test(
        'fetchAllGenres() is calling properly UseCase call() method',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) async => DataSuccess(
              GenreMocks.mockedGenreList,
            ),
          );

          genresBloc.fetchAllGenres();
          verify(() => mockedUseCase.call()).called(1);
        },
      );

      test(
        'genresBloc allGenres get method,'
        'should stream an AppEvent instance',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) => DataState,
          );
          StreamSubscription<AppEvent> subscription;
          subscription = genresBloc.allGenres.listen(
            (genresState) {
              expect(genresState, isA<AppEvent>());
            },
          );
          subscription.cancel();
        },
      );

      test(
        'genresBloc receives a DataError from use case,'
        'should stream an AppEvent error',
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
          subscription = genresBloc.allGenres.listen(
            (genresState) {
              expect(genresState, isA<AppEvent>);
              expect(genresState.status, Status.error);
            },
          );
          subscription.cancel();
        },
      );

      test(
        'genresBloc receives a DataSuccess from use case,'
        'streamed AppEvent<List<Genre>> should have items',
        () async {
          when(
            () => mockedUseCase.call(),
          ).thenAnswer(
            (_) => DataSuccess<List<Genre>>(
              GenreMocks.mockedGenreList,
            ),
          );
          StreamSubscription<AppEvent> subscription;
          subscription = genresBloc.allGenres.listen(
            (genresState) {
              expect(genresState.data, isNotEmpty);
              expect(genresState.data.first, isA<Genre>());
              expect(genresState.status, Status.success);
            },
          );
          subscription.cancel();
        },
      );
    },
  );

  group(
    'Extra business logic on the BLoC',
    () {
      test(
        'Genres BLoC converting genresIds list on relatedGenresList,',
        () async {
          List<int> genresIds = [
            28, //Action
            12, //Adventure
          ];

          List<Genre> genres = [
            Genre(id: 28, name: 'Action'),
            Genre(id: 12, name: 'Adventure'),
            Genre(id: 16, name: 'Animation'),
            Genre(id: 35, name: 'Comedy'),
          ];

          List<String> relatedGenres =
              genresBloc.getRelatedGenres(genres, genresIds);

          expect(relatedGenres, contains('Action'));
          expect(relatedGenres, contains('Adventure'));
          expect(relatedGenres, isNot(contains('Animation')));
          expect(relatedGenres, isNot(contains('Comedy')));
        },
      );
    },
  );
}
