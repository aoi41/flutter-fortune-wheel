import 'package:flutter/material.dart';

class ImageButton extends StatefulWidget {
  final String normalImage; // Path to the normal image
  final String pressedImage; // Path to the pressed image
  final VoidCallback onTap; // Callback for tap event

  const ImageButton({
    Key? key,
    required this.normalImage,
    required this.pressedImage,
    required this.onTap,
  }) : super(key: key);

  @override
  _ImageButtonState createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  bool _isPressed = false; // Track the button state

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true; // Button is pressed
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false; // Button is released
        });
        widget.onTap(); // Call the onTap callback
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false; // Button press was canceled
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            _isPressed ? widget.pressedImage : widget.normalImage,
            width: 60, // Set width as needed
            height: 40, // Set height as needed
            fit: BoxFit.fill, // Cover the entire container
          ),
        ),
      ),
    );
  }
}
