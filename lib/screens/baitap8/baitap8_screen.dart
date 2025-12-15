import 'package:flutter/material.dart';

class Baitap8Screen extends StatelessWidget {
  const Baitap8Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập 8'),
      ),
      body: const Center(
        child: Text(
          'Nội dung Bài tập 8',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
