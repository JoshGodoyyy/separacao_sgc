import 'package:flutter/material.dart';

class Campo extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool readOnly;
  final TextInputType? type;

  const Campo({
    super.key,
    required this.label,
    required this.controller,
    required this.readOnly,
    required this.type,
  });

  @override
  State<Campo> createState() => _CampoState();
}

class _CampoState extends State<Campo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Material(
            elevation: 5,
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: TextField(
              controller: widget.controller,
              readOnly: widget.readOnly,
              keyboardType: widget.type,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
