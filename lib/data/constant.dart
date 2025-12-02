import 'package:planeance/data/models/directory/directory_model.dart';

class Constant {
  static const String echeanceBoxName = 'echeances';
  static const String directoryBoxName = 'directory_v2';
  static const String healthLinkBoxName = 'health_link';
  static const String healthEcheanceBoxName = 'health_echeance';

  static const String typeEcheance = 'echeance';
  static const String typeDirectory = 'directory';

  static const String daysPeriod = 'day';
  static const String weekPeriod = 'week';
  static const String monthPeriod = 'month';
  static const String yearPeriod = 'year';

  static final List<DirectoryModel> directoryList = [
    DirectoryModel(id: 1, name: 'Santé', categoryId: 'health'),
    DirectoryModel(id: 2, name: 'Factures', categoryId: 'bill'),
    DirectoryModel(id: 3, name: 'Travail', categoryId: 'job'),
    DirectoryModel(id: 4, name: 'Tansport', categoryId: 'transport'),
    DirectoryModel(id: 6, name: 'Social', categoryId: 'social'),
  ];
}
