import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:planeance/data/constant.dart';
import 'package:planeance/data/models/echeance/echeance_model.dart';
import 'package:planeance/utils/hive_helper.dart';

/// Provider qui gère les opérations CRUD sur les [EcheanceModel] via Hive.
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
class EcheanceProvider extends ChangeNotifier with HiveHelper {
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

  Future<bool> add(EcheanceModel e) {
    _isLoading = true;
    notifyListeners();
    final handleVal = handle(() => _box.add(e), "Erreur lors de l'ajout");

    _isLoading = false;
    notifyListeners();
    return handleVal;
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

  // -----------------------------------------------------------------
  // CRUD – Update
  // -----------------------------------------------------------------
  /// Met à jour l’échéance identifiée par [key] avec les nouvelles données [e].
  ///
  /// Retourne `true` si la mise à jour a réussi, sinon `false`.
  Future<bool> update(int key, EcheanceModel e) {
    return handle(
      () => _box.put(key, e),
      "Erreur lors de la mise à jour de ${e.echeanceName}",
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
