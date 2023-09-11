import 'dart:convert';
import 'dart:core';
import 'package:flutter/services.dart';
import '/model/genre_data_model.dart';
import '/repository/i_repository.dart';

class GenreRepository implements IRepository {
  @override
  Future<List<GenreDataModel>> getData() async {
    String jsonString =
        await rootBundle.loadString('assets/jsonfile/genres.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    List<GenreDataModel> genresList = [];

    for (var genre in jsonData['genres']) {
      genresList.add(GenreDataModel(
        id: genre['id'],
        name: genre['name'],
      ));
    }

    return genresList;
  }

  List<String> getRelatedGenres(
    List<GenreDataModel> genres,
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
