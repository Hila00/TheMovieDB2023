import '../../../data/repository/favorite_repository_impl.dart';
import '../../entity/movie.dart';
import '../usecase_interface.dart';

class RemoveFavoriteMovieUseCase extends IUseCase {
  FavoriteRepository favoriteMoviesRepository;

  RemoveFavoriteMovieUseCase({
    required this.favoriteMoviesRepository,
  });

  @override
  void call([Movie? movie]) {
    int movieToDeleteId = movie!.id;
    favoriteMoviesRepository.removeFavoriteMovie(movieToDeleteId);
  }
}
