import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:planeance/planeance.dart';
import 'package:planeance/services/strategies/strategy_factory.dart';
import 'package:planeance/widget/succes_snake.dart';
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

  // Stratégie
  List<String> _subTypes = [];
  String? _selectedSubType;

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
                      validator: (champs) => champs == null || champs.isEmpty
                          ? 'Champ obligatoire'
                          : null,
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
                      onChanged: (v) {
                        setState(() {
                          _selectedDirectoryId = v;
                          _selectedSubType = null;
                          _subTypes = [];
                        });

                        if (v != null) {
                          final selectedDir = dirProvider.all.firstWhere(
                            (d) => d.id == v,
                          );
                          final strategy = StrategyFactory.getStrategy(
                            selectedDir.categoryId,
                          );
                          setState(() {
                            _subTypes = strategy.getAvailableSubTypes();
                          });
                        }
                      },
                      validator: (v) =>
                          v == null ? 'Sélectionnez un domaine' : null,
                    ),
                    const SizedBox(height: 16),

           

                    // Sous-type (si disponible)
                    if (_subTypes.isNotEmpty) ...[
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Type de précision',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        items: _subTypes
                            .map(
                              (t) => DropdownMenuItem<String>(
                                value: t,
                                child: Text(
                                  t,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            )
                            .toList(),

                        onChanged: (v) => setState(() => _selectedSubType = v),
                        validator: (v) =>
                            v == null ? 'Précision requise' : null,
                      ),
                      const SizedBox(height: 16),
                    ],

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
                      startDateTime: _beginDate,
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
                                final selectedDir = dirProvider.all.firstWhere(
                                  (d) => d.id == _selectedDirectoryId,
                                );

                                final newEcheance = EcheanceModel(
                                  echeanceName: _nameCtrl.text,
                                  beginDate: _beginDate!,
                                  endDate: _endDate!,
                                  category: selectedDir.name,
                                  subType: _selectedSubType,
                                  categoryId: selectedDir.categoryId,
                                );

                                final (success, message) = echeanceP.add(
                                  newEcheance,
                                );

                                if (mounted) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SuccesSnake.successSnake(success, message),
                                  );
                                }

                                if (success) {
                                  _formKey.currentState!.reset();
                                  _nameCtrl.clear();
                                  _beginCtrl.clear();
                                  _endCtrl.clear();

                                  setState(() {
                                    _selectedDirectoryId = null;
                                    _beginDate = null;
                                    _endDate = null;
                                    _selectedSubType = null;
                                    _subTypes = [];
                                  });
                                }
                              }
                            },
                      child: const Text('Valider'),
                    ),
                    if (kDebugMode)
                      Column(
                        children: [
                          TextButton(
                            onPressed: () async {
                              await dirProvider.deleteAll();
                              await dirProvider.ensureDefaults();

                              setState(() {});
                            },
                            child: Text("Clear"),
                          ),
                          TextButton(
                            onPressed: () async {
                              await dirProvider.deleteAt(
                                dirProvider.all.length - 1,
                              );
                              dirProvider.stateIsFull();
                            },
                            child: Text("Delete one"),
                          ),
                        ],
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
