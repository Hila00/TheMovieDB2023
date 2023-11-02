import '../datasource/local/DAOs/genre_dao.dart';
import '../datasource/local/DAOs/movie_dao.dart';
import '../datasource/local/movie_database.dart';

class DatabaseRepository {
  Future<AppDatabase> initializeDb() async {
    return await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  Future<MovieDao> getMovieDao() async {
    AppDatabase db = await initializeDb();
    MovieDao movieDao = db.movieDao;

    return movieDao;
  }

  Future<GenreDao> getGenreDao() async {
    AppDatabase db = await initializeDb();
    GenreDao genreDao = db.genreDao;

    return genreDao;
  }
}
