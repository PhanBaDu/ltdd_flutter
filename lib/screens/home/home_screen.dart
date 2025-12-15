import 'package:flutter/material.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/menu_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(activeIndex: 0), // Home is active
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
                    'Hello World',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),

              // Menu Button positioned via Stack (internally uses Positioned)
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
