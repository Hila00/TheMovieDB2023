import 'dart:convert';
import 'package:flutter/services.dart';
import '/repository/i_repository.dart';
import '/model/movie_data_model.dart';

class MovieRepository implements IRepository {
  @override
  Future<List<MovieDataModel>> getData() async {
    final jsonData = await rootBundle.loadString('assets/jsonfile/movies.json');
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((item) => MovieDataModel.fromJson(item)).toList();
  }
}
