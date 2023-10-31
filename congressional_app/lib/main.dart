import "package:congressional_app/mindmap_widget.dart";
import 'package:flutter/material.dart';

import "chat_screen.dart";
import "task_page.dart";
import "dashboard_page.dart";
import "node.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedPage = 0;
  var coins = 693;
  var list = [];
  var control = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedPage) {
      case 0:
        page = const DashboardPage();
        break;
      case 1:
        page = const TasksWidget();
        break;
      case 2:
        page = MindMapWidget(Node('null'));
        break;
      case 3:
        page = ChatScreen();
        //page = const Placeholder();
        break;
      case 4:
        page = const Placeholder();
        break;
      default:
        throw UnimplementedError("no widget for page $selectedPage");
    }
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
            leading: const Icon(Icons.child_care),
            title: Center(
                child: Text(
              "FocusBuddy",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            )),
            actions: [
              Text(
                "$coins",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 20,
                ),
              ),
              const Icon(Icons.currency_bitcoin),
            ],
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
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
