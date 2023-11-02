import 'dart:convert';

import 'package:floor/floor.dart';

class GenresConverter extends TypeConverter<List<int>, String> {
  @override
  List<int> decode(String databaseValue) {
    final dynamic jsonFile = json.decode(databaseValue);
    return List<int>.from(jsonFile['Genres']);
  }

  @override
  String encode(List<int> value) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(<String, dynamic>{'Genres': value});
    return json.encode(data);
  }
}
