import 'dart:math';
import 'package:flutter/material.dart';

///A widget indicator, which is arrow spin result
class ArrowView extends StatelessWidget {
  const ArrowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0,
      child: Image.asset(
        'packages/flutter_fortune_wheel/assets/images/arrow.png',
        width: 40,
        height: 40,
        fit: BoxFit.fill,
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
