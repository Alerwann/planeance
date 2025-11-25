import 'package:hive/hive.dart';

part 'health_link_model.g.dart';

@HiveType(typeId: 3)
class HealthLinkModel extends HiveObject {
  @HiveField(0)
  final String nameWebStite;
  @HiveField(1)
  final String externLink;
  @HiveField(2)
  final String description;

  HealthLinkModel({
    required this.nameWebStite,
    required this.externLink,
    required this.description,
  });
}
