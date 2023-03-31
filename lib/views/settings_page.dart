import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyar/provide/user_provide.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int fontSize = 18;
  String searchIn = "name";
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("الاعدادات"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
            child: ListView(
              children: [
                ListTile(
                  title: const Text(
                    "حجم الخط",
                  ),
                  leading: const Icon(
                    Icons.font_download_rounded,
                  ),
                  subtitle: DropdownButtonHideUnderline(
                    child: DropdownButton<double>(
                      isExpanded: true,
                      elevation: 4,
                      value: context.watch<UserProvider>().getFontSize,
                      items: <double>[12, 16, 18, 22].map((double value) {
                        return DropdownMenuItem<double>(
                          value: value,
                          child: Text("$value"),
                        );
                      }).toList(),
                      onChanged: (value) {
                        context.read<UserProvider>().setFontSize(value!);
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    " البحث في ",
                  ),
                  leading: const Icon(
                    Icons.color_lens,
                  ),
                  subtitle: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      elevation: 4,
                      value: context.watch<UserProvider>().getsearchIn,
                      items: <String>["name", "biography"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        context.read<UserProvider>().setsearchIn(value!);
                      },
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
