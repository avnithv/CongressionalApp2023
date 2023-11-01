import 'package:flutter/material.dart';
import 'main.dart';


class PasswordPage extends StatefulWidget {
  PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPage();
}

class _PasswordPage extends State<PasswordPage> {
  late TextEditingController controller;
  late TextEditingController controller2;
  late TextEditingController controller3;
  late TextEditingController controller4;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();
  }

  @override void dispose() {
    controller.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Text("Settings", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 45,),),
            const SizedBox(height: 16,),
            Text("Change the password that is used to confirm task completion:", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 20,),),
            const SizedBox(height: 20,),
            ElevatedButton(
              child: Text("Change Password"),
              onPressed: () async {
                final res = await openDialog();
                if (res != null && res[0] == MyHomePage.passwode) {
                  if (!res[1].isEmpty) MyHomePage.passwode = res[1];
                }
              }
            ),
            const SizedBox(height: 20,),
            Text("Directly modify the number of coins:", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 20,)),
            const SizedBox(height: 30,),
            ElevatedButton(
              child: Text("Set Number of Coins"),
              onPressed: () async {
                final res = await openDialog2();
                if (res != null && res[0] == MyHomePage.passwode) {
                  MyHomePage.coins = int.parse(res[1]);
                  MyHomePage.hompate!.setState(() {});
                }
              }
            )
          ],
        )
      )
    );
  }

  Future<List<String>?> openDialog() {
    return showDialog<List<String>>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Change your Password"),
        content:
          Column( 
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(hintText: "Enter Current Passcode"),
                controller: controller,
              ),
              const SizedBox(height: 20),
              TextField(
                autofocus: true,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(hintText: "Enter New Passcode"),
                controller: controller2,
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


  Future<List<String>?> openDialog2() {
    return showDialog<List<String>>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Modify the Number of Coins"),
        content:
          Column( 
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(hintText: "Enter Passcode"),
                controller: controller4,
              ),
              TextField(
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(hintText: "New Number of Coins"),
                controller: controller3,
              ),
            ],
          ),
        actions: [
          TextButton(
            child: Text("CONFIRM"),
            onPressed: confirm2,
          ),
        ],
      ),
    );
  }

  void confirm() {
    Navigator.of(context).pop([controller.text, controller2.text]);
    controller.clear();
  }

  void confirm2() {
    Navigator.of(context).pop([controller4.text, controller3.text]);
    controller.clear();
  }
}