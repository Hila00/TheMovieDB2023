import 'package:floor/floor.dart';

@Entity(tableName: 'genre')
class Genre {
  @primaryKey
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });
}
