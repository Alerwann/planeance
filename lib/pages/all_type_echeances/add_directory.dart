import 'package:flutter/material.dart';
import 'package:planeance/planeance.dart';
import 'package:provider/provider.dart';

class AddDirectory extends StatefulWidget {
  const AddDirectory({super.key});

  @override
  State<AddDirectory> createState() => _AddDirectoryState();
}

class _AddDirectoryState extends State<AddDirectory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajout d'un répertoir")),
      body: Consumer<DirectoryProvider>(
        builder: (context, directP, _) {
          return Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await directP.add(
                      DirectoryModel(id: 8, name: 'Essai', categoryId: 'essai'),
                    );
                    directP.stateIsFull();
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Ajoute une catégorie'),
                ),
                ElevatedButton(
                  onPressed: () async {
        
                    await directP.deleteAt(directP.all.length-1);
                  },
                  child: Text("Efface l'essai"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
