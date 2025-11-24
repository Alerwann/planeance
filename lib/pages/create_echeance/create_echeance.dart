import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:planeance/planeance.dart';
import 'package:planeance/widget/tap_input_widget.dart';
import 'package:provider/provider.dart';

/// Page permettant de créer une nouvelle [EcheanceModel].
///
/// Le formulaire comprend :
/// * le nom de l’échéance,
/// * le domaine (répertoire) sélectionné via un [DropdownButtonFormField],
/// * la date de début et la date de fin (sélectionnées avec un date‑picker).
///
/// La validation assure que le nom n’est pas vide et que la date de fin
/// est postérieure à la date de début. En cas de succès, l’échéance est
/// ajoutée via [EcheanceProvider] et un [SnackBar] de confirmation est
/// affiché.
class CreateEcheance extends StatefulWidget {
  const CreateEcheance({super.key});

  @override
  State<CreateEcheance> createState() => _CreateEcheanceState();
}

class _CreateEcheanceState extends State<CreateEcheance> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _beginCtrl = TextEditingController();
  final _endCtrl = TextEditingController();

  int? _selectedDirectoryId;
  DateTime? _beginDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _beginCtrl.dispose();
    _endCtrl.dispose();
    super.dispose();
  }



  /// Construit l’interface de création d’une échéance.
  ///
  /// Le widget est composé d’un [Form] contenant :
  /// * un champ texte pour le nom,
  /// * un [DropdownButtonFormField] pour choisir le domaine,
  /// * deux champs date‑picker pour la date de début et de fin,
  /// * un bouton de validation qui crée l’objet [EcheanceModel] et l’ajoute
  ///   via le [EcheanceProvider].
  ///
  /// Des [SnackBar] indiquent le succès ou les erreurs de validation.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Création d\'une échéance')),
        body: Consumer2<DirectoryProvider, EcheanceProvider>(
          builder: (context, dirProvider, echeanceP, _) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                autovalidateMode: AutovalidateMode.onUnfocus,
                key: _formKey,
                child: ListView(
                  children: [
                    // Nom
                    TextFormField(
                      controller: _nameCtrl,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Nom de l’échéance',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (champs) =>
                          champs == null || champs.isEmpty ? 'Champ obligatoire' : null,
                    ),
                    const SizedBox(height: 16),

                    // Répertoire (dropdown)
                    DropdownButtonFormField<int>(
                      decoration: const InputDecoration(
                        labelText: 'Domaine',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      items: dirProvider.all
                          .map(
                            (d) => DropdownMenuItem<int>(
                              value: d.id,
                              child: Text(d.name),
                            ),
                          )
                          .toList(),
                      initialValue: _selectedDirectoryId,
                      onChanged: (v) =>
                          setState(() => _selectedDirectoryId = v),
                      validator: (v) =>
                          v == null ? 'Sélectionnez un domaine' : null,
                    ),
                    const SizedBox(height: 16),

                    // Date de début
                    TapInputWideget(
                      nameInput: 'Date de début',
                      nameController: _beginCtrl,
                      onDateSelected: (nouvelleDate) {
                        setState(() {
                          _beginDate = nouvelleDate;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Date de fin
                    TapInputWideget(
                      nameInput: 'Date de fin',
                      nameController: _endCtrl,
                      onDateSelected: (nouvelleDate) {
                        setState(() {
                          _endDate = nouvelleDate;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Bouton Valider
                    ElevatedButton(
                      onPressed: echeanceP.isLoading
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()) {
                                final newEcheance = EcheanceModel(
                                  echeanceName: _nameCtrl.text,
                                  beginDate: _beginDate!,
                                  endDate: _endDate!,
                                  directoryId: _selectedDirectoryId!,
                                );

                                final ok = await echeanceP.add(newEcheance);

                                if (ok && mounted) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Échéance ajoutée ✅'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  _formKey.currentState!.reset();
                                  _nameCtrl.clear();
                                  _beginCtrl.clear();
                                  _endCtrl.clear();

                                  setState(() {
                                    _selectedDirectoryId = null;
                                    _beginDate = null;
                                    _endDate = null;
                                  });
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                content: Text(
                                      echeanceP.errorMessage ??
                                          'Erreur inconnue lors de l\'ajout',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                      child: const Text('Valider'),
                    ),
                    if (kDebugMode)
                      TextButton(
                        onPressed: () async {
                          await dirProvider.deleteAll();
                          await dirProvider.ensureDefaults();

                          setState(() {});
                        },
                        child: Text("Clear"),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
