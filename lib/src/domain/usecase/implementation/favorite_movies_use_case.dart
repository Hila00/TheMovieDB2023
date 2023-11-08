import '../../../core/util/data_state.dart';
import '../../../data/repository/favorite_repository_impl.dart';
import '../../entity/movie.dart';
import '../usecase_interface.dart';

class FavoritesUseCase extends IUseCase<Future<DataState<List<Movie>>>> {
  FavoriteRepository favoriteMoviesRepository;

  FavoritesUseCase({
    required this.favoriteMoviesRepository,
  });

  @override
  Future<DataState<List<Movie>>> call([Movie? movie]) async {
    return await favoriteMoviesRepository.getData();
  }
}
