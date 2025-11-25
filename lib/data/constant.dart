import 'package:planeance/data/models/directory/directory_model.dart';

class Constant {
  static const String echeanceBoxName = 'echeances';
  static const String directoryBoxName = 'directory_v2';

  static const String daysPeriod = 'day';
  static const String weekPeriod = 'week';
  static const String monthPeriod = 'month';

  static final List<DirectoryModel> directoryList = [
    DirectoryModel(id: 1, name: 'Santé', categoryId: 'health'),
    DirectoryModel(id: 2, name: 'Factures', categoryId: 'bill'),
    DirectoryModel(id: 3, name: 'Travail', categoryId: 'job'),
    DirectoryModel(id: 4, name: 'Tansport', categoryId: 'transport'),
    DirectoryModel(id: 5, name: 'Famille', categoryId: 'familly'),
    DirectoryModel(id: 6, name: 'Social', categoryId: 'social'),
    DirectoryModel(id: 7, name: 'Invitation', categoryId: 'meeting'),
    DirectoryModel(id: 8, name: 'Essai', categoryId: 'essai'),
    
  ];
}
