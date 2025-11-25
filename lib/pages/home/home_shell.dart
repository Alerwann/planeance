import 'package:flutter/material.dart';
import 'package:planeance/pages/all_type_echeances/choice_directory_echeance.dart';
import 'package:planeance/pages/create_echeance/create_echeance.dart';
import 'package:planeance/pages/home/home.dart';
import 'package:planeance/pages/parameters/parameters.dart';
import 'package:planeance/theme/extensions/custom_colors.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

/// Widget principal de l'application qui gère la navigation entre les
/// différentes pages (Home, Création d'échéance, Paramètres) via une
/// barre de navigation stylisée.
class Homeshell extends StatefulWidget {
  const Homeshell({super.key});

  @override
  State<Homeshell> createState() => _HomeshellState();
}

/// État interne de [Homeshell] qui conserve l'index de la page
/// actuellement affichée et reconstruit l'interface lorsqu'il change.
class _HomeshellState extends State<Homeshell> {
  int _currentIndex = 0;

  /// Construit le widget contenant la page courante et la barre de navigation
  /// en bas. Le corps affiche la page correspondant à `_currentIndex`.
  @override
  Widget build(BuildContext context) {
    final List pages = [
      Home(),
      ChoiceDirectoryEcheance(),
      CreateEcheance(),
      Parameters(),
    ];
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: StylishBottomBar(
        currentIndex: _currentIndex,
        backgroundColor: Theme.of(context).colorScheme.primary,
        option: AnimatedBarOptions(iconStyle: IconStyle.animated),
        hasNotch: false,

        items: [
          BottomBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            title: Text("Planning"),
            selectedColor: Theme.of(
              context,
            ).extension<CustomSelectColors>()!.selectedIcon,
            unSelectedColor: Theme.of(
              context,
            ).extension<CustomUnselectColors>()!.unselectedIcon,
          ),
          BottomBarItem(
            icon: Icon(Icons.folder),
            title: Text("Dossiers"),
            selectedColor: Theme.of(
              context,
            ).extension<CustomSelectColors>()!.selectedIcon,
            unSelectedColor: Theme.of(
              context,
            ).extension<CustomUnselectColors>()!.unselectedIcon,
          ),
          BottomBarItem(
            icon: Icon(Icons.add_home_work_rounded),
            title: Text("Échéances"),
            selectedColor: Theme.of(
              context,
            ).extension<CustomSelectColors>()!.selectedIcon,
            unSelectedColor: Theme.of(
              context,
            ).extension<CustomUnselectColors>()!.unselectedIcon,
          ),
          BottomBarItem(
            selectedColor: Theme.of(
              context,
            ).extension<CustomSelectColors>()!.selectedIcon,
            unSelectedColor: Theme.of(
              context,
            ).extension<CustomUnselectColors>()!.unselectedIcon,
            icon: Icon(Icons.settings_applications_rounded),
            title: Text("Paramètres"),
          ),
        ],
        onTap: (value) => {
          setState(() {
            _currentIndex = value;
          }),
        },
      ),
    );
  }
}
