# tridimensional_drawer

Tridimensional Drawer is an easy way to create a 3D Perspective drawer, where you can insert any type of widget.

<img src="tridimensional_drawer.gif" alt="drawing" width="200"/>

# Getting started

To use this plugin, add 'tridimensional_drawer' as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/packages-and-plugins/using-packages)

# Example

```dart
import 'package:flutter/material.dart';
import 'package:tridimensional_drawer/tridimensional_drawer.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final TridimensionalDrawerController controller =
      TridimensionalDrawerController();

  @override
  Widget build(BuildContext context) {
    return TridimensionalDrawer(
      controller: controller,
      mainPage: GestureDetector(
        onTap: () => controller.open(),
        child: MainPage(),
      ),
      drawer: Drawer(),
      backgroundPage: GestureDetector(
        onTap: () => controller.close(),
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}



