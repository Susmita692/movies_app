import 'package:hive/hive.dart';
part 'movie_inventory.g.dart';

@HiveType(typeId: 0)
class MovieInventory {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String director;

  @HiveField(2)
  final String poster;

  MovieInventory({required this.director, required this.name, required this.poster});
}