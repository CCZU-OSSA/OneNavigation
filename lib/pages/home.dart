import 'package:arche/arche.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:onenavigation/impl/config.dart';
import 'package:onenavigation/impl/system.dart';
import 'package:onenavigation/main.dart';
import 'package:onenavigation/pages/widgets/navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    window.onResize(
      () => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    ConfigContainer config = ArcheBus.bus.of();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => ArcheBus.bus.of<StateAppWrapper>().switchTheme(),
          child: const Icon(Icons.color_lens),
        ),
        body: Blur(
            colorOpacity: 0,
            overlay: ListView(
              children: [
                SizedBox(
                    width: window.width,
                    height: window.height,
                    child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: FittedBox(
                          child: SizedBox(
                            width: window.width,
                            height: window.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                config.home.logo
                                    ? Image.asset(
                                        "resource/logo.png",
                                        width: window.width / 8,
                                        height: window.width / 8,
                                      )
                                    : const SizedBox.shrink(),
                                Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: config.home.title.render(
                                        style: TextStyle(
                                            fontSize: window.width /
                                                config.home.title.length))),
                                Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: config.home.subtitle.render(
                                        style: TextStyle(
                                            fontSize: window.width /
                                                config.home.subtitle.length /
                                                5 *
                                                2))),
                                config.home.logo
                                    ? SizedBox(
                                        height: window.width / 8,
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                          ),
                        ))),
                SizedBox(
                    width: window.width,
                    height: window.height,
                    child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SizedBox(
                          width: window.width,
                          height: window.height,
                          child: const Center(
                              child: Card(
                                  child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: NavigationPane()))),
                        ))),
                SizedBox(
                  width: window.width,
                  child: Center(
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(config.footer)),
                  ),
                )
              ],
            ),
            child: const SizedBox.expand()));
  }
}
