import '../entity/movie.dart';

abstract class IUseCase<T> {
  T call([Movie movie]);
}
