import 'package:book_worm/firebaseResources/firebasePushNotificationMethods.dart';
import 'package:book_worm/models/postModel.dart';
import 'package:book_worm/models/userModel.dart';
import 'package:book_worm/providers/userProvider.dart';
import 'package:book_worm/screens/bookReviewDetailsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:book_worm/functions/userApiCalls.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:book_worm/widgets/actionButton.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PostCard extends StatefulWidget {
  final snap;

  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookReviewDetailsScreen(
                postModel: PostModel.fromSnap(widget.snap)),
          ),
        );

        // //SEND NOTIFICATION--------
        // final UserModel user = Provider.of<UserProvider>(context, listen: false).getUser;
        // String uid = widget.snap['uid'] ?? "";
        // print(uid);
        //
        // DocumentSnapshot snap = await FirebaseFirestore.instance
        //     .collection('userTokens')
        //     .doc(uid)
        //     .get();
        //
        // print(snap);
        //
        // String token = snap['token']??"";
        // print(token);
        //
        // await FirebaseNotificationMethods()
        //     .sendPushMessage("BODY", "TITLE", token);
        //
        // print("SENTT");
        // Navigator.of(context).pushNamed('/notification');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        // alignment: Alignment.center,
        // height: 40.h,
        // width: 90.w,
        decoration: BoxDecoration(
            color: white,
            border: Border.all(color: black.withOpacity(0.1), width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(10))),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              height: 22.h,
              width: 28.w,
              child: Image.network(
                widget.snap['postUrl'].toString(),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              width: 50.w,
              height: 22.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.snap['genre'] ?? "",
                        style: TextStyle(
                            color: blueAccent,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        widget.snap['title'] ?? "",
                        style: TextStyle(
                            color: black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        (widget.snap['description'].length >= 95)
                            ? "${widget.snap['description'].toString().substring(0, 95)}..."
                            : widget.snap['description'],
                        style: TextStyle(
                          color: black,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    widget.snap['exchange']
                        ? Container(
                            margin: EdgeInsets.only(right: 1.w),
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 3.w),
                            // alignment: Alignment.center,
                            // height: 40.h,
                            // width: 90.w,
                            decoration: BoxDecoration(
                                color: purpleAccent.withOpacity(0.3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              "Exchange",
                              style: TextStyle(
                                  color: purpleAccent,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(),
                    widget.snap['sell']
                        ? Container(
                            margin: EdgeInsets.only(right: 1.w),
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 3.w),
                            // alignment: Alignment.center,
                            // height: 40.h,
                            // width: 90.w,
                            decoration: BoxDecoration(
                                color: greenAccent2.withOpacity(0.3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              "Buy",
                              style: TextStyle(
                                  color: greenAccent2,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(),
                    widget.snap['rent']
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 3.w),
                            // alignment: Alignment.center,
                            // height: 40.h,
                            // width: 90.w,
                            decoration: BoxDecoration(
                                color: blueAccent.withOpacity(0.3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              "Rent",
                              style: TextStyle(
                                  color: blueAccent,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(),
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
