import 'package:flutter/foundation.dart';

mixin HiveHelper on ChangeNotifier {
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // -----------------------------------------------------------------
  // Fonction utilitaire interne
  // -----------------------------------------------------------------
  /// Exécute une action Hive et gère les erreurs de façon centralisée.
  ///
  /// * **action** : fonction asynchrone qui réalise l’opération (add, update, delete…).
  /// * **description** : texte descriptif utilisé dans le log en cas d’erreur.
  ///
  /// Retourne `true` si l’action réussit, sinon `false` et le message d’erreur
  /// est affiché en mode debug.

  Future<bool> handle(
    Future<void> Function() action,
    String description,
  ) async {
    _errorMessage = null;
    try {
      await action();

      notifyListeners();
      return true;
    } catch (error) {
      _errorMessage = error.toString();
      if (kDebugMode) {
        print("$description : $error");
      }
      notifyListeners();
      return false;
    }
  }
}
