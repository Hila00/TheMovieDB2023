import '../../core/util/constants.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/movie.dart';
import '../../domain/repository/i_movie_repository.dart';
import '../datasource/local/DAOs/movie_dao.dart';
import '../datasource/local/movie_database.dart';
import '../datasource/remote/i_api_movies_service.dart';
import '../model/movie_model.dart';

class MovieRepositoryImpl implements IMovieRepository<DataState<List<Movie>>> {
  IApiMovieService movieService;
  AppDatabase databaseInstance;

  MovieRepositoryImpl({
    required this.movieService,
    required this.databaseInstance,
  });

  @override
  Future<DataState<List<Movie>>> getData(String endPoint) async {
    MovieDao movieDao = databaseInstance.movieDao;
    DataState dataState = await movieService.fetchMoviesFromApi(endPoint);

    if (dataState is DataSuccess) {
      List<MovieModel> movieModel = dataState.data;
      if (movieModel.isNotEmpty) {
        for (MovieModel movie in movieModel) {
          await movieDao.insertMovie(movie);
        }
        return DataSuccess<List<Movie>>(movieModel);
      }
    }

    return _getDatabaseState();
  }

  Future<DataState<List<Movie>>> _getDatabaseState() async {
    MovieDao movieDao = databaseInstance.movieDao;
    List<Movie> moviesFromDb = await movieDao.getAllMovies();

    if (moviesFromDb.isNotEmpty) {
      return DataSuccess(
        moviesFromDb,
      );
    } else {
      return DataError(
        Exception(AppConstants.databaseError),
      );
    }
  }
}
