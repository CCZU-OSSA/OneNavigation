import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class WindowsManager {
  double get height => html.window.innerHeight?.toDouble() ?? 1080;
  double get width => html.window.innerWidth?.toDouble() ?? 1920;
  void onResize(VoidCallback callback) => html.window.onResize.listen((event) {
        callback();
      });
}

var window = WindowsManager();
