import '../../../core/util/data_state.dart';
import '../../entity/genre.dart';
import '../../entity/movie.dart';
import '../../repository/i_genre_repository.dart';
import '../usecase_interface.dart';

class GenresUseCase extends IUseCase<Future<DataState<List<Genre>>>> {
  IGenreRepository genreRepository;

  GenresUseCase({
    required this.genreRepository,
  });

  @override
  Future<DataState<List<Genre>>> call([Movie? movie]) async {
    return await genreRepository.getData();
  }
}
