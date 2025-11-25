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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
