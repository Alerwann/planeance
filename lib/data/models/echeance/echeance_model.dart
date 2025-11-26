import 'package:hive/hive.dart';

part 'echeance_model.g.dart';

@HiveType(typeId: 1)
class EcheanceModel extends HiveObject {
  @HiveField(0)
  final String echeanceName;

  @HiveField(1)
  final DateTime beginDate;

  @HiveField(2)
  final DateTime endDate;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final String? subType;

  @HiveField(5)
  final String? description;

  @HiveField(6)
  final String categoryId;

  EcheanceModel({
    required this.echeanceName,
    required this.beginDate,
    required this.endDate,
    required this.category,
    this.subType,
    this.description,
    required this.categoryId,
  });
}
