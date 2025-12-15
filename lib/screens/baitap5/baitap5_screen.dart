import 'package:flutter/material.dart';

class Baitap5Screen extends StatelessWidget {
  const Baitap5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập 5'),
      ),
      body: const Center(
        child: Text(
          'Nội dung Bài tập 5',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
