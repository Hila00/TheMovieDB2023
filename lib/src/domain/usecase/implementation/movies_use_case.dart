import '../../../core/util/data_state.dart';
import '../../entity/movie.dart';
import '../../repository/i_repository.dart';
import '../usecase_interface.dart';

class MoviesUseCase extends IUseCase<Future<DataState<List<Movie>>>> {
  IRepository movieRepository;

  MoviesUseCase({
    required this.movieRepository,
  });

  @override
  Future<DataState<List<Movie>>> call() async {
    return await movieRepository.getData();
  }
}
