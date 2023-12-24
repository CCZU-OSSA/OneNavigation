import 'package:arche/abc/typed.dart';
import 'package:arche/arche.dart';
import 'package:flutter/material.dart';
import 'package:onenavigation/impl/text.dart';
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
  late List<InternalNavigationGroup> links;
  late InternalTheme theme;
  late String site;
  late String footer;

  static ConfigContainer fromArche(ArcheConfig config) {
    var container = ConfigContainer();
    container.home = InternalHome.fromMap(config.get("home"));
    container.site = config.getOr("site", "One Navigation");
    container.footer =
        config.getOr("footer", "Copyright © 2023 One Navigation");
    container.links = (config.getOr("navigation", []) as YamlList)
        .toList()
        .map((e) => InternalNavigationGroup.fromMap(e))
        .toList();
    container.theme = InternalTheme.fromMap(config.get("theme"));
    return container;
  }
}

class InternalTheme {
  Color? lightcolor;
  Color? darkcolor;
  InternalTheme(this.lightcolor, this.darkcolor);
  static InternalTheme fromMap(Map map) {
    toColor(int? v) => v != null ? Color(v) : null;
    return InternalTheme(toColor(map["lightcolor"]), toColor(map["darkcolor"]));
  }
}

class InternalHome {
  bool logo;
  ShaderString title;
  ShaderString subtitle;
  InternalHome(this.logo, this.title, this.subtitle);
  static fromMap(Map map) {
    return InternalHome(map["logo"], ShaderString.fromMap(map["title"]),
        ShaderString.fromMap(map["subtitle"]));
  }
}

class InternalNavigationGroup {
  String group;
  List<InternalNavigationLink> links;
  InternalNavigationGroup(this.group, this.links);
  static InternalNavigationGroup fromMap(Map map) {
    return InternalNavigationGroup(
        map["group"] ?? "",
        (map["links"] as List)
            .map((e) => InternalNavigationLink.fromMap(e))
            .toList());
  }
}

class InternalNavigationLink {
  String name;
  String link;
  String type;
  InternalNavigationLink(this.name, this.link, this.type);
  static InternalNavigationLink fromMap(Map map) {
    return InternalNavigationLink(map["name"] ?? "Unknown", map["link"] ?? "",
        (map["type"] ?? "elevated").toString().toLowerCase());
  }
}
