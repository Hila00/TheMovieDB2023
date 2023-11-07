import '../../../core/util/data_state.dart';
import '../../../data/repository/favorite_repository_impl.dart';
import '../../entity/movie.dart';
import '../usecase_interface.dart';

class FavoritesUseCase extends IUseCase<Future<DataState<List<Movie>>>> {
  FavoriteRepository dbRepo;

  FavoritesUseCase({
    required this.dbRepo,
  });

  @override
  Future<DataState<List<Movie>>> call() async {
    return await dbRepo.getData();
  }
}
