import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("حول التطبيق"),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(14, 8, 14, 40),
            child: SelectableText(
              "",
              style: TextStyle(fontSize: 18, height: 2),
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      ),
    );
  }
}
