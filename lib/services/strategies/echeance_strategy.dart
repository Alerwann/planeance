import 'package:planeance/data/models/echeance/echeance_model.dart';

/// Contrat que toutes les stratégies (Santé, Travail, etc.) doivent respecter.
/// C'est comme un "cahier des charges" pour chaque catégorie.
abstract class EcheanceStrategy {
  /// 1. La liste des choix possibles pour cette catégorie.
  /// Exemple pour Santé : retourne ['Ordonnance', 'Rendez-vous', 'Handicap']
  /// Exemple pour Travail : retourne ['Entretien', 'Réunion', 'Deadline']
  List<String> getAvailableSubTypes();

  /// 2. La validation spécifique.
  /// Permet de vérifier si l'échéance est valide selon les règles de la catégorie.
  /// Retourne `null` si tout est bon, ou un message d'erreur (String) si ça bloque.
  String? validate(EcheanceModel echeance);
}
