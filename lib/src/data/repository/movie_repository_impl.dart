import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/repository/i_repository.dart';
import '../../domain/entity/movie.dart';

class MovieRepositoryImpl implements IRepository<List<Movie>> {
  @override
  Future<List<Movie>> getData() async {
    final jsonData = await rootBundle.loadString('assets/jsonfile/movies.json');
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((item) => Movie.fromJson(item)).toList();
  }
}
