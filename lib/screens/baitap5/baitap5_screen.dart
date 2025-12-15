import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constans/app_colors.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/menu_button.dart';
import 'bmi_widget.dart';
import 'rating_widget.dart';

class Baitap5Screen extends StatefulWidget {
  const Baitap5Screen({super.key});

  @override
  State<Baitap5Screen> createState() => _Baitap5ScreenState();
}

class _Baitap5ScreenState extends State<Baitap5Screen> {
  int _selectedIndex = 0;

  void _onValueChanged(int? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedIndex = newValue;
      });
    }
  }

  Widget _buildSegment(String text, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: _selectedIndex == index ? AppColors.primary : Colors.black54,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(activeIndex: 5), // Active index 5 for Baitap5
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 60,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Sliding Segmented Control
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: CupertinoSlidingSegmentedControl<int>(
                          backgroundColor: Colors.grey[100]!,
                          thumbColor: Colors.white,
                          groupValue: _selectedIndex,
                          children: {
                            0: _buildSegment('Tính BMI', 0),
                            1: _buildSegment('Gửi Phản hồi', 1),
                          },
                          onValueChanged: _onValueChanged,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Content
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: _selectedIndex == 0
                              ? const BmiWidget()
                              : const RatingWidget(),
                        ),
                      ),
                    ],
                  ),
                ),

                // Menu Button at top-left
                MenuButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
