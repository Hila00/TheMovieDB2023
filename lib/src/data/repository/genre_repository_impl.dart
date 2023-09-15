import 'dart:convert';
import 'dart:core';
import 'package:flutter/services.dart';
import '../../domain/entity/genre.dart';
import '../../domain/repository/i_repository.dart';

class GenreRepositoryImpl implements IRepository<List<Genre>> {
  @override
  Future<List<Genre>> getData() async {
    String jsonString =
        await rootBundle.loadString('assets/jsonfile/genres.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    List<Genre> genresList = [];

    for (var genre in jsonData['genres']) {
      genresList.add(
        Genre(
          id: genre['id'],
          name: genre['name'],
        ),
      );
    }

    return genresList;
  }

  List<String> getRelatedGenres(
    List<Genre> genres,
    List<num> movieGenresIds,
  ) {
    List<String> movieRelatedGenres = [];
    movieRelatedGenres = genres
        .where((genre) => movieGenresIds.contains(genre.id))
        .map((genre) => genre.name)
        .toList();

    return movieRelatedGenres;
  }
}
