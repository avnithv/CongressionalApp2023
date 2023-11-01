import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'main.dart';

class DashboardPage2 extends StatelessWidget {
  const DashboardPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            _searchField()
          ],
        )
    );
  }

Container _searchField() {
    return Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xff1D1617).withOpacity(0.11),
                  blurRadius: 40,
                  spreadRadius: 0.0
                )
              ]
            ),
            child: Row(
              children: [
                Image.asset(
                  '/Users/kanisiva/Documents/VSCode/CongressionalApp/CongressionalApp2023/congressional_app/logo.png',
                  width: 50,
                  height: 50,
                ),
                Container(
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
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Text(
                        'Welcome to Focus Buddy!',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold
                        ),
                    ),
                  ),
                ),
              ],
            ),
          );
          
  }
}

AppBar appBar() {
    return AppBar(
        title: Text(
          'Dashboard',
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

