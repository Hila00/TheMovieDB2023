import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:the_movie_db_module2_part1/src/core/util/api_constants.dart';
import 'package:the_movie_db_module2_part1/src/core/util/constants.dart';
import 'package:the_movie_db_module2_part1/src/core/util/data_state.dart';
import 'package:the_movie_db_module2_part1/src/data/datasource/local/DAOs/movie_dao.dart';
import 'package:the_movie_db_module2_part1/src/data/datasource/local/movie_database.dart';
import 'package:the_movie_db_module2_part1/src/data/datasource/remote/i_api_movies_service.dart';
import 'package:the_movie_db_module2_part1/src/data/repository/movie_repository_impl.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/movie.dart';
import '../../mocks/movie_mocks.dart';

class MockApiMovieService extends Mock implements IApiMovieService {}

void main() {
  const mockedEndpoint = 'mocked_endpoint';
  late MovieRepositoryImpl movieRepo;
  late MockApiMovieService mockMovieService;
  late AppDatabase databaseInstance;

  setUp(() async {
    mockMovieService = MockApiMovieService();
    databaseInstance = await $FloorAppDatabase
        .databaseBuilder(AppConstants.databaseAccessString)
        .build();
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
          when(() => mockMovieService.fetchMoviesFromApi(mockedEndpoint))
              .thenAnswer(
            (_) async => DataSuccess(
              MovieMocks.mockedMovieModelList,
            ),
          );
          await movieRepo.getData(mockedEndpoint);
          verify(() => mockMovieService.fetchMoviesFromApi(mockedEndpoint))
              .called(1);
        },
      );

      test(
        'getData() successfully gets movies,'
        'gets DataSuccess from service',
        () async {
          when(() => mockMovieService.fetchMoviesFromApi(mockedEndpoint))
              .thenAnswer(
            (_) async => DataSuccess(
              MovieMocks.mockedMovieModelList,
            ),
          );
          DataState<List<Movie>> movies = await movieRepo.getData(
            mockedEndpoint,
          );
          expect(movies, isInstanceOf<DataSuccess>());
          expect(movies.data?.first, isA<Movie>());
        },
      );

      test(
        "getData() receives DataSuccess with an empty model,"
        "should return DataSuccess if the db has items"
        "and DataError if it hasn't",
        () async {
          when(() => mockMovieService.fetchMoviesFromApi(mockedEndpoint))
              .thenAnswer(
            (_) async => const DataSuccess(
              MovieMocks.emptyMovieModelList,
            ),
          );

          MovieDao dao = databaseInstance.movieDao;
          List<Movie> movieFromDb = await dao.getFirstMovie();

          if (movieFromDb.isNotEmpty) {
            DataState movies = await movieRepo.getData(mockedEndpoint);
            expect(movies, isInstanceOf<DataSuccess>());
          } else {
            DataState movies = await movieRepo.getData(mockedEndpoint);
            expect(movies, isInstanceOf<DataError>());
          }
        },
      );

      test(
        "getData() receives a DataError from service,"
        "should return DataSuccess if the db has items"
        "and DataError if it hasn't",
        () async {
          when(() => mockMovieService.fetchMoviesFromApi(mockedEndpoint))
              .thenAnswer(
            (_) async => DataError(
              Exception(
                ApiConstants.errorMessage,
              ),
            ),
          );
          MovieDao dao = databaseInstance.movieDao;
          List<Movie> movieFromDb = await dao.getFirstMovie();

          if (movieFromDb.isNotEmpty) {
            DataState movies = await movieRepo.getData(mockedEndpoint);
            expect(movies, isInstanceOf<DataSuccess>());
          } else {
            DataState movies = await movieRepo.getData(mockedEndpoint);
            expect(movies, isInstanceOf<DataError>());
          }
        },
      );
    },
  );
}
