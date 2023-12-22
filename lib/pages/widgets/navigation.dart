import 'package:flutter/material.dart';

class NavigationPane extends StatefulWidget {
  const NavigationPane({super.key});

  @override
  State<StatefulWidget> createState() => _StateNavigationPane();
}

class _StateNavigationPane extends State<NavigationPane> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
            padding: EdgeInsets.all(4), child: Text("Link Collection One")),
        Center(
            child: Wrap(
          children: List.generate(
              20,
              (index) => Padding(
                  padding: const EdgeInsets.all(4),
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("Link")))),
        ))
      ],
    );
  }
}
