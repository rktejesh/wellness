import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircularIconButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onPressed;

  const CircularIconButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(30),
        backgroundColor: Colors.white, // <-- Button color
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              iconPath,
              width: 50, // Adjust the size as needed
              height: 50, // Adjust the size as needed
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF0070bc),
            ), // Adjust the label font size
          ),
        ],
      ),
    );
  }
}
