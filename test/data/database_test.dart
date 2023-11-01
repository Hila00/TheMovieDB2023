import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db_module2_part1/src/data/datasource/local/DAOs/genre_dao.dart';
import 'package:the_movie_db_module2_part1/src/data/datasource/local/DAOs/movie_dao.dart';
import 'package:the_movie_db_module2_part1/src/data/datasource/local/movie_database.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/genre.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/movie.dart';

import '../mocks/genre_mocks.dart';
import '../mocks/movie_mocks.dart';

void main() {
  late AppDatabase database;
  late MovieDao movieDao;
  late GenreDao genreDao;
  final int insertedMovieId = MovieMocks.mockedMovie.id;
  final int insertedGenreId = GenreMocks.mockedGenre.id;

  setUp(() async {
    database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    movieDao = database.movieDao;
    genreDao = database.genreDao;
  });

  tearDown(() async {
    await database.close();
  });

  group(
    'MovieDao testing',
    () {
      test(
        'getMovies from db method is working',
        () async {
          await movieDao.insertMovie(MovieMocks.mockedMovie);
          List<Movie> moviesFromDb = await movieDao.getFirstMovie();
          expect(moviesFromDb, isNotEmpty);
          expect(moviesFromDb.first, isA<Movie>());
          await movieDao.deleteMovieById(insertedMovieId);
        },
      );

      test(
        'Insert Movie is working properly',
        () async {
          await movieDao.insertMovie(MovieMocks.mockedMovie);
          Movie? movieFromDb = await movieDao.getMovieById(insertedMovieId);
          expect(movieFromDb, isInstanceOf<Movie>());
          await movieDao.deleteMovieById(insertedMovieId);
        },
      );

      test(
        'Delete Movie is working properly',
        () async {
          await movieDao.insertMovie(MovieMocks.mockedMovie);
          await movieDao.deleteMovieById(insertedMovieId);
          Movie? movieFromDb = await movieDao.getMovieById(insertedMovieId);
          expect(movieFromDb, isNull);
        },
      );
    },
  );

  group(
    'GenresDao testing',
    () {
      test(
        'getGenres is working',
        () async {
          await genreDao.insertGenre(GenreMocks.mockedGenre);
          List<Genre> genresFromDb = await genreDao.getFirstGenre();
          expect(genresFromDb, isNotEmpty);
          expect(genresFromDb.first, isA<Genre>());
          await genreDao.deleteGenreById(insertedGenreId);
        },
      );

      test(
        'Insert genres method is working',
        () async {
          await genreDao.insertGenre(GenreMocks.mockedGenre);
          Genre? genreFromDb = await genreDao.getGenreById(insertedGenreId);
          expect(genreFromDb, isInstanceOf<Genre>());
          expect(genreFromDb, isNotNull);
          await genreDao.deleteGenreById(insertedGenreId);
        },
      );

      test(
        'Delete genre method is working',
        () async {
          await genreDao.insertGenre(GenreMocks.mockedGenre);
          await genreDao.deleteGenreById(insertedGenreId);
          Genre? genreFromDb = await genreDao.getGenreById(insertedGenreId);
          expect(genreFromDb, isNull);
        },
      );
    },
  );
}
