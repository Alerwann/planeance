import 'package:hive/hive.dart';

part 'directory_model.g.dart';

@HiveType(typeId: 2)
class DirectoryModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String categoryId;

  DirectoryModel({
    required this.id,
    required this.name,
    required this.categoryId,
  });
}
