import 'package:arche/arche.dart';
import 'package:arche/extensions/iter.dart';
import 'package:flutter/material.dart';
import 'package:onenavigation/impl/config.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NavigationPane extends StatefulWidget {
  const NavigationPane({super.key});

  @override
  State<StatefulWidget> createState() => _StateNavigationPane();
}

class _StateNavigationPane extends State<NavigationPane> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: ListExt.generatefrom(
      ArcheBus.bus.of<ConfigContainer>().links,
      functionFactory: (group) => NavigationGroupTableWidget(group),
    ));
  }
}

extension BuildButton on InternalNavigationLink {
  Widget buildButton() {
    var child = Text(name);
    onPressed() => launchUrlString(link);
    switch (type) {
      case "filled":
        return FilledButton(onPressed: onPressed, child: child);
      case "filled_tonal":
        return FilledButton.tonal(onPressed: onPressed, child: child);
      case "outline":
        return OutlinedButton(onPressed: onPressed, child: child);
      case "text":
        return TextButton(onPressed: onPressed, child: child);
      default:
        return ElevatedButton(onPressed: onPressed, child: child);
    }
  }
}

class NavigationGroupTableWidget extends StatelessWidget {
  final InternalNavigationGroup group;
  const NavigationGroupTableWidget(this.group, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.all(4), child: Text(group.group)),
      Center(
          child: Wrap(
        children: ListExt.generatefrom(group.links,
            functionFactory: (value) => Padding(
                padding: const EdgeInsets.all(4), child: value.buildButton())),
      ))
    ]);
  }
}
