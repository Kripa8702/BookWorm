import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kimber/navigationBar.dart';
import 'package:kimber/screens/navigation/homeScreen.dart';
import 'package:kimber/screens/splashScreen.dart';
import 'package:kimber/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';

Future main() async{
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
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
          routes: {
            '/home': (context) => NavigationBarScreen(),
          },
          home: SplashScreen(),
        );
      }
    );
  }
}
