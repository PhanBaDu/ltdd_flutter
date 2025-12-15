import 'package:flutter/material.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/menu_button.dart';

class Baitap3Screen extends StatelessWidget {
  const Baitap3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(activeIndex: 3),
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
                    'Nội dung Bài tập 3',
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
