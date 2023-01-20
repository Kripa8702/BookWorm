import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kimber/navigationBar.dart';
import 'package:kimber/screens/homeScreen.dart';
import 'package:kimber/screens/splashScreen.dart';
import 'package:kimber/utils/colors.dart';
import 'package:sizer/sizer.dart';

Future main() async{
  await dotenv.load(fileName: ".env");
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
            primaryColor: white,
            scaffoldBackgroundColor: scaffoldBackground,
            // accentColor: Color(0xFFccf869),
          ),
          home: SplashScreen(),
        );
      }
    );
  }
}
