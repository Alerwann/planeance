import 'package:flutter/material.dart';
import 'package:planeance/planeance.dart';
import 'package:provider/provider.dart';

class ChoiceDirectoryEcheance extends StatefulWidget {
  const ChoiceDirectoryEcheance({super.key});

  @override
  State<ChoiceDirectoryEcheance> createState() =>
      _ChoiceDirectoryEcheanceState();
}

class _ChoiceDirectoryEcheanceState extends State<ChoiceDirectoryEcheance> {
  Future<void> _showDeleteDialog(
    BuildContext context,
    DirectoryProvider directP,
    int index,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Toutes les catégories")),
      body: Consumer<DirectoryProvider>(
        builder: (context, directP, _) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: directP.all.length,
            itemBuilder: (context, index) {
              final dossier = directP.all[index];
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            directP.getCategoryHome(dossier.categoryId),
                      ),
                    );
                  },
                  onLongPress: () => _showDeleteDialog(context, directP, index),
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: 0.2,
                        child: Icon(
                          Icons.folder,
                          size: 160,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      // Nom du dossier au premier plan
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          dossier.name,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              _showDeleteDialog(context, directP, index),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Consumer<DirectoryProvider>(
        builder: (context, directP, _) {
          return FloatingActionButton(
            onPressed: () {
              directP.listIsFull
                  ? null
                  : showDialog(
                      context: context,
                      builder: (context) {
                        DirectoryModel? selectedDirectory =
                            directP.availableDirectories.first;
                        return AlertDialog(
                          title: Text("Ajout d'une catégorie"),
                          content: Text('quelle catégorie ajouter'),
                          actions: [
                            DropdownButtonFormField<DirectoryModel>(
                              initialValue: selectedDirectory,
                              decoration: InputDecoration(
                                labelText: "Nom du domaine",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              items: directP.availableDirectories
                                  .map(
                                    (d) => DropdownMenuItem<DirectoryModel>(
                                      value: d,
                                      child: Text(d.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (DirectoryModel? value) {
                                if (value != null) {
                                  selectedDirectory = value;
                                }
                              },
                            ),

                            Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    if (selectedDirectory != null) {
                                      await directP.add(selectedDirectory!);
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                                  child: Text("Ajout"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Annuler"),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
            },
            backgroundColor: directP.listIsFull
                ? Colors.grey
                : Theme.of(context).colorScheme.primary,
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
