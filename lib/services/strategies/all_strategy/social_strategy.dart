import 'package:planeance/data/models/echeance/echeance_model.dart';
import 'package:planeance/services/strategies/echeance_strategy.dart';

class SocialStrategy implements EcheanceStrategy {
  @override
  List<String> getAvailableSubTypes() {
    return ['Réponse à invitation', 'Remboursement', 'Anniversaires', 'Autre'];
  }

  @override
  String? validate(EcheanceModel echeance) {
    // Pour l'instant, pas de validation bloquante spécifique
    // On pourrait ajouter ici : if (echeance.subType == null) return "Le type est obligatoire";
    return null;
  }
}
