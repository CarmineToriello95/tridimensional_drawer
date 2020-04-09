import 'package:flutter/animation.dart';

class TridimensionalDrawerController {
  
  AnimationController animation;

  void toggle() {
    if (animation?.value == 0) {
      animation?.forward();
    } else {
      animation?.reverse();
    }
  }

  void open() {
    if (animation?.value == 0) {
      animation?.forward();
    }
  }

  void close() {
    if(animation?.value == 1){
      animation?.reverse();
    }
  }

  void dispose(){
    animation.dispose();
  }
}
