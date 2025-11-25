import 'package:planeance/data/models/health/links/health_link_model.dart';

class HealthLinkList {
  static List<HealthLinkModel> get allLinks {
    final list = [
      HealthLinkModel(
        nameWebStite: "Ameli",
        externLink: "https://www.ameli.fr",
        description:
            "Site permettant d'accéder à son dossier de la sécurité sociale et de communiquer avec celle-ci.",
      ),
      HealthLinkModel(
        nameWebStite: "MDPH",
        externLink: "https://mdphenligne.cnsa.fr",
        description:
            "La MDPH.fr (Maison Départementale des Personnes en situations de Handicap) est le sité répertoriant les informations et les démarches pour les personnes en situation de handicap.",
      ),
      HealthLinkModel(
        nameWebStite: "Mon espace santé",
        externLink: "https://www.monespacesante.fr/",
        description:
            "Site permettant de centraliser ces informations médicales, les partager entre les professionnels et gérer ses documents sur ces volonters.\nTous les professionnels ne l'utilisent pas encore.",
      ),
      HealthLinkModel(
        nameWebStite: "Ministère de la santé",
        externLink: 'https://sante.gouv.fr',
        description: "Site officiel du ministère de la santé",
      ),
      HealthLinkModel(
        nameWebStite: "MSA",
        externLink: "https://www.msa.fr",
        description:
            "Site de la sécurité sociale pour les salariés ou non agricoles.",
      ),
      HealthLinkModel(
        nameWebStite: "Santé.fr",
        externLink: "https://www.sante.fr",
        description:
            "Le moteur de recherche du service public d'information en santé. Annuaire des professionnels, informations fiables et actualités.",
      ),
      HealthLinkModel(
        nameWebStite: "Santé Publique France",
        externLink: "https://www.santepubliquefrance.fr",
        description:
            "Agence nationale de santé publique. Surveillance épidémiologique, prévention et promotion de la santé.",
      ),
      HealthLinkModel(
        nameWebStite: "Haute Autorité de Santé",
        externLink: "https://www.has-sante.fr",
        description:
            "Autorité publique indépendante qui contribue à la régulation du système de santé par la qualité.",
      ),
      HealthLinkModel(
        nameWebStite: "Manger Bouger",
        externLink: "https://www.mangerbouger.fr",
        description:
            "Site du Programme National Nutrition Santé. Conseils pour bien manger et bouger plus.",
      ),
      HealthLinkModel(
        nameWebStite: "Tabac Info Service",
        externLink: "https://www.tabac-info-service.fr",
        description:
            "Service d'aide et d'accompagnement pour l'arrêt du tabac.",
      ),
      HealthLinkModel(
        nameWebStite: "Drogues Info Service",
        externLink: "https://www.drogues-info-service.fr",
        description:
            "Service national d'aide à distance en matière de drogues et de dépendances.",
      ),
    ];
    list.sort((a, b) => a.nameWebStite.compareTo(b.nameWebStite));
    return list;
  }
}
