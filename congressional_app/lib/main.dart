import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch(selectedPage) {
      case 0:
        page = const Placeholder();
        break;
      case 1:
        page = const Placeholder();
        break;
      case 2:
        page = const Placeholder();
        break;
      case 3:
        page = const Placeholder();
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
              )
            ),
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
                onPressed: () => {setState(() {selectedPage = 0;})},
                icon: Icon(Icons.home, color: Theme.of(context).colorScheme.onPrimaryContainer)
              ),
              IconButton(
                onPressed: () => {setState(() {selectedPage = 1;})},
                icon: Icon(Icons.task, color: Theme.of(context).colorScheme.onPrimaryContainer)
              ),
              IconButton(
                onPressed: () => {setState(() {selectedPage = 2;})},
                icon: Icon(Icons.map_sharp, color: Theme.of(context).colorScheme.onPrimaryContainer)
              ),
              IconButton(
                onPressed: () => {setState(() {selectedPage = 3;})},
                icon: Icon(Icons.chat, color: Theme.of(context).colorScheme.onPrimaryContainer)
              ),
              IconButton(
                onPressed: () => {setState(() {selectedPage = 4;})},
                icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onPrimaryContainer)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
