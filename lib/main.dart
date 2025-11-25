import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:planeance/data/constant.dart';
import 'package:planeance/data/models/health/echeances/health_echeance_model.dart';
import 'package:planeance/planeance.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(EcheanceModelAdapter());
  Hive.registerAdapter(DirectoryModelAdapter());
  Hive.registerAdapter(HealthLinkModelAdapter());
  Hive.registerAdapter(HealthEcheanceModelAdapter());

  await Hive.openBox<EcheanceModel>(Constant.echeanceBoxName);
  await Hive.openBox<DirectoryModel>(Constant.directoryBoxName);
  await Hive.openBox<HealthLinkModel>(Constant.healthLinkBoxName);
  await Hive.openBox<HealthEcheanceModel>(Constant.healthEcheanceBoxName);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EcheanceProvider()),
        ChangeNotifierProvider(create: (_) => DirectoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: [Locale('fr')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      title: 'Planéchance',

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

      home: const Homeshell(),
    );
  }
}
