import 'package:floor/floor.dart';

@entity
class Genre {
  @primaryKey
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });
}
