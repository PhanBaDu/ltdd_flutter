import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ltdd_flutter/screens/baitap1/baitap1_screen.dart';
import 'package:ltdd_flutter/screens/baitap2/baitap2_screen.dart';
import 'package:ltdd_flutter/screens/baitap3/baitap3_screen.dart';
import 'package:ltdd_flutter/screens/baitap4/baitap4_screen.dart';
import 'package:ltdd_flutter/screens/baitap5/baitap5_screen.dart';
import 'package:ltdd_flutter/screens/baitap6/baitap6_screen.dart';
import 'package:ltdd_flutter/screens/baitap7/baitap7_screen.dart';
import 'package:ltdd_flutter/screens/baitap8/baitap8_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: const Icon(
                    Iconsax.user,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 15),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, User",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Welcome back",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 20),
              children: [
                _buildDrawerItem(
                  icon: Iconsax.home,
                  title: "Home",
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                  },
                  isActive: true,
                ),
                ...List.generate(8, (index) {
                  return _buildDrawerItem(
                    icon: Iconsax.task_square,
                    title: "Bài tập ${index + 1}",
                    onTap: () {
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
        color: isActive ? Colors.blue.withOpacity(0.1) : Colors.transparent,
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
                      ? Colors.red
                      : (isActive ? Colors.blue : Colors.grey),
                  size: 24,
                ),
                const SizedBox(width: 20),
                Text(
                  title,
                  style: TextStyle(
                    color: isLogout
                        ? Colors.red
                        : (isActive ? Colors.blue : Colors.black87),
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
