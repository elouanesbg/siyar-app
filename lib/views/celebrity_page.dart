import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyar/models/celebrity.dart';
import 'package:siyar/provide/user_provide.dart';

class CelebrityPage extends StatelessWidget {
  final bool isFavorite;
  final Celebrity celebrity;
  const CelebrityPage(
      {super.key, required this.celebrity, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    bool isFav =
        context.watch<UserProvider>().isfavCelebrity("${celebrity.id}");
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(celebrity.name),
          actions: [
            IconButton(
              onPressed: () {
                log("click: $isFavorite");
                if (isFav) {
                  context
                      .read<UserProvider>()
                      .removefavCelebrity("${celebrity.id}");
                } else {
                  context
                      .read<UserProvider>()
                      .addfavCelebrity("${celebrity.id}");
                }
              },
              icon: Icon(
                Icons.favorite,
                color: isFav ? Colors.red : Colors.white,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 40),
            child: SelectableText(
              celebrity.biography,
              style: TextStyle(
                  fontSize: context.watch<UserProvider>().getFontSize,
                  height: 2),
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      ),
    );
  }
}
