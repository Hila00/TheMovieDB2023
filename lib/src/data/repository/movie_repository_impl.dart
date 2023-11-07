import '../../core/util/constants.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/movie.dart';
import '../../domain/repository/i_movie_repository.dart';
import '../datasource/local/movie_database.dart';
import '../datasource/remote/i_api_movies_service.dart';
import '../model/movie_model.dart';

class MovieRepositoryImpl implements IMovieRepository<DataState<List<Movie>>> {
  IApiMovieService movieService;
  AppDatabase database;

  MovieRepositoryImpl({
    required this.movieService,
    required this.database,
  });

  @override
  Future<DataState<List<Movie>>> getData(String endPoint) async {
    DataState dataState = await movieService.fetchMoviesFromApi(endPoint);

    if (dataState is DataSuccess) {
      List<MovieModel> movieModel = dataState.data;
      if (movieModel.isNotEmpty) {
        return DataSuccess<List<Movie>>(movieModel);
      }
    }
    return DataError(
      Exception(AppConstants.errorMessage),
    );
  }
}
