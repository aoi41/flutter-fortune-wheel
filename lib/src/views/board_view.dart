import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/src/helpers/helpers.dart';
import 'package:flutter_fortune_wheel/src/models/models.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_fortune_wheel/src/models/wheel_theme.dart';

///UI Wheel
class BoardView extends StatelessWidget {
  const BoardView({
    Key? key,
    required this.items,
    required this.size,
    required this.wheelTheme,
  }) : super(key: key);

  ///List of values for the wheel elements
  final List<Fortune> items;

  ///Size of the wheel
  final double size;

  final WheelTheme wheelTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(
          items.length,
          (index) => _buildSlicedCircle(items[index]),
        ),
      ),
    );
  }

  Widget _buildSlicedCircle(Fortune fortune) {
    double _rotate = getRotateOfItem(
      items.length,
      items.indexOf(fortune),
    );
    return Transform.rotate(
      angle: _rotate,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildCard(fortune),
          _buildValue(fortune),
        ],
      ),
    );
  }

  Widget _buildCard(Fortune fortune) {
    double _angle = 2 * math.pi / items.length;
    return CustomPaint(
      painter: _BorderPainter(_angle, wheelTheme,),
      child: ClipPath(
        clipper: _SlicesPath(_angle),
        child: Container(
          height: size,
          width: size,
          color: fortune.backgroundColor,
        ),
      ),
    );
  }

  Widget _buildValue(Fortune fortune) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 18),
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(height: size / 3, width: 54),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (fortune.titleName != null)
              Flexible(
                child: AutoSizeText(
                  fortune.titleName!,
                  style: fortune.textStyle ??
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  minFontSize: 10,
                  maxFontSize: 20,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                ),
              ),
            if (fortune.icon != null)
              Padding(
                padding: EdgeInsets.all(fortune.titleName != null ? 4 : 0),
                child: fortune.icon!,
              ),
          ],
        ),
      ),
    );
  }
}

///Wheel frame painter
class _BorderPainter extends CustomPainter {
  final double angle;
  final WheelTheme wheelTheme;

  _BorderPainter(this.angle, this.wheelTheme,);

  @override
  void paint(Canvas canvas, Size size) {
    const double radiusDot = 3;
    double radius = size.width / 2;
    Offset center = size.center(Offset.zero);

    //Outer border
    Paint outlineBrush = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0
      ..shader = (wheelTheme.useRadialGradient
          ? RadialGradient(
              colors: wheelTheme.borderGradientColors,
              stops: wheelTheme.gradientStops,
              center: Alignment.center,
              radius: 1.0,
            )
          : SweepGradient(
              colors: wheelTheme.borderGradientColors,
              stops: wheelTheme.gradientStops,
              startAngle: 0,
              endAngle: 2 * math.pi,
            )).createShader(Rect.fromCircle(center: center, radius: size.width / 2));

    Rect rect = Rect.fromCircle(center: center, radius: size.width / 2);
    Path pathFirst = Path()
      ..arcTo(rect, -math.pi / 2 - angle / 2, angle, false);

    //Second frame with white background
    Paint outlineBrushSecond = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..color = Colors.white;
    Rect rectSecond =
        Rect.fromCircle(center: center, radius: size.width / 2 + 10);
    Path pathSecond = Path()
      ..arcTo(rectSecond, -math.pi / 2 - angle / 2, angle, false);

    //LED lights
    Paint centerDot = Paint()
      ..style = PaintingStyle.fill
      ..color = wheelTheme.centerDotColor
      ..strokeWidth = 4.0;

    Paint secondaryDot = Paint()
      ..style = PaintingStyle.fill
      ..color = wheelTheme.secondaryDotColor
      ..strokeWidth = 4.0;

    //Coordinates of the center of the circle
    Offset centerSlice = Offset(radius, 0);

    //Coordinate difference coefficient between two ends of the circular arc
    double dxFactor = math.sin(angle / 2) * radius;
    double dyFactor = math.cos(angle / 2) * radius;

    Offset rightSlice = Offset(radius - dxFactor, radius - dyFactor);
    Offset leftSlice = Offset(radius + dxFactor, radius - dyFactor);

    canvas.drawPath(pathFirst, outlineBrush);
    canvas.drawPath(pathSecond, outlineBrushSecond);
    canvas.drawCircle(centerSlice, radiusDot, centerDot);
    canvas.drawCircle(rightSlice, radiusDot, secondaryDot);
    canvas.drawCircle(leftSlice, radiusDot, secondaryDot);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _SlicesPath extends CustomClipper<Path> {
  final double angle;

  _SlicesPath(this.angle);

  @override
  Path getClip(Size size) {
    Offset center = size.center(Offset.zero);
    Rect rect = Rect.fromCircle(center: center, radius: size.width / 2 - 7);
    Path path = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(rect, -math.pi / 2 - angle / 2, angle, false)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(_SlicesPath oldClipper) {
    return angle != oldClipper.angle;
  }
}
