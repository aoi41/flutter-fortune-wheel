import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/src/models/wheel_theme.dart';

///A widget indicator, which is arrow spin result
class ArrowView extends StatelessWidget {
  final WheelTheme wheelTheme;
  const ArrowView({Key? key, required this.wheelTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: wheelTheme.arrowAlignment,
      child: Transform.rotate(
        angle: 0,
        child: Image.asset(
          wheelTheme.arrowImage,
          width: wheelTheme.arrowSize,
          height: wheelTheme.arrowSize,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class _ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset center = size.center(Offset.zero);
    Path path = Path()
      ..lineTo(center.dx, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(center.dx, size.height / 4);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
