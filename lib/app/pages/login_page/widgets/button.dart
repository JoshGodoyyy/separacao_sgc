import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Function onPressed;

  const Button({
    super.key,
    required this.onPressed,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () => widget.onPressed(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          backgroundColor: const Color(0xFF5acce8),
        ),
        child: const Text(
          'Entrar',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
