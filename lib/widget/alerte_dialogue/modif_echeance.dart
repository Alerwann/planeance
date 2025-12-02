import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planeance/data/models/echeance/echeance_model.dart';
import 'package:planeance/providers/directory_provider.dart';
import 'package:planeance/providers/echeance_provider.dart';
import 'package:planeance/services/strategies/strategy_factory.dart';
import 'package:planeance/widget/duration_picker_dialog.dart';
import 'package:planeance/widget/succes_snake.dart';
import 'package:planeance/widget/tap_input_widget.dart';
import 'package:provider/provider.dart';

class ModifEcheance extends StatefulWidget {
  final EcheanceModel echeanceInput;
  const ModifEcheance({super.key, required this.echeanceInput});

  @override
  State<ModifEcheance> createState() => _ModifEcheanceState();
}

class _ModifEcheanceState extends State<ModifEcheance> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _beginCtrl = TextEditingController();
  final _endCtrl = TextEditingController();
  final _descriptCtrl = TextEditingController();
  final _durationCtrl = TextEditingController();

  int? _selectedDirectoryId;
  DateTime? _beginDate;
  DateTime? _endDate;

  // la durée sera a exprimer en jours
  Duration? _duration;

  // int 1 -> durée / 2 -> date de fin / 0 -> auto calcule ou rien
  final List<String> durationType = ["durée", "échéance"];
  int? chooseEnd;

  // Stratégie

  String? _selectedSubType;

  late EcheanceModel echeance = widget.echeanceInput;

  final strategy = StrategyFactory.getStrategy('health');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _beginCtrl.text = DateFormat.yMMMMd().format(echeance.beginDate);
      _endCtrl.text = DateFormat.yMMMEd().format(echeance.endDate);
      _nameCtrl.text = echeance.echeanceName;
      if (echeance.description != null) {
        _descriptCtrl.text = echeance.description!;
      }
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _beginCtrl.dispose();
    _endCtrl.dispose();
    _durationCtrl.dispose();
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
        appBar: AppBar(
          title: Text(
            "Modification d'échéance",
            maxLines: 2,
            softWrap: false,
            textAlign: TextAlign.center,
          ),
          toolbarHeight: 100,
        ),
        body: Consumer2<DirectoryProvider, EcheanceProvider>(
          builder: (context, dirProvider, echeanceP, _) {
            final subTypes = strategy.getAvailableSubTypes();
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                autovalidateMode: AutovalidateMode.onUnfocus,
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 16),
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
                    // Sous-type
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: echeance.subType,
                      decoration: const InputDecoration(
                        labelText: 'Type de précision',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      items: subTypes
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
                      validator: (v) => v == null ? 'Précision requise' : null,
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

                    if (_selectedSubType != "Ordonnance")
                      Card(
                        elevation: 0,
                        child: SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              Text("Comment calculer la fin d'échéance?"),
                              RadioGroup<int>(
                                groupValue: chooseEnd,
                                onChanged: (int? value) {
                                  setState(() {
                                    chooseEnd = value;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile(
                                        value: 1,

                                        title: Text("Durée"),
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile(
                                        value: 2,

                                        title: Text("Date"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),
                    if (chooseEnd == 1 && _selectedSubType != "Ordonnance")
                      TextFormField(
                        controller: _durationCtrl,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Durée de l'échéance",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => DurationPickerDialog(
                              onDurationChanged: (years, months, days) {
                                setState(() {
                                  final calduration =
                                      (years * 12 + months * 30 + days);
                                  _duration = Duration(days: calduration);

                                  _durationCtrl.text = afficheDuration(
                                    years,
                                    months,
                                    days,
                                  );
                                });
                              },
                            ),
                          );
                        },
                      ),

                    if (chooseEnd == 2 && _selectedSubType != "Ordonnance")
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
                    TextFormField(
                      controller: _descriptCtrl,
                      maxLength: 300,
                      minLines: 3,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Description (facultatif)",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        echeanceP.isLoading
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()) {
                                  dirProvider.all.firstWhere(
                                    (d) => d.id == _selectedDirectoryId,
                                  );
                                }

                                switch (chooseEnd) {
                                  case 0:
                                    _endDate = _beginDate!.add(
                                      Duration(days: 21),
                                    );
                                    break;
                                  case 1:
                                    _endDate = _beginDate!.add(_duration!);
                                    break;
                                  default:
                                    _endDate;
                                }
                              };

                        final newEcheance = EcheanceModel(
                          echeanceName: _nameCtrl.text,
                          beginDate: _beginDate!,
                          endDate: _endDate!,
                          category: echeance.category,
                          subType: _selectedSubType,
                          categoryId: echeance.categoryId,
                          description: _descriptCtrl.text,
                        );
                        final (success, message) = echeanceP.update(
                          echeance.key,
                          newEcheance,
                        );

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SuccesSnake.successSnake(success, message),
                          );
                        }
                        _formKey.currentState!.reset();
                        _nameCtrl.clear();
                        _beginCtrl.clear();
                        _endCtrl.clear();

                        setState(() {
                          _selectedDirectoryId = null;
                          _beginDate = null;
                          _endDate = null;
                          _selectedSubType = null;
                        });

                     
                      },
                      child: Text("Valider"),
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

  String afficheDuration(int years, int months, int days) {
    final String monthMess;
    final String yearsMess;
    final String dayMess;

    if (years != 0) {
      yearsMess = "$years an(s)";
    } else {
      yearsMess = "";
    }
    if (months != 0) {
      monthMess = "$months mois";
    } else {
      monthMess = "";
    }
    if (days != 0) {
      dayMess = "$days jour(s)";
    } else {
      dayMess = "";
    }

    return "$yearsMess $monthMess $dayMess ";
  }
}
