import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyar/provide/user_provide.dart';
import 'package:siyar/views/home.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'siyar',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF343A40),
          ),
          primaryColor: const Color(0xFF343A40),
          fontFamily: "Almarai",
          textTheme: const TextTheme()),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomePage(),
      ),
    );
  }
}
