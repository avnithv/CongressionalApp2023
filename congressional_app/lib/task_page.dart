import 'package:flutter/material.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  var list = [];
  var control = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var w = <Widget>[const Text('Here is your to do list:')];
    for (int i = 0; i < list.length; i++) {
      w.add(Text(
        list[i],
        style: Theme.of(context).textTheme.headlineMedium,
      ));
    }
    w.add(TextField(
      decoration: const InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Enter a new task',
    ),
    controller: control,
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Add Tasks"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: w),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
  void _incrementCounter() {
    setState(() {
      list.add(control.text);
    });
  }
}