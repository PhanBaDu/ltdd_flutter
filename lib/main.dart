import 'package:flutter/material.dart';
import 'package:ltdd_flutter/widgets/app_drawer.dart';
import 'package:ltdd_flutter/widgets/menu_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
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
