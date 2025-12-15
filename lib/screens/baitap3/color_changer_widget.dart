import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ltdd_flutter/constans/app_colors.dart';

class ColorChangerWidget extends StatelessWidget {
  final Color color;
  final String name;
  final Function(Color, String) onChanged;

  const ColorChangerWidget({
    super.key,
    required this.color,
    required this.name,
    required this.onChanged,
  });

  void _openColorPicker(BuildContext context) {
    Color tempColor = color;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Chọn màu tùy thích',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: color,
              onColorChanged: (val) => tempColor = val,
              labelTypes: const [],
              pickerAreaHeightPercent: 0.7,
              enableAlpha: false,
              displayThumbColor: true,
              paletteType: PaletteType.hsvWithHue,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                String colorName =
                    '#${tempColor.value.toRadixString(16).substring(2).toUpperCase()}';
                onChanged(tempColor, colorName);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text('Áp dụng'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Xác định màu text dựa trên độ sáng của background
    bool isDark = color.computeLuminance() < 0.5;
    Color textColor = isDark ? Colors.white : Colors.black87;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Background decoration removed

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                    letterSpacing: 2,
                    fontFamily: '.SF Pro Display',
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),

          // Floating Action Button to pick color
          Positioned(
            bottom: 40,
            left: 30,
            child: GestureDetector(
              onTap: () => _openColorPicker(context),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  child: Icon(Iconsax.edit, color: color, size: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
