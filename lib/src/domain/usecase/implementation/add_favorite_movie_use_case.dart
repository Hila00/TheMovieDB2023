import '../../../data/repository/favorite_repository_impl.dart';
import '../../entity/movie.dart';
import '../usecase_interface.dart';

class AddFavoriteMovieUseCase extends IUseCase {
  FavoriteRepository favoriteMoviesRepository;

  AddFavoriteMovieUseCase({
    required this.favoriteMoviesRepository,
  });

  @override
  void call([Movie? movie]) {
    favoriteMoviesRepository.insertFavoriteMovie(movie!);
  }
}
