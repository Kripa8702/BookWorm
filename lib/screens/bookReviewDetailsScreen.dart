import 'package:book_worm/models/postModel.dart';
import 'package:book_worm/screens/enterBookDetails.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BookReviewDetailsScreen extends StatefulWidget {
  final PostModel postModel;

  const BookReviewDetailsScreen({Key? key, required this.postModel});

  @override
  State<BookReviewDetailsScreen> createState() =>
      _BookReviewDetailsScreenState();
}

class _BookReviewDetailsScreenState extends State<BookReviewDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                Positioned(
                    top: 3.h,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 9.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.postModel.postUrl,
                      height: 30.h,
                      width: 80.w,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.postModel.genre,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: blueAccent),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    widget.postModel.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "DESCRIPTION",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: textGrey,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    widget.postModel.description,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            widget.postModel.exchange
                ? Button(
                    text: "Exchange",
                    postModel: widget.postModel,
                  )
                : Container(),
            widget.postModel.sell
                ? Button(
                    text: "Buy",
                    postModel: widget.postModel,
                  )
                : Container(),
            widget.postModel.rent
                ? Button(
                    text: "Rent",
                    postModel: widget.postModel,
                  )
                : Container(),
            SizedBox(
              height: 2.h,
            ),
            Divider(
              indent: 5.w,
              endIndent: 5.w,
              color: Colors.grey,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
              child: Row(
                children: [
                  Text(
                    "SIMILAR BOOKS",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: textGrey,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    "View all",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: blueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              height: 18.h,
              alignment: Alignment.center,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                children: [
                  books(
                      "https://i.guim.co.uk/img/media/51e82d1479c8bec3fbf6e620f44199490171ac66/433_134_1145_1723/master/1145.jpg?width=140&dpr=2&s=none"),
                  books(
                      "https://hips.hearstapps.com/digitalspyuk.cdnds.net/15/50/1449878132-9781781100264.jpg?resize=980:*"),
                  books(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPDiJuC5_sk74dU9GfxwigDuuWTqAn54hEjQ&usqp=CAU"),
                  books(
                      "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/contemporary-fiction-night-time-book-cover-design-template-1be47835c3058eb42211574e0c4ed8bf_screen.jpg?ts=1637012564"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget books(String image) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 1.w),
      child: Image.network(
        image,
        height: 15.h,
        width: 22.w,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final PostModel postModel;

  Button({
    Key? key,
    required this.text,
    required this.postModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EnterBookDetailsForExchange(
                        postModel: postModel,
                      )),
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
              child: Text(text,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: white,
                      fontWeight: FontWeight.bold))),
        ));
  }
}
