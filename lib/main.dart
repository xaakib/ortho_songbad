import 'package:flutter/material.dart';
import 'package:ortho_songbad/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ortho Songbad',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const MyHomePage(url: "https://orthosongbad.com/"));
  }
}
