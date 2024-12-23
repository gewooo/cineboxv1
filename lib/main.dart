import 'package:cinebox/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CineBox());
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
          color: Colors.red,
      iconTheme: IconThemeData(
        color: Colors.white
      ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
