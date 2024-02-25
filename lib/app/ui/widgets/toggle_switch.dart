import 'package:flutter/material.dart';

class ToggleSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final Function onChanged;

  const ToggleSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Switch(
            value: value,
            onChanged: (value) {
              onChanged();
            },
          ),
        ],
      ),
    );
  }
}
