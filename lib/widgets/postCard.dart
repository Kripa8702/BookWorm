import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:kimber/functions/userApiCalls.dart';
import 'package:kimber/models/postModel.dart';
import 'package:kimber/utils/colors.dart';
import 'package:kimber/widgets/actionButton.dart';
import 'package:sizer/sizer.dart';

class PostCard extends StatefulWidget {
  final PostModel postModel;
  const PostCard({Key? key, required this.postModel}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  var userModel;
  UserApiCalls userApiCalls = new UserApiCalls();
  bool loading = true;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async{
    var user = await userApiCalls.getOneUser(widget.postModel.userId);
    print(user);
    setState(() {
      userModel = user;
      loading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return loading?
    Container(
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
      // alignment: Alignment.center,
      height: 40.5.h,
      width: 90.w,
      decoration: BoxDecoration(
          color: black,
          // border: Border.all(
          //   color: borderColor
          // ),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Center(
        child: CircularProgressIndicator(
          color: yellowAccent2,
        ),
      ),
    )
    :
    Container(
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
      // alignment: Alignment.center,
      height: 40.5.h,
      width: 90.w,
      decoration: BoxDecoration(
          color: black,
          // border: Border.all(
          //   color: borderColor
          // ),
          borderRadius: BorderRadius.all(Radius.circular(25))),

      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25)),
                child: Image.network(
                widget.postModel.picUrl,
                  fit: BoxFit.cover,
                  height: 30.h,
                  width: 90.w,
                ),
              ),
              Positioned(
                bottom: 1.h,
                left: 3.w,
                child: GlassContainer(
                  height: 4.5.h,
                  width: 30.w,
                  blur: 4,
                  color: Colors.white.withOpacity(0.1),
                  child: Container(
                    height: 4.5.h,
                    width: 30.w,
                    alignment: Alignment.center,
                    child: Text(
                      '@${userModel.username}',
                      style: TextStyle(
                        color: white,
                        fontSize: 12.sp,
                        // fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.blue.withOpacity(0.3),
                    ],
                  ),
                  border: Border.all(color: borderColor, width: 1.5),
                  shadowStrength: 5,
                  shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(20),
                  shadowColor: Colors.white.withOpacity(0.24),
                ),
              ),
              Positioned(
                  bottom: 1.h,
                  right: 3.w,
                  child: CircleAvatar(
                    backgroundColor: black,
                    radius: 28,
                    child: CircleAvatar(
                        backgroundColor: black,
                        radius: 25,
                        backgroundImage: NetworkImage(
                          userModel.profilePic
                        )),
                  )
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 5.w,
              // vertical: 1.h
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.postModel.label??"",
                      style: TextStyle(color: white, fontSize: 18.sp),
                    ),
                    Text(
                      widget.postModel.description??"",
                      style: TextStyle(
                          color: yellowAccent, fontSize: 12.sp),
                    ),
                  ],
                ),
                //TODO: Like
                ActionButton(onTap: (){},
                    height: 5.h,
                    width: 10.w,
                    radius: 10,
                    child: Icon(
                      Icons.favorite,
                      // color: pinkAccent2,
                    ))
              ],
            ),
          )
        ],
      ),
      // )
    );
  }
}
