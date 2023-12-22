import 'package:arche/arche.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:onenavigation/impl/config.dart';
import 'package:onenavigation/impl/system.dart';
import 'package:onenavigation/impl/text.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<StatefulWidget> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
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
        body: Blur(
            colorOpacity: 0,
            overlay: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.all(12),
                    child: FittedBox(
                      child: SizedBox(
                        width: window.width,
                        height: window.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  config.home.title,
                                  style: TextStyle(
                                      fontSize: window.width /
                                          config.home.title.length),
                                ).shader()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  config.links.map((e) => e.build()).toList(),
                            )
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  width: window.width,
                  height: window.height,
                  child: const Center(
                      child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("One Navigation"),
                  )),
                ),
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
