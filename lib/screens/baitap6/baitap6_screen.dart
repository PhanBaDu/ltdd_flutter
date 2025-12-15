import 'package:flutter/material.dart';

class Baitap6Screen extends StatelessWidget {
  const Baitap6Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập 6'),
      ),
      body: const Center(
        child: Text(
          'Nội dung Bài tập 6',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
