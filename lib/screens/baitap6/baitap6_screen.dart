import 'package:flutter/material.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/menu_button.dart';

class Baitap6Screen extends StatelessWidget {
  const Baitap6Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(activeIndex: 6),
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              // Main Content
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Nội dung Bài tập 6',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              
              // Menu Button
              MenuButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
