import '../../core/util/api_constants.dart';
import '../../core/util/data_state.dart';
import '../../domain/repository/i_repository.dart';
import '../../domain/entity/movie.dart';
import '../datasource/remote/i_api_service.dart';
import '../model/movie_model.dart';

class MovieRepositoryImpl implements IRepository<DataState<List<Movie>>> {
  IApiService movieService;

  MovieRepositoryImpl({
    required this.movieService,
  });

  @override
  Future<DataState<List<Movie>>> getData() async {
    DataState dataState = await movieService.fetchDataFromApi();

    if (dataState is DataSuccess) {
      List<MovieModel> movieModel = dataState.data;

      if (movieModel.isNotEmpty) {
        return DataSuccess<List<Movie>>(movieModel);
      } else {
        return DataError(
          Exception(ApiConstants.errorMessage),
        );
      }
    } else {
      return DataError(
        Exception(ApiConstants.errorMessage),
      );
    }
  }
}
