import '../../core/util/api_constants.dart';
import '../../core/util/data_state.dart';
import '../../domain/repository/i_repository.dart';
import '../../domain/entity/movie.dart';
import '../datasource/local/DAOs/movie_dao.dart';
import '../datasource/local/movie_database.dart';
import '../datasource/remote/i_api_service.dart';
import '../model/movie_model.dart';

class MovieRepositoryImpl implements IRepository<DataState<List<Movie>>> {
  IApiService movieService;

  MovieRepositoryImpl({
    required this.movieService,
  });

  @override
  Future<DataState<List<Movie>>> getData() async {
    AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    DataState dataState = await movieService.fetchDataFromApi();

    if (dataState is DataSuccess) {
      List<MovieModel> movieModel = dataState.data;

      if (movieModel.isNotEmpty) {
        MovieDao movieDao = database.movieDao;
        for (MovieModel movie in movieModel) {
          movieDao.insertMovie(movie);
        }
        return DataSuccess<List<Movie>>(movieModel);
      } else {
        return DataError(
          Exception(ApiConstants.errorMessage),
        );
      }
    } else {
      final movieDao = database.movieDao;
      List<Movie> moviesFromDB = await movieDao.getAllMovies();
      if (moviesFromDB.isNotEmpty) {
        return DataSuccess(moviesFromDB);
      } else {
        return DataError(
          Exception(ApiConstants.errorMessage),
        );
      }
    }
  }
}
