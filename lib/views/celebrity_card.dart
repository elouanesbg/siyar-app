import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyar/models/celebrity.dart';
import 'package:siyar/provide/user_provide.dart';
import 'package:siyar/views/celebrity_page.dart';

class CelebrityCard extends StatelessWidget {
  final Celebrity celebrity;
  const CelebrityCard({super.key, required this.celebrity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) =>
              CelebrityPage(celebrity: celebrity, isFavorite: false),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          child: Card(
            color: const Color.fromARGB(255, 229, 235, 240),
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: context
                            .watch<UserProvider>()
                            .isfavCelebrity("${celebrity.id}")
                        ? Colors.red
                        : const Color(0xFF343A40),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      bottomLeft: Radius.circular(0.0),
                    ),
                  ),
                  width: 20,
                  height: 73,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ListTile(
                    title: Hero(
                      tag: celebrity.id,
                      child: Text(
                        celebrity.name,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
