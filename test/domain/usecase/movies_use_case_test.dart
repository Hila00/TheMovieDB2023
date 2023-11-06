import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:the_movie_db_module2_part1/src/core/util/api_constants.dart';
import 'package:the_movie_db_module2_part1/src/core/util/data_state.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/movie.dart';
import 'package:the_movie_db_module2_part1/src/domain/repository/i_movie_repository.dart';
import 'package:the_movie_db_module2_part1/src/domain/usecase/implementation/movies_use_case.dart';
import '../../mocks/movie_mocks.dart';

class MockMoviesRepo extends Mock implements IMovieRepository {}

void main() {
  const mockedEndpoint = 'mocked_endpoint';
  late MoviesUseCase moviesUseCase;
  late MockMoviesRepo mockedRepo;

  setUp(() {
    mockedRepo = MockMoviesRepo();
    moviesUseCase = MoviesUseCase(
      movieRepository: mockedRepo,
      categoryEndPoint: mockedEndpoint,
    );
  });

  group(
    'MoviesUseCase is working correctly',
    () {
      test(
        'Use case is calling repository getData() method properly',
        () async {
          when(() => mockedRepo.getData(mockedEndpoint)).thenAnswer(
            (_) async => DataSuccess(
              MovieMocks.mockedMovieList,
            ),
          );
          await moviesUseCase.call();
          verify(() => mockedRepo.getData(mockedEndpoint)).called(1);
        },
      );

      test(
        'call() method returns List<Movie> successfully,'
        'inside a DataSuccess',
        () async {
          when(() => mockedRepo.getData(mockedEndpoint)).thenAnswer(
            (_) async => DataSuccess(
              MovieMocks.mockedMovieList,
            ),
          );
          DataState<List<Movie>> movies = await moviesUseCase.call();
          expect(movies, isA<DataSuccess>());
          expect(movies.data, isNotEmpty);
          expect(movies.data?.first, isInstanceOf<Movie>());
        },
      );

      test(
        'call() method receives a DataError from repository,'
        'should return a DataError',
        () async {
          when(() => mockedRepo.getData(mockedEndpoint)).thenAnswer(
            (_) async => DataError(
              Exception(
                ApiConstants.errorMessage,
              ),
            ),
          );

          DataState data = await mockedRepo.getData(mockedEndpoint);
          expect(data, isA<DataError>());
        },
      );

      test('Set method should change the endPoint', () {
        String oldEndpoint = moviesUseCase.categoryEndPoint;
        String newEndpoint = 'new_endpoint';

        expect(moviesUseCase.categoryEndPoint, equals(oldEndpoint));

        moviesUseCase.categoryEndPoint = newEndpoint;

        expect(moviesUseCase.categoryEndPoint, equals(newEndpoint));
      });
    },
  );
}
