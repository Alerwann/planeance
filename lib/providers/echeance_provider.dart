import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:planeance/data/constant.dart';
import 'package:planeance/data/models/echeance/echeance_model.dart';


/// Provider qui gère les opérationssur les [EcheanceModel] via Hive.
///
/// Ce provider expose les méthodes suivantes :
/// * [add](cci:1://file:///Volumes/T9/programmation/flutter/echeance_calcul/echeance_calcul/lib/providers/echeance_provider.dart:28:2-30:3) : ajoute une nouvelle échéance.
/// * [get](cci:1://file:///Volumes/T9/programmation/flutter/echeance_calcul/echeance_calcul/lib/providers/echeance_provider.dart:33:2-33:47) / [getByIndex](cci:1://file:///Volumes/T9/programmation/flutter/echeance_calcul/echeance_calcul/lib/providers/echeance_provider.dart:34:2-34:60) : récupère une échéance par clé ou par index.
/// * [update](cci:1://file:///Volumes/T9/programmation/flutter/echeance_calcul/echeance_calcul/lib/providers/echeance_provider.dart:38:2-43:3) : met à jour une échéance existante.
/// * [deleteOne](cci:1://file:///Volumes/T9/programmation/flutter/echeance_calcul/echeance_calcul/lib/providers/echeance_provider.dart:46:2-51:3) : supprime une échéance à partir de sa clé.
/// * [deleteAll](cci:1://file:///Volumes/T9/programmation/flutter/echeance_calcul/echeance_calcul/lib/providers/echeance_provider.dart:53:2-58:3) : supprime toutes les échéances.
///
/// Chaque méthode retourne un `Future<bool>` indiquant le succès (`true`) ou l’échec (`false`)
/// de l’opération. En cas d’erreur, le message est affiché en mode debug grâce à `kDebugMode`.
class EcheanceProvider extends ChangeNotifier  {
  /// Boîte Hive contenant les objets [EcheanceModel].
  final Box<EcheanceModel> _box = Hive.box<EcheanceModel>(
    Constant.echeanceBoxName,
  );

  /// Liste complète des échéances stockées.
  List<EcheanceModel> get all => _box.values.toList();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // -----------------------------------------------------------------
  // CRUD – Create
  // -----------------------------------------------------------------
  /// Ajoute une nouvelle [EcheanceModel] dans la boîte.
  ///
  /// Retourne `true` si l’ajout a réussi, sinon `false`.

  (bool, String) add(EcheanceModel echeance) {
    _isLoading = true;
    notifyListeners();
    try {
      _box.add(echeance);
      _isLoading = false;
      notifyListeners();
      return (true, "Ajout d'échéance réussie");
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return (false, "L'échéance n'a pas été ajouté. Erreur :$e");
    }
  }

  // -----------------------------------------------------------------
  // CRUD – Read
  // -----------------------------------------------------------------
  /// Récupère une échéance à partir de sa **clé** Hive.
  ///
  /// Retourne `null` si la clé n’existe pas.
  EcheanceModel? get(int key) => _box.get(key);

  /// Récupère une échéance à partir de son **index** dans la boîte.
  ///
  /// Retourne `null` si l’index est hors limites.
  EcheanceModel? getByIndex(int index) => _box.getAt(index);

  List<EcheanceModel> getEcheancePast() {
    final now = DateTime.now();

    return all.where((echance) {
      return echance.endDate.isBefore(now);
    }).toList();
  }

  /// Récupère toutes les échéances qui prennent fin dans les 7jours.
  ///
  /// Retourne 'nul' si aucune échéance n'a été trouvé.

  List<EcheanceModel> getEcheancesForPeriod(String period) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    DateTime nextPeriod;

    switch (period) {
      case Constant.daysPeriod:
        nextPeriod = now;
        break;
      case Constant.weekPeriod:
        nextPeriod = today.add(const Duration(days: 7));
        break;
      case Constant.monthPeriod:
        nextPeriod = today.add(const Duration(days: 30));
        break;

      default:
        nextPeriod = today.add(const Duration(days: 7));
    }

    return all.where((echeance) {
      final echeanceDate = DateTime(
        echeance.endDate.year,
        echeance.endDate.month,
        echeance.endDate.day,
      );

      return echeanceDate.isAfter(today.subtract(const Duration(days: 1))) &&
          echeanceDate.isBefore(nextPeriod.add(const Duration(days: 1)));
    }).toList();
  }

  /// Récupère toutes les échances pour une catégorie
  ///
  /// La catégorie en entrée est identifié par [categoryId]
  ///
  ///Retourne 'null' si aucune échéance n'est trouvé

  List<EcheanceModel> getEcheanceByType(String categoryId) {
    return all.where((echeance) {
      return categoryId == echeance.categoryId;
    }).toList();
  }

  /// Crée une liste de longueur personnalisé pour une catégorie choisi
  ///
  /// La catégorie en entrée est identifié par [categoryId] et [nbEcheance] fixe la taille
  ///
  ///Retourne 'null' si aucune échéance n'est trouvé

  List<EcheanceModel> getCustomListEcheance(String categoryId, int nbEcheance) {
    final List<EcheanceModel> allByCat = getEcheanceByType(categoryId);
    allByCat.sort((a, b) => a.endDate.compareTo(b.endDate));

    if (allByCat.length >= nbEcheance) {
      return allByCat.sublist(0, nbEcheance);
    } else {
      return allByCat;
    }
  }

  // -----------------------------------------------------------------
  // CRUD – Update
  // -----------------------------------------------------------------
  /// Met à jour l’échéance identifiée par [key] avec les nouvelles données [e].
  ///
  /// Retourne `true` si la mise à jour a réussi, sinon `false`.

  (bool, String) update(int key, EcheanceModel echeance) {
    try {
      _box.put(key, echeance);

      notifyListeners();
      return (true, "L'écheance ${echeance.echeanceName} a été mis à jour");
    } catch (e) {
      return (false, "La mise à jour n'a pas été faite. Erreur : $e");
    }
  }

  // -----------------------------------------------------------------
  // CRUD – Delete
  // -----------------------------------------------------------------

  /// Supprime l' échéance de la boîte selon son index.
  ///
  /// Retourne `true` si le nettoyage a réussi, sinon `false` ainsi qu'un message d'explication.

  (bool, String) deleteAt(int index) {
    try {
      _box.deleteAt(index);
      notifyListeners();
      return (true, "L'échéance a été supprimée avec succès");
    } catch (e) {
      return (false, "Erreur lors de la suppression de l' échéance : $e");
    }
  }

  /// Supprime **toutes** les échéances de la boîte.
  ///
  /// Retourne `true` si le nettoyage a réussi, sinon `false`.
  (bool, String) deleteAll() {
    try {
      _box.clear();
      notifyListeners();
      return (true, 'Toutes les échéances supprimées avec succès');
    } catch (e) {
      return (false, 'Erreur lors de la réinitialisation des échéances : $e');
    }
  }

  /// Supprime l’échéance correspondant à la **clé** fournie.
  ///
  /// Retourne `true` si la suppression a réussi, sinon `false`.
  /// Dans les deux cas un message explicatif est retourné

  (bool, String) deleteOne(dynamic key) {
    try {
      _box.delete(key);
      notifyListeners();
      return (true, 'Échéance supprimée avec succès');
    } catch (e) {
      return (false, 'Erreur lors de la suppression $e');
    }
  }
}
