abstract class IApiMovieService<T> {
  Future<T> fetchMoviesFromApi(String endPoint);
}
