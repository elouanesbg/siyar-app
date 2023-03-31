import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  AboutPage({super.key});
  final Uri _github_url =
      Uri(scheme: 'https', host: 'github.com', path: 'elouanesbg/siyar-app');
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("حول التطبيق"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(14, 8, 14, 40),
            child: Center(
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SelectableText(
                    "تم انشاء هذا التطبيق انطلاقا من عمل ",
                    style: TextStyle(fontSize: 18, height: 2),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                  ),
                  const SelectableText(
                    "Abdelkhalek Beraoud",
                    style: TextStyle(
                        fontSize: 18, height: 2, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: GestureDetector(
                      onTap: () async {
                        _launchInBrowser(_github_url);
                      },
                      child: Image.asset(
                        "assets/img/github.png",
                      ),
                    ),
                  ),
                  const SelectableText(
                    "و الذي قام بجمع أكثر من 5800 من مشاهير الإسلام مع سيرة ذاتية من كتاب سير أعلام النبلاء باللغة العربية وذلك انطلاقا من موقع islamweb",
                    style: TextStyle(
                      fontSize: 18,
                      height: 2,
                    ),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
