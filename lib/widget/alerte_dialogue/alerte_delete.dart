import 'package:flutter/material.dart';
import 'package:planeance/planeance.dart';
import 'package:provider/provider.dart';

class AlerteDelete {
  static Future<void> showDeleteDialog(
    DirectoryModel? direct,
    EcheanceModel? echeance,
    BuildContext context,

  ) {
    if (direct != null) {
      return _showDeleteDialogDirectory(context, direct);
    } else if (echeance != null) {
      return _showDeleteDialogecheance(context, echeance);
    } else {
     return _showErrorDialog(context);
    }
  }

  static Future<void> _showDeleteDialogDirectory(
    BuildContext context,
    DirectoryModel direct,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        final directP = Provider.of<DirectoryProvider>(context, listen: false);
        return AlertDialog(
          title: Text("Suppression de ${direct.name}"),
          content: Text(
            "Voulez vous supprimer toute la catégorie? (toutes les échéances de cette catégorie seront supprimées.)",
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await directP.deleteOne(direct.key);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text("Oui"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Non"),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _showDeleteDialogecheance(
    BuildContext context,
    EcheanceModel echeance,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        final echeanceP = Provider.of<EcheanceProvider>(context, listen: false);
        return AlertDialog(
          title: Text("Suppression de ${echeance.echeanceName}"),
          content: Text("voulez-vous réellement supprimer l'échéance ?"),
          actions: [
            TextButton(
              onPressed: () async {
                echeanceP.deleteOne(echeance.key);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text("Oui"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Non"),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SnackBar(
          content: Text("Impossible d'ouvrir la boite de dialogue"),
          backgroundColor: Colors.red,
        );
      },
    );
  }
}
