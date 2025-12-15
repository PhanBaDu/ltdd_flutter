import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    bool isDark = color.computeLuminance() < 0.5;

    final List<Map<String, dynamic>> colorOptions = [
      {'label': 'Hồng', 'name': 'HỒNG', 'color': Colors.pinkAccent},
      {'label': 'Tím', 'name': 'TÍM', 'color': Colors.deepPurpleAccent},
      {'label': 'Vàng', 'name': 'VÀNG', 'color': Colors.yellow},
      {'label': 'Xanh lá', 'name': 'XANH LÁ', 'color': Colors.green},
      {'label': 'Xanh dương', 'name': 'XANH DƯƠNG', 'color': Colors.blue},
      {'label': 'Cam', 'name': 'CAM', 'color': Colors.orangeAccent},
      {'label': 'Đen', 'name': 'ĐEN', 'color': const Color(0xFF2D3436)},
      {'label': 'Xanh ngọc', 'name': 'XANH NGỌC', 'color': Colors.teal},
    ];

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Background pattern or decoration
          Positioned(
            top: 40,
            right: -20,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: isDark ? Colors.white : Colors.black87,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Màu sắc hiện tại",
                  style: TextStyle(
                    fontSize: 16,
                    color: (isDark ? Colors.white : Colors.black87).withOpacity(
                      0.6,
                    ),
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 60), // Space for control panel
              ],
            ),
          ),

          // Control Panel at Bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Đổi màu hình nền",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: colorOptions.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final option = colorOptions[index];
                        final optionColor = option['color'] as Color;
                        final optionName = option['name'] as String;
                        final isSelected = name == optionName;

                        return GestureDetector(
                          onTap: () => onChanged(optionColor, optionName),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isSelected ? 60 : 50,
                            height: isSelected ? 60 : 50,
                            decoration: BoxDecoration(
                              color: optionColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.transparent,
                                width: isSelected ? 3 : 0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: optionColor.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
