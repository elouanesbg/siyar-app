import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyar/models/celebrity.dart';
import 'package:siyar/provide/user_provide.dart';
import 'package:siyar/services/data_service.dart';
import 'package:siyar/views/celebrity_card.dart';

class CelebrityFavoritePage extends StatefulWidget {
  const CelebrityFavoritePage({super.key});

  @override
  State<CelebrityFavoritePage> createState() => _CelebrityFavoritePageState();
}

class _CelebrityFavoritePageState extends State<CelebrityFavoritePage> {
  late bool isLoadingData = true;
  List<Celebrity> celebrityItems = [];
  getData() async {
    final List<Celebrity> data = await DataService().readJson();
    setState(() {
      celebrityItems = data
          .where((e) => context.read<UserProvider>().isfavCelebrity("${e.id}"))
          .toList();
      isLoadingData = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("المفضلة"),
        ),
        body: Center(
            child: isLoadingData
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: celebrityItems.length,
                    itemBuilder: (context, index) => CelebrityCard(
                          celebrity: celebrityItems[index],
                        ))),
      ),
    );
  }
}
