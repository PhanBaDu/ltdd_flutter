import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ltdd_flutter/constans/app_colors.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MenuButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60, // Adjust for Status Bar
      left: 20,
      child: Material(
        color: const Color.fromRGBO(0, 0, 0, 0),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.5),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/sidebar.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
