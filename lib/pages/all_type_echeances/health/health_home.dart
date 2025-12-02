import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:planeance/pages/all_type_echeances/health/all_echeance.dart';
import 'package:planeance/planeance.dart';

import 'package:planeance/widget/card_modif_delete.dart';
import 'package:provider/provider.dart';

class HealthHome extends StatelessWidget {
  const HealthHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(title: Text("Santé")),
      body: Consumer<EcheanceProvider>(
        builder: (context, echeanceP, _) {
          final echeancesList = echeanceP.getCustomListEcheance('health', 3);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                echeancesList.isEmpty
                    ? Text("Pas d'échéances santé enregistré")
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: echeancesList.length,
                        itemBuilder: (context, index) {
                          final echeance = echeancesList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CardEcheance(echeance: echeance),
                          );
                        },
                      ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateEcheance(),
                      ),
                    );
                  },
                  child: Text("Ajout d'une échéance"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LinksHealthUtils(),
                      ),
                    );
                  },
                  child: Text('Aller vers les liens'),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllEcheance()),
                    );
                  },
                  child: Text('Toutes les échéances'),
                ),
                if (kDebugMode)
                  TextButton(
                    onPressed: () async {
                      final DirectoryProvider directoryP =
                          Provider.of<DirectoryProvider>(
                            context,
                            listen: false,
                          );
                      print(directoryP.all[0].key);
                      print(echeanceP.getEcheanceByType('health')[0].key);
                      print(echeanceP.getCustomListEcheance('health', 3));
                    },
                    child: Text("afficher dans la console"),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
