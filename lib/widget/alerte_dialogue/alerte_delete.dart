import 'package:flutter/material.dart';
import 'package:planeance/data/constant.dart';
import 'package:planeance/planeance.dart';
import 'package:provider/provider.dart';

class AlerteDelete {
 static Future<void> showDeleteDialog(
    int index,
    BuildContext context,
    String type,
  ) async {
    switch (type) {
      case Constant.typeDirectory:
        return await _showDeleteDialogDirectory(context, index);
      case Constant.typeEcheance:
        return await _showDeleteDialogecheance(context, index);
    }
  }

 static Future<void> _showDeleteDialogDirectory(
    BuildContext context,

    int index,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        final directP = Provider.of<DirectoryProvider>(context, listen: false);
        return AlertDialog(
          title: Text("Suppression de ${directP.all[index].name}"),
          content: Text(
            "Voulez vous supprimer toute la catégorie? (toutes les échéances de cette catégorie seront supprimées.)",
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await directP.deleteAt(index);
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

static  Future<void> _showDeleteDialogecheance(
    BuildContext context,
    int index,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        final echeanceP = Provider.of<EcheanceProvider>(context, listen: false);
        return AlertDialog(
          title: Text("Suppression de ${echeanceP.all[index].echeanceName}"),
          content: Text("voulez-vous réellement supprimer l'échéance ?"),
          actions: [
            TextButton(
              onPressed: () async {
                await echeanceP.deleteAt(index);
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
}
