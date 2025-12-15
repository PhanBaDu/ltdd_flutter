import 'package:flutter/material.dart';

class Baitap3Screen extends StatelessWidget {
  const Baitap3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập 3'),
      ),
      body: const Center(
        child: Text(
          'Nội dung Bài tập 3',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
