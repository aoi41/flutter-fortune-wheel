import 'package:flutter/material.dart';

class WheelTheme {
  final List<Color> segmentColors;
  final List<Color> borderGradientColors;
  final List<double>? gradientStops;
  final Color centerButtonColor;
  final double borderWidth;
  final Color textColor;
  final Color secondaryBorderColor;
  final double secondaryBorderWidth;
  final Color centerDotColor;
  final Color secondaryDotColor;
  final bool useRadialGradient;
  final String spinButtonImage;
  final String spinButtonPressedImage;
  final String arrowImage;
  final Alignment arrowAlignment; 
  final double arrowSize;
  
  const WheelTheme({
    required this.segmentColors,
    required this.borderGradientColors,
    this.gradientStops,
    this.centerButtonColor = Colors.white,
    this.borderWidth = 20.0,
    this.textColor = Colors.white,
    this.secondaryBorderColor = Colors.white,
    this.secondaryBorderWidth = 5.0,
    this.centerDotColor = const Color(0xFFFE7479),
    this.secondaryDotColor = const Color(0xFFFFB57C),
    this.useRadialGradient = true,
    this.spinButtonImage = 'packages/flutter_fortune_wheel/assets/images/play_button.png',
    this.spinButtonPressedImage = 'packages/flutter_fortune_wheel/assets/images/play_button_pressed.png',
    this.arrowImage = 'packages/flutter_fortune_wheel/assets/images/arrow.png',
    this.arrowAlignment = const Alignment(0, -1.38),
    this.arrowSize = 40.0,
  });
  
  // Predefined themes
  static const WheelTheme standard = WheelTheme(
    segmentColors: [Color(0xFFFF4D9C), Color(0xFF924CE9)],
    borderGradientColors: [Color(0xFF2D0075), Color(0xFF5E17B4), Color(0xFFC46B8A)],
    centerDotColor: Color(0xFFFFD700),
    secondaryDotColor: Color(0xFFFFB57C),
    useRadialGradient: true,
  );
  
  static const WheelTheme upgraded = WheelTheme(
    segmentColors: [Color(0xFFE59FEB), Color(0xFFE7C9F4)],
    borderGradientColors: [ Color(0xFFFF517E), Color(0xFFC235FC), Color(0xFFFF51B6)],
    gradientStops: [0.0, 0.5, 1.0],
    borderWidth: 25.0,
    useRadialGradient: false,
    centerDotColor: Color(0xFFF3D88D),
    secondaryDotColor: Color(0xFFF3D88D),
    spinButtonImage: 'packages/flutter_fortune_wheel/assets/images/play_button_upgraded.png',
    spinButtonPressedImage: 'packages/flutter_fortune_wheel/assets/images/play_button_upgraded_pressed.png',
    arrowImage: 'packages/flutter_fortune_wheel/assets/images/arrow_upgraded.png', 
    arrowAlignment: Alignment(0, -0.3),
    arrowSize: 20.0, 
  );
}