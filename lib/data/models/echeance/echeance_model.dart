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
  final int directoryId;

  @HiveField(4)
  final String? description;

  EcheanceModel({
    required this.echeanceName,
    required this.beginDate,
    required this.endDate,
    required this.directoryId,
    this.description,
  });
}
