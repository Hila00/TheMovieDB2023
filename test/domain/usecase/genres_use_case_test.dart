import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movie_db_module2_part1/src/core/util/api_constants.dart';
import 'package:the_movie_db_module2_part1/src/core/util/data_state.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/genre.dart';
import 'package:the_movie_db_module2_part1/src/domain/repository/i_repository.dart';
import 'package:the_movie_db_module2_part1/src/domain/usecase/implementation/genres_use_case.dart';

import '../../mocks/genre_mocks.dart';

class MockGenresRepo extends Mock implements IRepository {}

void main() {
  late GenresUseCase genresUseCase;
  late MockGenresRepo mockedRepo;

  setUp(
    () {
      mockedRepo = MockGenresRepo();
      genresUseCase = GenresUseCase(
        genreRepository: mockedRepo,
      );
    },
  );

  group(
    'GenreUseCase is working correctly',
    () {
      test(
        'Use case is calling repository getData() method properly',
        () async {
          when(() => mockedRepo.getData()).thenAnswer(
            (_) async => DataSuccess(
              GenreMocks.mockedGenreList,
            ),
          );
          await genresUseCase.call();
          verify(() => mockedRepo.getData()).called(1);
        },
      );

      test(
        'call() method returns List<Genre> successfully,'
        'inside a DataSuccess',
        () async {
          when(() => mockedRepo.getData()).thenAnswer(
            (_) async => DataSuccess(
              GenreMocks.mockedGenreList,
            ),
          );
          DataState<List<Genre>> genres = await genresUseCase.call();
          expect(genres, isA<DataSuccess>());
          expect(genres.data, isNotEmpty);
          expect(genres.data?.first, isInstanceOf<Genre>());
        },
      );

      test(
        'call() method receives a DataError from repository,'
        'should return a DataError',
        () async {
          when(() => mockedRepo.getData()).thenAnswer(
            (_) async => DataError(
              Exception(
                ApiConstants.errorMessage,
              ),
            ),
          );

          DataState data = await mockedRepo.getData();
          expect(data, isA<DataError>());
        },
      );
    },
  );
}
