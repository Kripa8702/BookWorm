import 'dart:convert';

import 'package:book_worm/models/userModel.dart';
import 'package:book_worm/providers/userProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class FirebaseNotificationMethods {
  final _firebaseMessaging = FirebaseMessaging.instance;
  String NOTIFICATION_TOKEN = dotenv.env['NOTIFICATION_TOKEN'] ?? "";

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(BuildContext context, RemoteMessage? message) {
    if (message == null) return;

    print("REDIRECTING");
    print(message.data);
    print(message.data['route']);
    print(message.data['exchangeId']);
    Navigator.of(context)
        .pushNamed(message.data['route'].toString(), arguments: message);
    // navigatorKey.currentState?.pushNamed(
    //     '/notification',
    //     arguments: message
    // );
  }

  Future<void> initLocalNotification(BuildContext context) async {
    const android = AndroidInitializationSettings('@drawable/ic_notification');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(settings,
        onSelectNotification: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload!));
      handleMessage(context, message);
    });

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications(BuildContext context) async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handleMessage(context, message);
      }
    });

    // Handling a notification click event when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
          'onMessageOpenedApp: ${message.notification!.title.toString()}');
      handleMessage(context, message);
    });

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  _androidChannel.id, _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: '@drawable/ic_notification')),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future<void> initNotification(BuildContext context) async {
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.getToken().then((fcmToken) async {
      print("Token : $fcmToken");
      await saveToken(fcmToken!, context);
    });
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    initPushNotifications(context);
    initLocalNotification(context);
  }

  saveToken(String token, BuildContext context) async {
    final UserModel user =
        Provider.of<UserProvider>(context, listen: false).getUser;
    String uid = user.uid;
    print("UID : $uid");
    await FirebaseFirestore.instance.collection('userTokens').doc(uid).set({
      'token': token,
    });
  }

  sendPushMessage(String body, String title, String exchangeId, String route,
      String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key= $NOTIFICATION_TOKEN',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'route': route,
              'exchangeId': exchangeId,
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

// FirebaseMessaging.instance.getInitialMessage().then(handleMessage(context));
// FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
// FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.notification!.title}');
}
