import '/constants.dart';

class MovieDataModel {
  bool adult;
  String backdropPath;
  List<num> genreIds;
  num id;
  String originalLanguage;
  String originalTitle;
  String overview;
  num popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  num voteAverage;
  num voteCount;

  MovieDataModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  // Factory constructor
  factory MovieDataModel.fromJson(Map<String, dynamic> json) {
    return MovieDataModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: json['genre_ids'].cast<num>(),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }

  String get backdropUrl => '${AppConstants.apiImagesPath}$backdropPath';

  String get posterUrl => '${AppConstants.apiImagesPath}$posterPath';
}
