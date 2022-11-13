import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:ortho_songbad/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
  FlutterNativeSplash.remove();
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
  final int color1 = 0xff939393;
  final int color2 = 0xff03246b;
}

class _OnBoardScrenState extends State<OnBoardScren> {
  List<String> items = [
    'English',
    'Bangla',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                const Text(
                  "Select your language",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 16),
                MaterialDropdownView(
                  onChangedCallback: (value) {
                    selectLanguage(value);
                    var langcode = "";
                    var baseUrl = "";
                    if (langcode == "English") {
                      baseUrl = "https://en.orthosongbad.com/";
                    } else {
                      baseUrl = "https://orthosongbad.com/";
                    }

                    Get.offAll(MyHomePage(url: baseUrl));
                  },
                  value: items.first,
                  values: items,
                ),
              ],
            ),
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

class MaterialDropdownView extends StatelessWidget {
  final Function onChangedCallback;
  final String value;
  final Iterable<String> values;

  MaterialDropdownView(
      {required this.value,
      required this.values,
      required this.onChangedCallback});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 40,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0), border: Border.all()),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
                value: this.value,
                items:
                    this.values.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  this.onChangedCallback(newValue);
                }),
          ),
        ),
      ),
    );
  }
}
