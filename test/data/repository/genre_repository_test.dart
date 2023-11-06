import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:the_movie_db_module2_part1/src/core/util/api_constants.dart';
import 'package:the_movie_db_module2_part1/src/core/util/constants.dart';
import 'package:the_movie_db_module2_part1/src/core/util/data_state.dart';
import 'package:the_movie_db_module2_part1/src/data/datasource/local/DAOs/genre_dao.dart';
import 'package:the_movie_db_module2_part1/src/data/datasource/local/movie_database.dart';
import 'package:the_movie_db_module2_part1/src/data/datasource/remote/i_api_genres_service.dart';
import 'package:the_movie_db_module2_part1/src/data/repository/genre_repository_impl.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/genre.dart';
import '../../mocks/genre_mocks.dart';

class MockApiGenresService extends Mock implements IApiGenreService {}

void main() {
  late GenreRepositoryImpl genreRepo;
  late MockApiGenresService mockedService;
  late AppDatabase databaseInstance;

  setUp(
    () async {
      mockedService = MockApiGenresService();
      databaseInstance = await $FloorAppDatabase
          .databaseBuilder(AppConstants.databaseAccessString)
          .build();

      genreRepo = GenreRepositoryImpl(
        genresService: mockedService,
        database: databaseInstance,
      );
    },
  );

  group(
    'Genres Repository testing',
    () {
      test(
        'Api service is called properly',
        () async {
          when(() => mockedService.fetchGenresFromApi()).thenAnswer(
            (_) async => DataSuccess(
              GenreMocks.mockedGenreModelList,
            ),
          );
          await genreRepo.getData();
          verify(() => mockedService.fetchGenresFromApi()).called(1);
        },
      );

      test(
        'GetData() method get DataSuccess,'
        'that should have non empty list of genres',
        () async {
          when(() => mockedService.fetchGenresFromApi()).thenAnswer(
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
          when(() => mockedService.fetchGenresFromApi()).thenAnswer(
            (_) async => DataSuccess(
              GenreMocks.mockedGenreModelEmptyList,
            ),
          );

          GenreDao dao = databaseInstance.genreDao;
          List<Genre> genresFromDB = await dao.getFirstGenre();

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
          when(() => mockedService.fetchGenresFromApi()).thenAnswer(
            (_) async => DataError(
              Exception(
                ApiConstants.errorMessage,
              ),
            ),
          );
          GenreDao dao = databaseInstance.genreDao;
          List<Genre> genresFromDB = await dao.getFirstGenre();

          if (genresFromDB.isNotEmpty) {
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
