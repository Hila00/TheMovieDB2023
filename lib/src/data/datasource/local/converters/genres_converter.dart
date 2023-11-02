import 'dart:convert';

import 'package:floor/floor.dart';

class GenresConverter extends TypeConverter<List<int>, String> {
  static const fieldName = 'Genres';

  @override
  List<int> decode(String databaseValue) {
    final dynamic jsonFile = json.decode(databaseValue);
    return List<int>.from(jsonFile[fieldName]);
  }

  @override
  String encode(List<int> value) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(<String, dynamic>{fieldName: value});
    return json.encode(data);
  }
}
