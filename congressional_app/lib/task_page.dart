import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListItem {
  String todoText;
  bool todoCheck;
  ListItem(this.todoText, this.todoCheck);
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

  List<ListItem> WidgetList = [];

  @override
  void dispose() {
    textController.dispose();
    popUpTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: TextField(
              decoration: InputDecoration(hintText: "Enter a new Task"),
              style: TextStyle(
                fontSize: 22.0,
              ),
              controller: textController,
              cursorWidth: 5.0,
              autocorrect: true,
              autofocus: true,
            ),
          ),
          ElevatedButton(
            child: Text("Add Item"),
            onPressed: () {
              if (textController.text.isNotEmpty) {
                WidgetList.add(new ListItem(textController.text, false));
                setState(() {
                  textController.clear();
                });
              }
            },
          ),
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
                        onChanged: (checkValue) {
                          setState(() {
                            if (checkValue != null && !checkValue) {
                              widget.todoCheck = false;
                            } else {
                              widget.todoCheck = true;
                            }
                          });
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
                        WidgetList.remove(widget);
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
}
