import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ltdd_flutter/constans/app_colors.dart';
import 'package:ltdd_flutter/screens/baitap1/baitap1_screen.dart';
import 'package:ltdd_flutter/screens/baitap2/baitap2_screen.dart';
import 'package:ltdd_flutter/screens/baitap3/baitap3_screen.dart';
import 'package:ltdd_flutter/screens/baitap4/baitap4_screen.dart';
import 'package:ltdd_flutter/screens/baitap5/baitap5_screen.dart';
import 'package:ltdd_flutter/screens/baitap6/baitap6_screen.dart';
import 'package:ltdd_flutter/screens/baitap7/baitap7_screen.dart';
import 'package:ltdd_flutter/screens/baitap8/baitap8_screen.dart';
import 'package:ltdd_flutter/screens/home/home_screen.dart';

class AppDrawer extends StatelessWidget {
  final int activeIndex;

  const AppDrawer({super.key, this.activeIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              bottom: 20,
              left: 5,
              right: 20,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.textMuted.withOpacity(0.3),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/flutter.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, Phan Bá Đủ",
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Hello World!",
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 5),
              children: [
                _buildDrawerItem(
                  icon: Iconsax.home,
                  title: "Trang chủ",
                  onTap: () {
                    if (activeIndex != 0) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    } else {
                      Navigator.pop(context); // Close drawer if already on Home
                    }
                  },
                  isActive: activeIndex == 0,
                ),
                ...List.generate(8, (index) {
                  return _buildDrawerItem(
                    icon: index == 0 ? Iconsax.teacher : Iconsax.task_square,
                    title: index == 0
                        ? "Classroom"
                        : (index == 1 ? "Wellcome" : "Bài tập ${index + 1}"),
                    isActive: activeIndex == index + 1,
                    onTap: () {
                      if (activeIndex != index + 1) {
                        Navigator.pop(context); // Close drawer
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              switch (index) {
                                case 0:
                                  return const Baitap1Screen();
                                case 1:
                                  return const Baitap2Screen();
                                case 2:
                                  return const Baitap3Screen();
                                case 3:
                                  return const Baitap4Screen();
                                case 4:
                                  return const Baitap5Screen();
                                case 5:
                                  return const Baitap6Screen();
                                case 6:
                                  return const Baitap7Screen();
                                case 7:
                                  return const Baitap8Screen();
                                default:
                                  return const Scaffold(
                                    body: Center(child: Text("Error")),
                                  );
                              }
                            },
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isActive = false,
    bool isLogout = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        color: isActive
            ? AppColors.primary.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isLogout
                      ? AppColors.destructive
                      : (isActive ? AppColors.primary : AppColors.textMuted),
                  size: 24,
                ),
                const SizedBox(width: 20),
                Text(
                  title,
                  style: TextStyle(
                    color: isLogout
                        ? AppColors.destructive
                        : (isActive ? AppColors.primary : AppColors.text),
                    fontSize: 16,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
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
