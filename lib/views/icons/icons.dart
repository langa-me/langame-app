import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class MovingIcon extends StatelessWidget {
  final IconData icon;
  final double from;
  final double to;
  final double duration;
  MovingIcon(this.icon, this.from, this.to, {this.duration = 2});

  @override
  Widget build(BuildContext context) {
    return MirrorAnimation<double>(
      tween: (this.from).tweenTo(this.to), // <-- value for offset x-coordinate
      duration: this.duration.seconds,
      curve: Curves.easeInOutSine, // <-- non-linear animation
      builder: (context, child, value) {
        return Transform.translate(
          offset: Offset(value, 0), // <-- use animated value for x-coordinate
          child: child,
        );
      },
      child: Icon(icon),
    );
  }
}
