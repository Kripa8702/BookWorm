import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.5, 0.8],
          colors: [
            Color(0xFF252628),
            Color(0xFF13547A),
            Color(0xFF80D0C7)
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Container(
              child: Text('Welcome Kripa !',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp
              ),
              )
            ),
          ),
        ),
      ),
    );
  }
}
