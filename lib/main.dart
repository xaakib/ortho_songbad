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
          primarySwatch: Colors.blue,
        ),
        home: const OnBoardScren());
  }
}

class OnBoardScren extends StatefulWidget {
  const OnBoardScren({super.key});

  @override
  State<OnBoardScren> createState() => _OnBoardScrenState();
}

class _OnBoardScrenState extends State<OnBoardScren> {
  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: const Text('Do you want to exit?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('NO'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('YES'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 100,
                  left: 10,
                  right: 10,
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/images/icon.png",
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        child: Image.asset(
                          "assets/images/cover.png",
                          height: 100,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(height: 200),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 100,
                  left: 10,
                  right: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage(
                                          url: "https://orthosongbad.com/")));
                            },
                            child: const Text("Bangla",
                                style: TextStyle(fontSize: 18))),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage(
                                          url:
                                              "https://en.orthosongbad.com/")));
                            },
                            child: const Text("English",
                                style: TextStyle(fontSize: 18))),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
