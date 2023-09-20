import 'package:the_movie_db_module2_part1/src/data/model/movie_model.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/movie.dart';

class MovieMocks {
  static Movie mockedMovie = Movie(
    adult: false,
    backdropPath: '/1syW9SNna38rSl9fnXwc9fP7POW.jpg',
    genreIds: [28, 878, 12],
    id: 565770,
    originalLanguage: "en",
    originalTitle: "Blue Beetle",
    overview: "Recent college grad Jaime Reyes returns home "
        "full of aspirations for his future,"
        "only to find that home is not quite as he left it. "
        "As he searches to find his purpose in the world,"
        "fate intervenes when Jaime unexpectedly finds "
        "himself in possession of an ancient relic of alien biotechnology:"
        "the Scarab.",
    popularity: 2972.534,
    posterPath: "/mXLOHHc1Zeuwsl4xYKjKh2280oL.jpg",
    releaseDate: "2023-08-16",
    title: "Blue Beetle",
    video: false,
    voteAverage: 7.2,
    voteCount: 956,
  );

  static final List<Movie> mockedMovieList = [
    mockedMovie,
  ];

  static const List<Movie> emptyMovieList = [];

  static MovieModel mockedMovieModel = MovieModel(
    adult: false,
    backdropPath: '/1syW9SNna38rSl9fnXwc9fP7POW.jpg',
    genreIds: [28, 878, 12],
    id: 565770,
    originalLanguage: "en",
    originalTitle: "Blue Beetle",
    overview: "Recent college grad Jaime Reyes returns home "
        "full of aspirations for his future,"
        "only to find that home is not quite as he left it. "
        "As he searches to find his purpose in the world,"
        "fate intervenes when Jaime unexpectedly finds "
        "himself in possession of an ancient relic of alien biotechnology:"
        "the Scarab.",
    popularity: 2972.534,
    posterPath: "/mXLOHHc1Zeuwsl4xYKjKh2280oL.jpg",
    releaseDate: "2023-08-16",
    title: "Blue Beetle",
    video: false,
    voteAverage: 7.2,
    voteCount: 956,
  );

  static final List<MovieModel> mockedMovieModelList = [
    mockedMovieModel,
  ];

  static const List<MovieModel> emptyMovieModelList = [];
}
