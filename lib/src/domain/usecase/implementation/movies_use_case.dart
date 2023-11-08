import '../../../core/util/data_state.dart';
import '../../entity/movie.dart';
import '../../repository/i_movie_repository.dart';
import '../usecase_interface.dart';

class MoviesUseCase extends IUseCase<Future<DataState<List<Movie>>>> {
  IMovieRepository movieRepository;
  String categoryEndPoint;

  MoviesUseCase({
    required this.movieRepository,
    required this.categoryEndPoint,
  });

  @override
  Future<DataState<List<Movie>>> call([Movie? movie]) async {
    return await movieRepository.getData(categoryEndPoint);
  }
}
