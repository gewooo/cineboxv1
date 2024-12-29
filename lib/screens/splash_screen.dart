import 'package:cinebox/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 33, 19),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/POPCORN.png',
            ),
            Text(
              'CineBox',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
