import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String label;
  final Function onPressed;

  const Button({
    required this.label,
    super.key,
    required this.onPressed,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.onPressed(),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        backgroundColor: const Color(0xFF5acce8),
      ),
      child: Text(
        widget.label,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
