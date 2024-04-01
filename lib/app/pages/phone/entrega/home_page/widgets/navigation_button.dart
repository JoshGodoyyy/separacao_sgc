import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String label;
  final bool isActive;

  const NavigationButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF4951A2)
              : Theme.of(context).scaffoldBackgroundColor,
        ),
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isActive ? Colors.white : null,
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive ? Colors.white : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
