import 'package:flutter/material.dart';
import 'package:siyar/models/celebrity.dart';

class CelebrityPage extends StatelessWidget {
  final Celebrity celebrity;
  const CelebrityPage({super.key, required this.celebrity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(celebrity.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(celebrity.biography),
      ),
    );
  }
}
