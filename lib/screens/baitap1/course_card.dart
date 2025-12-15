import 'package:flutter/material.dart';
import 'package:ltdd_flutter/constans/app_colors.dart';

/// Widget hiển thị thông tin một lớp học
class CourseCard extends StatelessWidget {
  final String title;
  final String code;
  final String studentCount;
  final String imageUrl;

  const CourseCard({
    super.key,
    required this.title,
    required this.code,
    required this.studentCount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.textMuted,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.textMuted),
            ),
          ),

          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.text.withOpacity(0.8),
                    AppColors.text.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title và Menu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.more_horiz, color: AppColors.white),
                  ],
                ),
                const SizedBox(height: 4),

                // Course Code
                Text(
                  code,
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),

                const Spacer(),

                // Student Count
                Text(
                  studentCount,
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
