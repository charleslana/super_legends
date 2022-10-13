import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_legends/pages/battle_page.dart';
import 'package:super_legends/providers/battle_provider.dart';
import 'package:super_legends/stores/battle_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.black,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Super Legends',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BattleProvider(
        notifier: BattleStore(),
        child: const BattlePage(),
      ),
    );
  }
}
