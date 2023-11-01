import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db_module2_part1/src/core/util/api_constants.dart';
import 'package:the_movie_db_module2_part1/src/data/datasource/local/movie_database.dart';
import 'package:the_movie_db_module2_part1/src/data/datasource/remote/i_api_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movie_db_module2_part1/src/core/util/data_state.dart';
import 'package:the_movie_db_module2_part1/src/data/repository/genre_repository_impl.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/genre.dart';

import '../../mocks/genre_mocks.dart';

class MockApiGenresService extends Mock implements IApiService {}

void main() {
  late GenreRepositoryImpl genreRepo;
  late MockApiGenresService mockedService;
  late Future<AppDatabase> databaseInstance;

  setUp(
    () {
      mockedService = MockApiGenresService();
      databaseInstance =
          $FloorAppDatabase.databaseBuilder('app_database.db').build();
      genreRepo = GenreRepositoryImpl(
        genresService: mockedService,
        databaseInstance: databaseInstance,
      );
    },
  );

  group(
    'Genres Repository testing',
    () {
      test(
        'Api service is called properly',
        () async {
          when(() => mockedService.fetchDataFromApi()).thenAnswer(
            (_) async => DataSuccess(
              GenreMocks.mockedGenreModelList,
            ),
          );
          await genreRepo.getData();
          verify(() => mockedService.fetchDataFromApi()).called(1);
        },
      );

      test(
        'GetData() method get DataSuccess,'
        'that should have non empty list of genres',
        () async {
          when(() => mockedService.fetchDataFromApi()).thenAnswer(
            (_) async => DataSuccess(
              GenreMocks.mockedGenreModelList,
            ),
          );
          DataState genres = await genreRepo.getData();
          expect(genres, isInstanceOf<DataSuccess>());
          expect(genres.data, isNotEmpty);
          expect(genres.data.first, isA<Genre>());
        },
      );

      test(
        "getData() receives DataSuccess with an empty model,"
        "should return DataSuccess if the db has items"
        "and DataError if it hasn't",
        () async {
          when(() => mockedService.fetchDataFromApi()).thenAnswer(
            (_) async => DataSuccess(
              GenreMocks.mockedGenreModelEmptyList,
            ),
          );

          AppDatabase database = await databaseInstance;
          List<Genre> genresFromDB = await database.genreDao.getFirstGenre();

          if (genresFromDB.isNotEmpty) {
            DataState genres = await genreRepo.getData();
            expect(genres, isA<DataSuccess>());
          } else {
            DataState genres = await genreRepo.getData();
            expect(genres, isA<DataError>());
          }
        },
      );

      test(
        "getData() receives a DataError from service,"
        "should return DataSuccess if the db has items"
        "and DataError if it hasn't",
        () async {
          when(() => mockedService.fetchDataFromApi()).thenAnswer(
            (_) async => DataError(
              Exception(
                ApiConstants.errorMessage,
              ),
            ),
          );
          AppDatabase database = await databaseInstance;
          List<Genre> genreFromDB = await database.genreDao.getFirstGenre();

          if (genreFromDB.isNotEmpty) {
            DataState genres = await genreRepo.getData();
            expect(genres, isA<DataSuccess>());
          } else {
            DataState genres = await genreRepo.getData();
            expect(genres, isA<DataError>());
          }
        },
      );
    },
  );
}
