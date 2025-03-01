import 'package:flutter/material.dart';

class STextField extends StatefulWidget {
  final String label;
  final bool usePasswordChar;
  final TextEditingController controller;

  const STextField({
    super.key,
    required this.controller,
    required this.label,
    required this.usePasswordChar,
  });

  @override
  State<STextField> createState() => _STextFieldState();
}

class _STextFieldState extends State<STextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF313142),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: TextField(
            controller: widget.controller,
            style: const TextStyle(color: Colors.white),
            obscureText: widget.usePasswordChar ? true : false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
