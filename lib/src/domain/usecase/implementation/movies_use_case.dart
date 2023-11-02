import '../../../core/util/data_state.dart';
import '../../entity/movie.dart';
import '../../repository/i_movie_repository.dart';
import '../usecase_interface.dart';

class MoviesUseCase extends IUseCase<Future<DataState<List<Movie>>>> {
  IMovieRepository movieRepository;
  String _categoryEndPoint = '';

  MoviesUseCase({
    required this.movieRepository,
  });

  set categoryEndPoint(String value) {
    _categoryEndPoint = value;
  }

  @override
  Future<DataState<List<Movie>>> call() async {
    return await movieRepository.getData(_categoryEndPoint);
  }
}
