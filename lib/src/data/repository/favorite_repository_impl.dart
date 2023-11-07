import '../../core/util/constants.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/movie.dart';
import '../../domain/repository/i_favorite_repository.dart';
import '../datasource/local/DAOs/movie_dao.dart';
import '../datasource/local/movie_database.dart';

class FavoriteRepository implements IFavoriteRepository {
  AppDatabase database;

  FavoriteRepository({
    required this.database,
  });

  @override
  Future<DataState<List<Movie>>> getData() async {
    MovieDao movieDao = database.movieDao;
    List<Movie> favoriteMoviesFromDb = await movieDao.getAllMovies();

    if (favoriteMoviesFromDb.isNotEmpty) {
      return DataSuccess<List<Movie>>(favoriteMoviesFromDb);
    } else {
      return DataError(
        Exception(
          AppConstants.databaseError,
        ),
      );
    }
  }

  @override
  bool insertFavoriteMovie() {
    // TODO: implement insertFavoriteMovie
    throw UnimplementedError();
  }
}
