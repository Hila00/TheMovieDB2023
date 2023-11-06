abstract class IMovieRepository<T> {
  Future<T> getData(String endPoint);
}
