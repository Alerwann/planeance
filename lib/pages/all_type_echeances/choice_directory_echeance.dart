import 'package:flutter/material.dart';
import 'package:planeance/pages/all_type_echeances/add_directory.dart';
import 'package:planeance/planeance.dart';
import 'package:provider/provider.dart';

class ChoiceDirectoryEcheance extends StatefulWidget {
  const ChoiceDirectoryEcheance({super.key});

  @override
  State<ChoiceDirectoryEcheance> createState() =>
      _ChoiceDirectoryEcheanceState();
}

class _ChoiceDirectoryEcheanceState extends State<ChoiceDirectoryEcheance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Toutes tes catégories")),
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
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Suppression de ${directP.all[index].name}",
                          ),
                          content: Text(
                            "Voulez vous supprimer toute la catégorie?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                await directP.deleteAt(index);
                                if(mounted)
                            {    Navigator.pop(context);}
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
                  },
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
                  : Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddDirectory()),
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
