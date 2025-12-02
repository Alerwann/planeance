import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:planeance/data/constant.dart';
import 'package:planeance/pages/all_type_echeances/job/job_home.dart';
import 'package:planeance/pages/all_type_echeances/social/social_home.dart';
import 'package:planeance/pages/all_type_echeances/transport/transport_home.dart';
import 'package:planeance/planeance.dart';


class DirectoryProvider extends ChangeNotifier  {
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

  (bool, String) ensureDefaults() {
    if (_box.isEmpty) {
      try {
        _box.addAll(Constant.directoryList);
        stateIsFull();
      } catch (e) {
        return (false, "Echec de l'initialisation par défaut des donées : $e");
      }
    }
    return (true, "Les données sont bien initialisé");
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
      case 'social':
        return SocialHome();
      default:
        return Homeshell();
    }
  }

  // -----------------------------------------------------------------
  // CRUD – Create
  // -----------------------------------------------------------------
  /// Ajoute une nouvelle [DirectoryModel] dans la boîte.
  ///
  /// Retourne `true` si l’ajout a réussi, sinon `false` ainsi qu'un message d'information.

  (bool, String) add(DirectoryModel value) {
    try {
      _box.add(value);
      stateIsFull();
      return (true, "La lise de répertoire est à jour");
    } catch (e) {
      return (false, "Erreure de mise à jour de la liste :$e");
    }
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

  (bool, String) update(int key, DirectoryModel d) {
    try {
      _box.put(key, d);
      notifyListeners();
      return (true, "Le répertoire ${d.name} est bien mise à jour ");
    } catch (e) {
      return (false, "Erreur lors de la mise à jour : $e");
    }
  }

  // -----------------------------------------------------------------
  // CRUD – Delete
  // -----------------------------------------------------------------
  /// Supprime l’échéance correspondant à la **clé** fournie.
  ///
  /// Retourne `true` si la suppression a réussi, sinon `false` ainsi qu'un message d'information.

  (bool, String) deleteOne(int key) {
    try {
      _box.delete(key);
      stateIsFull();
      return (true, "L'élément à été annulé avec succès");
    } catch (e) {
      return (false, "Erreur lors de la suppression : $e");
    }
  }

  /// Supprime l’échéance correspondant à l'**index** fourni.
  ///
  /// Retourne `true` si la suppression a réussi, sinon `false` ainsi qu'un message d'information.

  (bool, String) deleteAt(int index) {
    try {
      _box.deleteAt(index);
      stateIsFull();
      return (true, "Le répertoir à été supprimé correctement");
    } catch (e) {
      return (false, "Erreur lors de la suppréssion du répertoir : $e");
    }
  }

  /// Supprime **toutes** les échéances de la boîte.
  ///
  /// Retourne `true` si le nettoyage a réussi, sinon `false` ainsi qu'un message d'information.

  (bool, String) deleteAll() {
    try {
      _box.clear();
      stateIsFull();
      return (true, "Liste réinitialisé avec succès");
    } catch (e) {
      return (false, "Erreure lors de la réinitialisation : $e");
    }
  }
}
