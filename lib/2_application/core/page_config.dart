import 'package:flutter/material.dart';

class PageConfig {
  final IconData icon;
  final String title;
  final Widget child;

  const PageConfig({
    required this.icon,
    required this.title,
    Widget? child
  }) : child = child ?? const Placeholder();
}

