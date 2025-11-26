import 'package:planeance/data/models/echeance/echeance_model.dart';
import 'package:planeance/services/strategies/echeance_strategy.dart';

class TransportStrategy implements EcheanceStrategy {
  @override
  List<String> getAvailableSubTypes() {
    return ['Entretien de véhicule', 'Abonement de transport', 'Abonnement stationnement', 'Assurances','LOA', 'Autre'];
  }

  @override
  String? validate(EcheanceModel echeance) {
    // Pour l'instant, pas de validation bloquante spécifique
    // On pourrait ajouter ici : if (echeance.subType == null) return "Le type est obligatoire";
    return null;
  }
}
