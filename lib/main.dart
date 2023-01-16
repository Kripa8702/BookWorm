import 'package:flutter/material.dart';
import 'package:kimber/screens/homeScreen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Changa',
            primaryColor: Color(0xFF252628),
            accentColor: Color(0xFFccf869),
          ),
          home: const HomeScreen(),
        );
      }
    );
  }
}
