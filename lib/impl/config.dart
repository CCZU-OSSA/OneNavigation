import 'package:arche/abc/typed.dart';
import 'package:arche/arche.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:yaml/yaml.dart';

class YamlSerializer<K, V> implements MapSerializer<K, V, String> {
  @override
  Map<K, V> decode(String data) {
    return loadYaml(data);
  }

  @override
  String encode(Map<K, V> object) {
    throw UnimplementedError();
  }
}

// READ ONLY
class ConfigContainer {
  late InternalHome home;
  late List<InternalLink> links;
  late String site;
  late String footer;

  static ConfigContainer fromArche(ArcheConfig config) {
    var container = ConfigContainer();
    container.home = InternalHome.fromMap(config.get("home"));
    container.site = config.getOr("site", "One Navigation");
    container.footer =
        config.getOr("footer", "Copyright © 2023 One Navigation");
    container.links = (config.getOr("links", []) as YamlList)
        .toList()
        .map((e) => InternalLink.fromMap(e))
        .toList();
    return container;
  }
}

class InternalHome {
  String title;
  List<Color> colors;
  InternalHome(this.title, this.colors);
  static fromMap<K, V>(Map<K, V> map) {
    List rawcolors = (map["colors"] as YamlList).toList();
    return InternalHome(map["title"].toString(),
        List.generate(rawcolors.length, (index) => Color(rawcolors[index])));
  }
}

class InternalLink {
  String name;
  String link;
  InternalLink(this.name, this.link);
  static InternalLink fromMap<K, V>(Map<K, V> map) {
    return InternalLink(map["name"].toString(), map["link"].toString());
  }

  Widget build() {
    return FilledButton(
        onPressed: () => launchUrlString(link), child: Text(name));
  }
}
