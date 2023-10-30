class ApiConstants {
  static const String apiBearerToken = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQ'
      'iOiJhNzU2OGJmZGIzYjU1YWU2MWYxNDJmYjM0ZWVmOGVhMyIsInN1YiI6IjY1M2JkYj'
      'FjNTE5YmJiMDExYjQ0MzE1NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9u'
      'IjoxfQ.QPBDVZg1H9RJbqWuSjoyrq3OYTDNs9cnzjCY5r8SVEQ';
  static const String baseUrlForMovies = 'https://api.themoviedb.org/3/movie';
  static const String baseUrlForImages = 'https://image.tmdb.org/t/p/original/';
  static const String baseUrlForGenres =
      'https://api.themoviedb.org/3/genre/movie/list';
  static const String errorMessage = 'Failed to load content ';
  static const popularMoviesEndPoint = '/popular';
  static const topRatedMoviesEndPoint = '/top_rated';
  static const nowPlayingMoviesEndPoint = '/now_playing';
  static const upComingMoviesEndPoint = '/upcoming';
}
