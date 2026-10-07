import 'package:flutter/material.dart';
import 'screens/catalogo_screen.dart';
import 'services/lifecycle_log.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(CatalogoApp(log: LifecycleLog()));
}

class CatalogoApp extends StatelessWidget {
  final LifecycleLog log;
  const CatalogoApp({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja de Jogos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: CatalogoScreen(log: log),
    );
  }
}
