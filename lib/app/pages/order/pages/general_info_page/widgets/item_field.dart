import 'package:flutter/material.dart';

class ItemField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  const ItemField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  State<ItemField> createState() => _ItemFieldState();
}

class _ItemFieldState extends State<ItemField> {
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
              readOnly: true,
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
