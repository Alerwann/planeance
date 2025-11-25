import 'package:hive/hive.dart';

part 'health_echeance_model.g.dart';

@HiveType(typeId: 4)
class HealthEcheanceModel {
  @HiveField(0)
  final String nameString;
  @HiveField(1)
  final DateTime beginDate;
  @HiveField(2)
  final DateTime? endDate;
  @HiveField(3)
  final Duration? echeanceDuration;
  @HiveField(4)
  final String? typeEcheance;

  @HiveField(5)
  final String? description;

  HealthEcheanceModel({
    required this.nameString,
    required this.beginDate,
    this.endDate,
    this.echeanceDuration,
    this.typeEcheance,
    this.description,
  });
}
