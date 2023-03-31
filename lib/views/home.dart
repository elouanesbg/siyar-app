import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyar/models/celebrity.dart';
import 'package:siyar/provide/user_provide.dart';
import 'package:siyar/services/data_service.dart';
import 'package:siyar/views/about_page.dart';
import 'package:siyar/views/celebrity_card.dart';
import 'package:siyar/views/celebrity_favorite_page.dart';
import 'package:siyar/views/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final Uri githubUrl =
      Uri(scheme: 'https', host: 'github.com', path: 'elouanesbg/siyar-app');
  final Uri appUrl =
      Uri(scheme: 'https', host: 'github.com', path: 'elouanesbg/siyar-app');
  late bool isLoadingData = true;
  List<Celebrity> celebrityItems = [];
  List<Celebrity> celebrityItemsSearch = [];

  search(String val) {
    if (val.trim().isEmpty) {
      setState(() {
        celebrityItemsSearch = celebrityItems;
      });
      return;
    }
    setState(() {
      isLoadingData = true;
    });

    var searchIn = context.read<UserProvider>().getsearchIn;
    late List<Celebrity> serachData;
    if (searchIn == "name") {
      serachData = celebrityItems
          .where((element) => element.name.startsWith(val))
          .toList();
    } else {
      serachData = celebrityItems
          .where((element) => element.biography.contains(val))
          .toList();
    }

    setState(() {
      celebrityItemsSearch = serachData;
      isLoadingData = false;
    });
  }

  getData() async {
    final List<Celebrity> data = await DataService().readJson();
    setState(() {
      celebrityItems = data;
      celebrityItemsSearch = data;
      isLoadingData = false;
    });
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(AppBar().preferredSize.height),
      drawer: _appDrawer(),
      body: Center(
          child: isLoadingData
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: celebrityItemsSearch.length,
                  itemBuilder: (context, index) => CelebrityCard(
                        celebrity: celebrityItemsSearch[index],
                      ))),
    );
  }

  _appDrawer() => Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xFF343A40),
                    ),
                    child: Text(
                      'سير أعلام النبلاء',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('الاعدادات'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SettingPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('المفضلة'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CelebrityFavoritePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('حول التطبيق'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AboutPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.rate_review),
                    title: const Text('قيم التطبيق'),
                    onTap: () {
                      _launchInBrowser(appUrl);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
              child: GestureDetector(
                onTap: () async {
                  _launchInBrowser(githubUrl);
                },
                child: Image.asset(
                  "assets/img/github.png",
                ),
              ),
            )
          ],
        ),
      );

  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Stack(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              height: height + 85,
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
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
              top: 110.0,
              left: 20.0,
              right: 20.0,
              child: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
                primary: false,
                title: TextField(
                  controller: _controller,
                  onChanged: (value) {
                    search(value);
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _controller.text = "";
                        });
                        search("");
                      },
                      icon: Icon(
                        Icons.clear,
                        color: _controller.text.isNotEmpty
                            ? Colors.grey
                            : Colors.white,
                      ),
                    ),
                    hintText: "بحث",
                    border: InputBorder.none,
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 4, 0),
                    child: Icon(Icons.search,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
