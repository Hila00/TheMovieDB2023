import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:the_movie_db_module2_part1/src/core/util/api_constants.dart';
import 'package:the_movie_db_module2_part1/src/core/util/data_state.dart';
import 'package:the_movie_db_module2_part1/src/data/datasource/local/movie_database.dart';
import 'package:the_movie_db_module2_part1/src/data/datasource/remote/i_api_service.dart';
import 'package:the_movie_db_module2_part1/src/data/repository/movie_repository_impl.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/movie.dart';
import '../../mocks/movie_mocks.dart';

class MockApiMovieService extends Mock implements IApiService {}

void main() {
  late MovieRepositoryImpl movieRepo;
  late MockApiMovieService mockMovieService;
  late Future<AppDatabase> databaseInstance;

  setUp(() {
    mockMovieService = MockApiMovieService();
    databaseInstance =
        $FloorAppDatabase.databaseBuilder('app_database.db').build();
    movieRepo = MovieRepositoryImpl(
      movieService: mockMovieService,
      databaseInstance: databaseInstance,
    );
  });

  group(
    'Repository getData() method',
    () {
      test(
        'Movie service is called properly',
        () async {
          when(() => mockMovieService.fetchDataFromApi()).thenAnswer(
            (_) async => DataSuccess(
              MovieMocks.mockedMovieModelList,
            ),
          );
          await movieRepo.getData();
          verify(() => mockMovieService.fetchDataFromApi()).called(1);
        },
      );

      test(
        'getData() successfully gets movies,'
        'gets DataSuccess from service',
        () async {
          when(() => mockMovieService.fetchDataFromApi()).thenAnswer(
            (_) async => DataSuccess(
              MovieMocks.mockedMovieModelList,
            ),
          );
          DataState<List<Movie>> movies = await movieRepo.getData();
          expect(movies, isInstanceOf<DataSuccess>());
          expect(movies.data?.first, isA<Movie>());
        },
      );

      test(
        "getData() receives DataSuccess with an empty model,"
        "should return DataSuccess if the db has items"
        "and DataError if it hasn't",
        () async {
          when(() => mockMovieService.fetchDataFromApi()).thenAnswer(
            (_) async => const DataSuccess(
              MovieMocks.emptyMovieModelList,
            ),
          );

          AppDatabase database = await databaseInstance;
          List<Movie> movieFromDb = await database.movieDao.getFirstMovie();

          if (movieFromDb.isNotEmpty) {
            DataState movies = await movieRepo.getData();
            expect(movies, isInstanceOf<DataSuccess>());
          } else {
            DataState movies = await movieRepo.getData();
            expect(movies, isInstanceOf<DataError>());
          }
        },
      );

      test(
        "getData() receives a DataError from service,"
        "should return DataSuccess if the db has items"
        "and DataError if it hasn't",
        () async {
          when(() => mockMovieService.fetchDataFromApi()).thenAnswer(
            (_) async => DataError(
              Exception(
                ApiConstants.errorMessage,
              ),
            ),
          );
          AppDatabase database = await databaseInstance;
          List<Movie> movieFromDb = await database.movieDao.getFirstMovie();

          if (movieFromDb.isNotEmpty) {
            DataState movies = await movieRepo.getData();
            expect(movies, isInstanceOf<DataSuccess>());
          } else {
            DataState movies = await movieRepo.getData();
            expect(movies, isInstanceOf<DataError>());
          }
        },
      );
    },
  );
}
