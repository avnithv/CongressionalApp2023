import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:cupertino_icons/cupertino_icons.dart';

class ListItem {
  String todoText;
  bool todoCheck;
  ListItem(this.todoText, this.todoCheck);

  String getValue() {
    return todoText;
  }
}

class _strikeThrough extends StatelessWidget {
  final String todoText;
  final bool todoCheck;
  _strikeThrough(this.todoText, this.todoCheck) : super();

  Widget _widget() {
    if (todoCheck) {
      return Text(
        todoText,
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          fontStyle: FontStyle.italic,
          fontSize: 22.0,
          color: Colors.red[200],
        ),
      );
    } else {
      return Text(
        todoText,
        style: TextStyle(fontSize: 22.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _widget();
  }
}

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  var textController = TextEditingController();
  var popUpTextController = TextEditingController();
  late TextEditingController controller;
  late TextEditingController coinController;

  List<ListItem> WidgetList = [];

  void readTasks() {
    String pth = "/Users/kanisiva/Documents/VSCode/CongressionalApp/CongressionalApp2023/congressional_app/lib/tasks.txt";
    File file = File(pth);
    List<String> strs = file.readAsLinesSync();
    for (String i in strs) {
      if (i != "") {
        WidgetList.add(ListItem(i, i.contains('false')));
      }
    }
  }

  void writeTasks() {
    String pth = "/Users/kanisiva/Documents/VSCode/CongressionalApp/CongressionalApp2023/congressional_app/lib/tasks.txt";
    File file = File(pth);
    file.writeAsStringSync('');
    for (ListItem i in WidgetList) {
      file.writeAsStringSync(i.getValue() + "\n", mode: FileMode.append);
    }
  }

  @override
  void initState() {
    super.initState();
    readTasks();
    print(WidgetList);
    controller = TextEditingController();
    coinController = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    writeTasks();
    coinController.dispose();
    textController.dispose();
    popUpTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _searchField(),
          const SizedBox(height: 30),
          // Container(
          //   margin: EdgeInsets.all(24),
          //   child: TextField(
          //     decoration: InputDecoration(hintText: "Enter a New Task"),
          //     style: TextStyle(
          //       fontSize: 22.0,
          //     ),
              // controller: textController,
              // cursorWidth: 5.0,
              // autocorrect: true,
              // autofocus: true,
          //   ),
          // ),
          // ElevatedButton(
          //   child: Text("Add Task"),
          //   onPressed: () {
          //     if (textController.text.isNotEmpty) {
          //       WidgetList.add(new ListItem(textController.text, false));
          //       setState(() {
          //         textController.clear();
          //       });
          //     }
          //   },
          // ),
          Expanded(
            child: ReorderableListView(
              children: <Widget>[
                for (final widget in WidgetList)
                  GestureDetector(
                    key: Key(widget.todoText),
                    child: Dismissible(
                      key: Key(widget.todoText),
                      child: CheckboxListTile(
                        value: widget.todoCheck,
                        title:
                            _strikeThrough(widget.todoText, widget.todoCheck),
                        onChanged: (checkValue) async {
                          final res = await openDialog(widget.todoText);
                          if (res != null && res[0] == MyHomePage.passwode) {
                            MyHomePage.coins += int.parse(res[1]);
                            WidgetList.remove(widget);
                            setState(() {});
                          }
                          // setState(() {
                          //   if (checkValue != null && !checkValue) {
                          //     widget.todoCheck = false;
                          //   } else {
                          //     widget.todoCheck = true;
                          //   }
                          // });
                        },
                      ),
                      background: Container(
                        child: Icon(Icons.delete),
                        alignment: Alignment.centerRight,
                        color: Colors.orange[300],
                      ),
                      confirmDismiss: (dismissDirection) {
                        return showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Delete Item?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      direction: DismissDirection.endToStart,
                      movementDuration: const Duration(milliseconds: 200),
                      onDismissed: (dismissDirection) {
                        setState(() {
                          // Remove the Dismissible widget from the WidgetList
                          WidgetList.remove(widget);
                        });
                        Fluttertoast.showToast(msg: "Item Deleted!");
                      },
                    ),
                    onDoubleTap: () {
                      popUpTextController.text = widget.todoText;
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Edit Item"),
                              content: TextFormField(
                                controller: popUpTextController,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    setState(() {
                                      widget.todoText =
                                          popUpTextController.text;
                                    });
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                  )
              ],
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  var replaceWiget = WidgetList.removeAt(oldIndex);
                  WidgetList.insert(newIndex, replaceWiget);
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Future<List<String>?> openDialog(String task) {
    return showDialog<List<String>>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Task Completion: $task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(hintText: "Enter Passcode"),
              controller: controller,
            ),
            const SizedBox(height: 20),
            TextField(
              autofocus: true,
              decoration:
                  InputDecoration(hintText: "Enter Reward (Up to 1000 coins)"),
              controller: coinController,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text("CONFIRM"),
            onPressed: confirm,
          ),
        ],
      ),
    );
  }

  
  AppBar appBar() {
    return AppBar(
        title: Text(
          'Tasks',
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            
          },
            child: Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/Arrow - Left 2.svg',
                height: 20,
                width: 20,
              ),
              decoration: BoxDecoration(
                color: Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
        ),
        actions: [
          Text(
            '${MyHomePage.coins}',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          GestureDetector(
              onTap: () {

              },
              child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                alignment: Alignment.center,
                width: 37,
                child: SvgPicture.asset(
                  'assets/icons/money.svg',
                  height: 30,
                  width: 30,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffF7F8F8),
                  borderRadius: BorderRadius.circular(10)
                ),
            ),
          ),
        ], 
      );
}

Container _searchField() {
    return Container(
            margin: EdgeInsets.only(top: 40, left: 20, right: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xff1D1617).withOpacity(0.11),
                  blurRadius: 40,
                  spreadRadius: 0.0
                )
              ]
            ),
            child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Add A Task!',
                  hintStyle: TextStyle(
                    color: Color(0xffDDDADA),
                    fontSize: 14
                  ),

                  suffixIcon: GestureDetector(
                    onTap: () {
                        if (textController.text.isNotEmpty) {
                        WidgetList.add(new ListItem(textController.text, false));
                        setState(() {
                          textController.clear();
                        });
                      }
                    },
                    child: Container(
                      width: 100,
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            VerticalDivider(
                              color: Colors.black,
                              indent: 10,
                              endIndent: 10,
                              thickness: 0.1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                                child: Icon(
                                  CupertinoIcons.arrow_right_square,
                                  size: 30,
                                ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none
                  )
                ),
                controller: textController,
                cursorWidth: 5.0,
                autocorrect: true,
                autofocus: true,
              )
          );
  }

void confirm() {
    Navigator.of(context).pop([controller.text, coinController.text]);
    controller.clear();
  }
}
