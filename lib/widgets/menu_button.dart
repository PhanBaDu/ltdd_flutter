import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MenuButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60, // Adjust for Status Bar
      left: 20,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Iconsax.menu_1, // Using menu icon as sidebar representation
              color: Colors.black87,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
