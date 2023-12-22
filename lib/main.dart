import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arche/arche.dart';
import 'package:onenavigation/impl/config.dart';
import 'package:onenavigation/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var config = ArcheConfig.memory(
      init: await rootBundle.loadString("resource/config.yaml"),
      serializer: YamlSerializer());
  ArcheBus.bus.provide(config).provide(ConfigContainer.fromArche(config));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ConfigContainer config = ArcheBus.bus.of();
    return MaterialApp(
      title: config.site,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData.light(useMaterial3: true),
      home: const InitPage(),
    );
  }
}
