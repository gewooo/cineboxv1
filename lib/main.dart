import 'package:cinebox/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CineBox());
}

class CineBox extends StatelessWidget {
  const CineBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Color.fromARGB(255, 233, 33, 19),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
