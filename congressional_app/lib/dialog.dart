import 'package:flutter/material.dart';


class PasswordPage extends StatefulWidget {
  PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPage();
}

class _PasswordPage extends State<PasswordPage> {
  late TextEditingController controller;
  String name = '';

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text("Name: "),
                ),
                const SizedBox(width: 12,),
                Text(name),
              ],
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              child: Text("Open Dialog"),
              onPressed: () async {
                final name = await openDialog();
                if (name == null || name.isEmpty) return;
                setState(() => this.name = name);
              }
            )
          ],
        )
      )
    );
  }

  Future<String?> openDialog() {
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Task Completion Reward"),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(hintText: "Enter Passcode"),
          controller: controller,
          onSubmitted: (_) => confirm(),
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
  void confirm() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
  }
}