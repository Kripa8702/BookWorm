import 'package:book_worm/firebaseResources/firebasePushNotificationMethods.dart';
import 'package:book_worm/functions/chatFunctions.dart';
import 'package:book_worm/models/exchangeModel.dart';
import 'package:book_worm/models/userModel.dart';
import 'package:book_worm/navigationBar.dart';
import 'package:book_worm/providers/userProvider.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:book_worm/utils/utils.dart';
import 'package:book_worm/widgets/gradientText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatefulWidget {
  static const route = '/notification';

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late ExchangeModel exchangeModel;

  getExchangeDetails(String exchangeId) async{
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('exchanges')
        .doc(exchangeId)
        .get();

    print(snap);

    exchangeModel = ExchangeModel.fromSnap(snap);
    return;
  }

  acceptRequest() async{
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('userTokens')
        .doc(exchangeModel.book2.uid)
        .get();

    print(snap);

    String token = snap['token'] ?? "";
    print(token);

    String title = "Request Accepted!";
    String body =
        "Your book exchange request has been accepted by ${exchangeModel.book1.username}";

    //Send notification
    await FirebaseNotificationMethods()
        .sendPushMessage(body, title, exchangeModel.exchangeId, '/chats', token);

    //Send message

    await ChatFunctions().sendMessage(
        exchangeModel.book2.uid, exchangeModel.book2.username, exchangeModel.book1.uid, body);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NavigationBarScreen(),
      ),
    );

    showSnackBar('Message sent to ${exchangeModel.book2.username}', context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    getExchangeDetails(message.data['exchangeId']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: GradientText('Exchange Details',
            gradient: gradient,
            style: TextStyle(color: white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: getExchangeDetails(message.data['exchangeId']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: blueAccent,
                  ),
                );
              }
              return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 45.h,
                      color: greenAccent.withOpacity(0.2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 10.h),
                          child: Image.network(
                            exchangeModel.book1.postUrl,
                            height: 25.h,
                            width: 35.w,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.h),
                          width: 15.w,
                          child: Image.asset(
                            'assets/icons/exchange.png',
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 10.h),
                          child: Image.network(
                            exchangeModel.book2.postUrl,
                            height: 25.h,
                            width: 35.w,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exchangeModel.book2.genre,
                        style: TextStyle(fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: blueAccent),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        exchangeModel.book2.title,
                        style: TextStyle(fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "DESCRIPTION",
                        style: TextStyle(fontSize: 10.sp,
                            color: textGrey,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        exchangeModel.book2.description,
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        acceptRequest();
                      },
                      child: Container(
                          height: 6.h,
                          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            // color: darkblue,
                            gradient: gradient,
                            // border: Border.all(color: black, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text("Accept Request",
                              style: TextStyle(
                                  fontSize: 13.sp, color: white, fontWeight: FontWeight.bold))),
                    )),
                Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavigationBarScreen()),
                        );
                      },
                      child: Container(
                          height: 6.h,
                          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            // color: darkblue,
                            gradient: gradient,
                            // border: Border.all(color: black, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text("Decline Request",
                              style: TextStyle(
                                  fontSize: 13.sp, color: white, fontWeight: FontWeight.bold))),
                    ))
              ],
            ),
          );
        }
      )

    );
  }
}
