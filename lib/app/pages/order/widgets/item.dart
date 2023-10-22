import 'package:flutter/material.dart';

import '../../../ui/styles/colors_app.dart';

Padding item(String label, TextEditingController controller,
    [bool readOnly = false]) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: const BoxDecoration(
            color: ColorsApp.elementColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(2, 2),
              )
            ],
          ),
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            style: TextStyle(
              color: readOnly ? Colors.black45 : Colors.black,
            ),
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
