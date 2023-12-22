import 'package:arche/arche.dart';
import 'package:flutter/material.dart';
import 'package:onenavigation/impl/config.dart';

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

  Widget shader() {
    ConfigContainer config = ArcheBus.bus.of();
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: config.home.colors,
            tileMode: TileMode.mirror,
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcATop,
        child: this);
  }
}
