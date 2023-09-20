import '../../../core/util/data_state.dart';
import '../../entity/genre.dart';
import '../../repository/i_repository.dart';
import '../usecase_interface.dart';

class GenresUseCase extends IUseCase<Future<DataState<List<Genre>>>> {
  IRepository genreRepository;

  GenresUseCase({
    required this.genreRepository,
  });

  @override
  Future<DataState<List<Genre>>> call() async {
    return await genreRepository.getData();
  }
}
