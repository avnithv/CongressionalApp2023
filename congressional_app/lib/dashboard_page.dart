import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Center(child: Text("Welcome Back!", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 45,),)),
        ],
      ),
    );
  }
}