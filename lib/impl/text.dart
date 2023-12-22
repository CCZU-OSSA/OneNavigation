import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

extension FancyText on Text {
  Widget border() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          data ?? "",
          style: style?.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 20
                ..color = Colors.black),
        ),
        this,
      ],
    );
  }
}

class ShaderString {
  String text;
  List<Color> colors;
  int get length => text.length;
  ShaderString(this.text, this.colors);

  static ShaderString fromMap(Map map) {
    YamlList colors = map["colors"] ?? YamlList();
    return ShaderString(map["text"], colors.map((e) => Color(e)).toList());
  }

  Widget render({TextStyle? style}) {
    var inner = Text(
      text,
      style: style,
    );
    return colors.isEmpty
        ? inner
        : ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: colors,
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: inner,
          );
  }
}
