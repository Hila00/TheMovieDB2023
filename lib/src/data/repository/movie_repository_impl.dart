import '../../core/util/constants.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/movie.dart';
import '../../domain/repository/i_repository.dart';
import '../datasource/local/DAOs/movie_dao.dart';
import '../datasource/local/movie_database.dart';
import '../datasource/remote/i_api_service.dart';
import '../model/movie_model.dart';

class MovieRepositoryImpl implements IRepository<DataState<List<Movie>>> {
  IApiService movieService;
  Future<AppDatabase> databaseInstance;

  MovieRepositoryImpl({
    required this.movieService,
    required this.databaseInstance,
  });

  @override
  Future<DataState<List<Movie>>> getData() async {
    AppDatabase database = await databaseInstance;
    DataState dataState = await movieService.fetchDataFromApi();

    if (dataState is DataSuccess) {
      List<MovieModel> movieModel = dataState.data;

      if (movieModel.isNotEmpty) {
        MovieDao movieDao = database.movieDao;
        movieModel.map((movie) => movieDao.insertMovie(movie));
        return DataSuccess<List<Movie>>(movieModel);
      } else {
        return getDatabaseState();
      }
    } else {
      return getDatabaseState();
    }
  }

  Future<DataState<List<Movie>>> getDatabaseState() async {
    AppDatabase database = await databaseInstance;
    MovieDao dao = database.movieDao;
    List<Movie> moviesFromDb = await dao.getAllMovies();

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
