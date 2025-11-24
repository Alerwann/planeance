import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:planeance/planeance.dart';
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

  /// Affiche un sélecteur de date et met à jour le contrôleur et la valeur.
  ///
  /// * **ctrl** : le [TextEditingController] du champ texte à mettre à jour.
  /// * **onPicked** : callback exécuté avec la [DateTime] sélectionnée.
  ///
  /// La fonction ne fait rien si l’utilisateur annule le sélecteur.
  Future<void> _pickDate({
    required TextEditingController ctrl,
    required ValueChanged<DateTime> onPicked,
  }) async {
    final date = await showDatePicker(
      context: context,
      locale: const Locale('fr', 'FR'),
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime(2050),
    );
    if (date != null) {
      ctrl.text = '${date.day}/${date.month}/${date.year}';
      onPicked(date);
    }
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
    return Scaffold(
      appBar: AppBar(title: const Text('Création d\'une échéance')),
      body: Consumer<DirectoryProvider>(
        builder: (context, dirProvider, _) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  // Nom
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Nom de l’échéance',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Champ obligatoire' : null,
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
                    onChanged: (v) => setState(() => _selectedDirectoryId = v),
                    validator: (v) =>
                        v == null ? 'Sélectionnez un domaine' : null,
                  ),
                  const SizedBox(height: 16),

                  // Date de début
                  TextFormField(
                    controller: _beginCtrl,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Date de début',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onTap: () => _pickDate(
                      ctrl: _beginCtrl,
                      onPicked: (d) => _beginDate = d,
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Choisissez une date' : null,
                  ),
                  const SizedBox(height: 16),

                  // Date de fin
                  TextFormField(
                    controller: _endCtrl,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Date de fin',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onTap: () => _pickDate(
                      ctrl: _endCtrl,
                      onPicked: (d) => _endDate = d,
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Choisissez une date ' : null,
                  ),
                  const SizedBox(height: 24),

                  // Bouton Valider
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          _endDate!.isAfter(_beginDate!)) {
                        final newEcheance = EcheanceModel(
                          echeanceName: _nameCtrl.text,
                          beginDate: _beginDate!,
                          endDate: _endDate!,
                          directoryId: _selectedDirectoryId!,
                        );

                        final ok = await Provider.of<EcheanceProvider>(
                          context,
                          listen: false,
                        ).add(newEcheance);

                        if (ok && mounted) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Échéance ajoutée ✅'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          _formKey.currentState!.reset();
                          setState(() {
                            _selectedDirectoryId = null;
                            _beginDate = null;
                            _endDate = null;
                          });
                        }
                      } else if (_endDate!.isBefore(_beginDate!)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'La date de fin doit être après la date de début ❌',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Erreur d\'ajout'),
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
    );
  }
}
