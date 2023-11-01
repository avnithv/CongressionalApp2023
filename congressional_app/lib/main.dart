import "package:congressional_app/dialog.dart";
import "package:congressional_app/mindmap_widget.dart";
import 'package:flutter/material.dart';

import "chat_screen.dart";
import "task_page.dart";
import "dashboard_page.dart";
import "node.dart";
import "dialog.dart";
import 'Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF8ECAE6)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Simulate a loading delay (e.g., 2 seconds)
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the main app's home page (MyHomePage)
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8ECAE6),
      body: Center(
          child: Image.asset('/Users/avnith/Desktop/Congressional App Challenge/app/CongressionalApp2023/congressional_app/images/logo.png'), // Change the asset path as needed
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  static var coins=0;
  static var passwode="1234";
  static var hompate;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedPage = 0;
  var list = [];
  var control = TextEditingController();

  @override
  void initState() {
    MyHomePage.hompate = this;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedPage) {
      case 0:
        page = DashboardWidget();
        break;
      case 1:
        page = TasksWidget();
        break;
      case 2:
        page = MindMapWidget(Node('null'));
        break;
      case 3:
        page = ChatScreen();
        //page = const Placeholder();
        break;
      case 4:
        page = PasswordPage();
        break;
      default:
        throw UnimplementedError("no widget for page $selectedPage");
    }
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: page),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () => {
                        setState(() {
                          selectedPage = 0;
                        })
                      },
                  icon: Icon(Icons.home,
                      color: Theme.of(context).colorScheme.onPrimaryContainer)),
              IconButton(
                  onPressed: () => {
                        setState(() {
                          selectedPage = 1;
                        })
                      },
                  icon: Icon(Icons.task,
                      color: Theme.of(context).colorScheme.onPrimaryContainer)),
              IconButton(
                  onPressed: () => {
                        setState(() {
                          selectedPage = 2;
                        })
                      },
                  icon: Icon(Icons.map_sharp,
                      color: Theme.of(context).colorScheme.onPrimaryContainer)),
              IconButton(
                  onPressed: () => {
                        setState(() {
                          selectedPage = 3;
                        })
                      },
                  icon: Icon(Icons.chat,
                      color: Theme.of(context).colorScheme.onPrimaryContainer)),
              IconButton(
                  onPressed: () => {
                        setState(() {
                          selectedPage = 4;
                        })
                      },
                  icon: Icon(Icons.settings,
                      color: Theme.of(context).colorScheme.onPrimaryContainer)),
            ],
          ),
        ),
      ),
    );
  }
}
