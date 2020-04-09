# Tridimensional Drawer

Tridimensional Drawer is an easy way to create a 3D Perspective drawer, where you can insert any type of widget.

## Demo

<img src="https://github.com/CarmineToriello95/tridimensional_drawer/raw/master/assets/tridimensional_drawer.gif" alt="drawing" width="200"/>

## Installing
Add the package to your ```pubspec.yml``` file

```yaml
dependencies:
    tridimensional_drawer: ^0.0.3
```

## Example

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
```

## Hint
If you use a widget containing a Scaffold as the mainPage, try to wrap the body of it inside a **SingleChildScrollView**, otherwise the rendering of the mainPage could go wrong at the end of the drawer opening animation. 




