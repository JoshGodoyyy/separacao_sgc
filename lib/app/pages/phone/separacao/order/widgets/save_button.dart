import 'package:flutter/material.dart';
import '../../../../../ui/styles/colors_app.dart';

Padding saveButton(String label, IconData icone, Function onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Material(
      color: ColorsApp.primaryColor,
      elevation: 5,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icone,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
