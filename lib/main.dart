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
    return const AppWrapper();
  }
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<StatefulWidget> createState() => StateAppWrapper();
}

class StateAppWrapper extends State<AppWrapper> {
  bool? isDark;

  @override
  void initState() {
    super.initState();
    ArcheBus.bus.provide(this);
  }

  void switchTheme() {
    setState(() {
      isDark = !isDark!;
    });
  }

  @override
  Widget build(BuildContext context) {
    ConfigContainer config = ArcheBus.bus.of();
    isDark ??= MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    return MaterialApp(
      title: config.site,
      themeMode: isDark! ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          colorScheme: config.theme.darkcolor != null
              ? ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: config.theme.darkcolor!)
              : null),
      theme: ThemeData.light(useMaterial3: true).copyWith(
          colorScheme: config.theme.lightcolor != null
              ? ColorScheme.fromSeed(
                  brightness: Brightness.light,
                  seedColor: config.theme.lightcolor!)
              : null),
      home: const HomePage(),
    );
  }
}
