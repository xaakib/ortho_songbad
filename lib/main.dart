import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ortho_songbad/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String baseUrl = "";
  String checkLangCode = "";
  bool isLoading = false;

  getLanguage() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var langcode = prefs.get('lang');
    print("langcode========$langcode");

    if (langcode == "English") {
      baseUrl = "https://en.orthosongbad.com/";
    } else {
      baseUrl = "https://orthosongbad.com/";
    }
    checkLangCode = langcode.toString();
    print("CheckCode ======$checkLangCode");
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    print("CheckCode ======$checkLangCode");
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ortho Songbad',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isLoading == true
            ? const Scaffold(
                body: Center(
                child: CircularProgressIndicator(),
              ))
            : checkLangCode == "null"
                ? OnBoardScren()
                : MyHomePage(url: baseUrl));
  }
}

class OnBoardScren extends StatefulWidget {
  @override
  State<OnBoardScren> createState() => _OnBoardScrenState();
}

class _OnBoardScrenState extends State<OnBoardScren> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                            Get.offAll(const MyHomePage(
                                url: "https://orthosongbad.com/"));
                            selectLanguage("Bangla");
                          },
                          child: const Text("Bangla",
                              style: TextStyle(fontSize: 18))),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.offAll(const MyHomePage(
                                url: "https://en.orthosongbad.com/"));
                            selectLanguage("English");
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
    );
  }

  selectLanguage(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', "$value");
  }
}
