import 'package:flutter/material.dart';

class ToDoColor {
  final int colorIndex;

  static const List<Color> predefinedColors = [
    Colors.red,
    Colors.blueGrey,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.teal,
    Colors.orange,
    Colors.pink,
    Colors.brown,
    Colors.indigo,
    Colors.cyan,
    Colors.lightBlue,
    Colors.amber,
    Colors.lime,
    Colors.deepPurple,
    Colors.deepOrange,
    Colors.lightGreen,
    Colors.deepOrangeAccent,
    Colors.lightBlueAccent,
    Colors.deepPurpleAccent,
  ];

  Color get color => predefinedColors[colorIndex];

  ToDoColor({required this.colorIndex});
}
