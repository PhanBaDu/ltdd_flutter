import 'package:flutter/material.dart';

class Baitap2Screen extends StatelessWidget {
  const Baitap2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập 2'),
      ),
      body: const Center(
        child: Text(
          'Nội dung Bài tập 2',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
