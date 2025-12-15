import 'package:flutter/material.dart';

class Baitap7Screen extends StatelessWidget {
  const Baitap7Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập 7'),
      ),
      body: const Center(
        child: Text(
          'Nội dung Bài tập 7',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
