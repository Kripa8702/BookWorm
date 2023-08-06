import 'package:flutter/material.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:sizer/sizer.dart';

class SideBar extends StatelessWidget {
  SidebarXController controller;
  SideBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _controller = SidebarXController(selectedIndex: 0, extended: true);

    return SidebarX(
      controller: controller,
      animationDuration: Duration(milliseconds: 500),
      theme: SidebarXTheme(
        margin: EdgeInsets.only(top: 8.h, bottom: 10.h),
        decoration: BoxDecoration(
          color: darkblue,
          borderRadius: BorderRadius.circular(20),
        ),
        // hoverColor: borderColor,
        textStyle: TextStyle(color: white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: black),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: black),
        ),
        selectedItemDecoration: BoxDecoration(
          color: blueAccent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: black,
          size: 20,
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: 50.w,
        margin: EdgeInsets.only(top: 8.h, bottom: 10.h),
        decoration: BoxDecoration(
          color: darkblue,
            borderRadius: BorderRadius.circular(20)
        ),
      ),
      headerDivider: Container(
          margin: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
          child: Divider(color:  borderColor,
              height: 1,
          )),

      footerDivider: Container(
          margin: EdgeInsets.only(bottom: 3.h,left: 2.w, right: 2.w),
          child: Divider(color: borderColor, height: 1)),
      headerBuilder: (context,extended){
        return Container(
          margin: EdgeInsets.only(top: 2.h),

          child:  SizedBox(
            height: 100,
            child: CircleAvatar(
              radius: 30,
              child: Image.asset("assets/icons/user.png",
                height: 4.h,),
              backgroundColor: black,
            ),

          ),
        );
      },
      toggleButtonBuilder: (context,extended){
        return Container(
          margin: EdgeInsets.only(bottom: 5.h),

          child: GestureDetector(
            onTap: (){
              controller.toggleExtended();
            },
            child: SizedBox(
              height: 2.h,
              width: 10.w,
              child: controller.extended?
              Icon(Icons.arrow_back_ios_new,color: black,)
              : Icon(Icons.arrow_forward_ios,color: black,),
            ),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            debugPrint('Home');
          },
        ),
        const SidebarXItem(
          icon: Icons.search,
          label: 'Search',
        ),
        const SidebarXItem(
          icon: Icons.people,
          label: 'People',
        ),
        const SidebarXItem(
          icon: Icons.favorite,
          label: 'Favorites',
        ),
      ],
    );

  }
}
