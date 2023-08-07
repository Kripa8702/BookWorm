import 'package:book_worm/firebaseResources/firebasePushNotificationMethods.dart';
import 'package:book_worm/providers/userProvider.dart';
import 'package:book_worm/screens/navigation/allChatsScreen.dart';
import 'package:book_worm/screens/notificationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:book_worm/navigationBar.dart';
import 'package:book_worm/screens/splashScreen.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:firebase_core/firebase_cor'
    'e.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Lato',
            primaryColor: white,
            scaffoldBackgroundColor: scaffoldBackground,
            // accentColor: Color(0xFFccf869),
          ),
          routes: {
            '/home': (context) => NavigationBarScreen(),
            NotificationScreen.route: (context) => const NotificationScreen(),
            '/chats': (context) => NavigationBarScreen(
                  index: 2,
                )
          },
          home: SplashScreen(),
        ),
      );
    });
  }
}
