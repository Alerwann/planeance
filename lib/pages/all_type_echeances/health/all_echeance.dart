import 'package:flutter/material.dart';
import 'package:planeance/planeance.dart';
import 'package:planeance/widget/alerte_dialogue/alerte_delete.dart';
import 'package:planeance/widget/alerte_dialogue/modif_echeance.dart';
import 'package:provider/provider.dart';

class AllEcheance extends StatefulWidget {
  const AllEcheance({super.key});

  @override
  State<AllEcheance> createState() => _AllEcheanceState();
}

class _AllEcheanceState extends State<AllEcheance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Échéances de santé")),
      body: Consumer<EcheanceProvider>(
        builder: (builder, echeanceP, _) {
          final List<EcheanceModel> listEcheance = echeanceP.getEcheanceByType(
            'health',
          );
          return Center(
            child: listEcheance.isEmpty
                ? Text("Pas d'échéances santé enregistré")
                : ListView.builder(
                    itemCount: listEcheance.length,
                    itemBuilder: (context, index) {
                      final EcheanceModel echeance = listEcheance[index];
                      return Card(
                        child: ListTile(
                          title: Text(echeance.echeanceName),
                          subtitle: Text(
                            "Date limite d'échéance : ${echeance.subType}",
                          ),
                          leading: IconButton(
                            icon: Icon(Icons.delete_forever_rounded),
                            color: Colors.red,
                            onPressed: () {
                              AlerteDelete.showDeleteDialog(
                                null,
                                echeance,
                                context,
                              );
                            },
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ModifEcheance(echeanceInput: echeance),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.mode_edit_outline_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
