import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:planeance/data/constant.dart';
import 'package:planeance/data/models/directory/directory_model.dart';
import 'package:planeance/utils/hive_helper.dart';

class DirectoryProvider extends ChangeNotifier with HiveHelper {
  final Box<DirectoryModel> _box = Hive.box<DirectoryModel>(
    Constant.directoryBoxName,
  );

  List<DirectoryModel> get all => _box.values.toList();

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
        () => _box.addAll([
  
          DirectoryModel(id: 1, name: 'Santé'),
          DirectoryModel(id: 2, name: 'Finances'),
          DirectoryModel(id: 3, name: 'Personnel'),
        ]),
        'Initialisation des répertoires',
      );
    }
    return true;
  }

  // -----------------------------------------------------------------
  // CRUD – Create
  // -----------------------------------------------------------------
  /// Ajoute une nouvelle [DirectoryModel] dans la boîte.
  ///
  /// Retourne `true` si l’ajout a réussi, sinon `false`.

  Future<bool> add(DirectoryModel e) {
    return handle(() => _box.add(e), "Erreur lors de l'ajout");
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
  Future<bool> deleteOne(int key) {
    return handle(
      () => _box.delete(key),
      "Erreur lors de la suppression de l'élement de la clé $key",
    );
  }

  /// Supprime **toutes** les échéances de la boîte.
  ///
  /// Retourne `true` si le nettoyage a réussi, sinon `false`.
  Future<bool> deleteAll() {
    return handle(
      () => _box.clear(),
      "Erreur dans le nettoyage total des echeances ",
    );
  }
}
