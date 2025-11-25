import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:planeance/data/constant.dart';
import 'package:planeance/pages/all_type_echeances/familly/familly_home.dart';
import 'package:planeance/pages/all_type_echeances/job/job_home.dart';
import 'package:planeance/pages/all_type_echeances/meeting/meeting_home.dart';
import 'package:planeance/pages/all_type_echeances/social/social_home.dart';
import 'package:planeance/pages/all_type_echeances/transport/transport_home.dart';
import 'package:planeance/planeance.dart';
import 'package:planeance/utils/hive_helper.dart';

class DirectoryProvider extends ChangeNotifier with HiveHelper {
  final Box<DirectoryModel> _box = Hive.box<DirectoryModel>(
    Constant.directoryBoxName,
  );

  DirectoryProvider() {
    ensureDefaults();
    stateIsFull();
  }

  List<DirectoryModel> get all => _box.values.toList();

  List<DirectoryModel> get availableDirectories {
    final allIds = all.map((e) => e.categoryId).toSet();
    return Constant.directoryList
        .where((d) => !allIds.contains(d.categoryId))
        .toList();
  }

  bool _listIsFull = true;

  bool get listIsFull => _listIsFull;

  void stateIsFull() {
    if (all.length == Constant.directoryList.length) {
      _listIsFull = true;
    } else {
      _listIsFull = false;
    }
    notifyListeners();
  }

  // -----------------------------------------------------------------
  // CRUD – Create
  // -----------------------------------------------------------------
  /// Initialise une box par défaut si elle est vide
  ///
  /// Retourne `true` si la création est inutile ou si l'initialisation est réusie.
  /// Sinon retourne `false`.

  Future<bool> ensureDefaults() async {
    if (_box.isEmpty) {
      return await handle(
        () => _box.addAll(Constant.directoryList),
        'Initialisation des répertoires',
      );
    }
    return true;
  }

  Widget getCategoryHome(String categoryId) {
    switch (categoryId) {
      case 'health':
        return HealthHome();
      case 'bill':
        return BillHome();
      case 'job':
        return JobHome();
      case 'transport':
        return TransportHome();
      case 'familly':
        return FamillyHome();
      case 'social':
        return SocialHome();
      case 'meeting':
        return MeetingHome();
      default:
        return Homeshell();
    }
  }

  // -----------------------------------------------------------------
  // CRUD – Create
  // -----------------------------------------------------------------
  /// Ajoute une nouvelle [DirectoryModel] dans la boîte.
  ///
  /// Retourne `true` si l’ajout a réussi, sinon `false`.

  Future<bool> add(DirectoryModel e) async {
    final result = await handle(() => _box.add(e), "Erreur lors de l'ajout");
    stateIsFull();
    return result;
  }

  // -----------------------------------------------------------------
  // CRUD – Read
  // -----------------------------------------------------------------
  /// Récupère une échéance à partir de sa **clé** Hive.
  ///
  /// Retourne `null` si la clé n’existe pas.
  DirectoryModel? get(int key) => _box.get(key);

  /// Récupère une échéance à partir de son **index** dans la boîte.
  ///
  /// Retourne `null` si l’index est hors limites.
  DirectoryModel? getByIndex(int index) => _box.getAt(index);

  // -----------------------------------------------------------------
  // CRUD – Update
  // -----------------------------------------------------------------
  /// Met à jour l’échéance identifiée par [key] avec les nouvelles données [e].
  ///
  /// Retourne `true` si la mise à jour a réussi, sinon `false`.
  Future<bool> update(int key, DirectoryModel e) {
    return handle(
      () => _box.put(key, e),
      "Erreur lors de la mise à jour de ${e.name}",
    );
  }

  // -----------------------------------------------------------------
  // CRUD – Delete
  // -----------------------------------------------------------------
  /// Supprime l’échéance correspondant à la **clé** fournie.
  ///
  /// Retourne `true` si la suppression a réussi, sinon `false`.
  Future<bool> deleteOne(int key) async {
    final result = await handle(
      () => _box.delete(key),
      "Erreur lors de la suppression de l'élement de la clé $key",
    );
    stateIsFull();
    return result;
  }

  /// Supprime l’échéance correspondant à l'**index** fourni.
  ///
  /// Retourne `true` si la suppression a réussi, sinon `false`.
  Future<bool> deleteAt(int index) async {
    final result = await handle(
      () => _box.deleteAt(index),
      "Erreur lors de la suppression de l'élement à l'index $index",
    );
    stateIsFull();
    return result;
  }

  /// Supprime **toutes** les échéances de la boîte.
  ///
  /// Retourne `true` si le nettoyage a réussi, sinon `false`.
  Future<bool> deleteAll() async {
    final result = await handle(
      () => _box.clear(),
      "Erreur dans le nettoyage total des echeances ",
    );
    stateIsFull();
    return result;
  }
}
