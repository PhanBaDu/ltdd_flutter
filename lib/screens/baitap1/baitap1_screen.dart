import 'package:flutter/material.dart';

class Baitap1Screen extends StatelessWidget {
  const Baitap1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập 1'),
      ),
      body: const Center(
        child: Text(
          'Nội dung Bài tập 1',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
