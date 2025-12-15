import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ltdd_flutter/constans/app_colors.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/menu_button.dart';
import 'timer_widget.dart';
import 'counter_widget.dart';
import 'color_changer_widget.dart';

class Baitap3Screen extends StatefulWidget {
  const Baitap3Screen({super.key});

  @override
  State<Baitap3Screen> createState() => _Baitap3ScreenState();
}

class _Baitap3ScreenState extends State<Baitap3Screen> {
  int _selectedIndex = 0;
  Color _selectedColor = Colors.pinkAccent;
  String _selectedColorName = 'HỒNG';

  void _onColorChanged(Color color, String name) {
    setState(() {
      _selectedColor = color;
      _selectedColorName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(activeIndex: 3),
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              color: _selectedIndex == 2 ? _selectedColor : Colors.white,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 60,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Cupertino Sliding Segmented Control
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          child: CupertinoSlidingSegmentedControl<int>(
                            backgroundColor: _selectedIndex == 2
                                ? Colors.white.withOpacity(0.2)
                                : CupertinoColors.systemGrey5,
                            thumbColor: _selectedIndex == 2
                                ? Colors.white
                                : CupertinoColors.white,
                            groupValue: _selectedIndex,
                            children: {
                              0: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(
                                  'Timer',
                                  style: TextStyle(
                                    color: _selectedIndex == 0
                                        ? AppColors.primary
                                        : AppColors.text,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              1: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(
                                  'Counter',
                                  style: TextStyle(
                                    color: _selectedIndex == 1
                                        ? AppColors.primary
                                        : AppColors.text,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              2: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 6,
                                ),
                                child: Text(
                                  'Colors',
                                  style: TextStyle(
                                    color: _selectedIndex == 2
                                        ? _selectedColor
                                        : AppColors.text,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            },
                            onValueChanged: (int? value) {
                              if (value != null) {
                                setState(() {
                                  _selectedIndex = value;
                                });
                              }
                            },
                          ),
                        ),

                        const SizedBox(height: 20),
                        Expanded(
                          child: _selectedIndex == 0
                              ? const TimerWidget()
                              : _selectedIndex == 1
                              ? const CounterWidget()
                              : ColorChangerWidget(
                                  color: _selectedColor,
                                  name: _selectedColorName,
                                  onChanged: _onColorChanged,
                                ),
                        ),
                      ],
                    ),
                  ),
                  MenuButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
