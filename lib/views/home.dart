import 'package:flutter/material.dart';
import 'package:siyar/models/celebrity.dart';
import 'package:siyar/services/data_service.dart';
import 'package:siyar/views/celebrity_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      body: Center(
          child: FutureBuilder<List<Celebrity>>(
              future: DataService().readJson(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                  if (snapshot.hasData) {
                    return buildCard(snapshot.data![index]);
                  }
                  return const Center(child: CircularProgressIndicator());
                });
              })),
    );
  }

  Widget buildCard(Celebrity celebrity) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CelebrityPage(celebrity: celebrity),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          child: Card(
            color: Colors.blue.shade100,
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      bottomLeft: Radius.circular(4.0),
                    ),
                  ),
                  width: 20,
                  height: 73,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ListTile(
                    title: Hero(tag: celebrity.id, child: Text(celebrity.name)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Stack(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              height: height + 75,
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Center(
                  child: Text(
                    "سير أعلام النبلاء",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(),
            Positioned(
              top: 100.0,
              left: 20.0,
              right: 20.0,
              child: AppBar(
                backgroundColor: Colors.white,
                leading: Icon(
                  Icons.menu,
                  color: Theme.of(context).primaryColor,
                ),
                primary: false,
                title: const TextField(
                    decoration: InputDecoration(
                        hintText: "بحث",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey))),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
      );
}
