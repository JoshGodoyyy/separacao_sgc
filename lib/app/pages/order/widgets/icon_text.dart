import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function onTap;
  final IconData icon;

  const IconText({
    super.key,
    required this.label,
    required this.controller,
    required this.onTap,
    required this.icon,
  });

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
              label,
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => onTap(),
                  icon: Icon(icon),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
