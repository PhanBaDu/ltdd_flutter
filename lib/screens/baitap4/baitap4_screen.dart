import 'package:flutter/material.dart';

class Baitap4Screen extends StatelessWidget {
  const Baitap4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập 4'),
      ),
      body: const Center(
        child: Text(
          'Nội dung Bài tập 4',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
