import 'package:planeance/data/models/echeance/echeance_model.dart';
import 'package:planeance/services/strategies/all_strategy/bill_strategy.dart';
import 'package:planeance/services/strategies/all_strategy/job_strategy.dart';
import 'package:planeance/services/strategies/all_strategy/social_strategy.dart';
import 'package:planeance/services/strategies/all_strategy/transport_strategy.dart';
import 'package:planeance/services/strategies/echeance_strategy.dart';
import 'package:planeance/services/strategies/all_strategy/health_strategy.dart';

class StrategyFactory {
  static EcheanceStrategy getStrategy(String categoryId) {
    switch (categoryId) {
      case 'health':
        return HealthStrategy();
      case 'bill':
        return BillStrategy();
      case 'job':
        return JobStrategy();
      case 'transport':
        return TransportStrategy();
      case 'social':
        return SocialStrategy();
      default:
        return DefaultStrategy();
    }
  }
}

/// Stratégie par défaut pour les catégories qui n'ont pas encore de logique spécifique.
class DefaultStrategy implements EcheanceStrategy {
  @override
  List<String> getAvailableSubTypes() => [];

  @override
  String? validate(EcheanceModel echeance) => null;
}
