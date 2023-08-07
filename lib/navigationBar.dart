import 'package:book_worm/firebaseResources/firebasePushNotificationMethods.dart';
import 'package:book_worm/models/userModel.dart';
import 'package:book_worm/providers/userProvider.dart';
import 'package:book_worm/screens/navigation/addPostScreen.dart';
import 'package:book_worm/screens/navigation/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:book_worm/screens/navigation/homeScreen.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import 'screens/navigation/allChatsScreen.dart';

class NavigationBarScreen extends StatefulWidget {
  int? index = 0;
  NavigationBarScreen({Key? key, this.index}) : super(key: key);

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  var selected = 0;
  late PageController pageController;
  var pages = [
    const HomeScreen(),
    const Text('home'),
    const AllChatsScreen(),
    const Text('home'),
  ];

  @override
  initState() {
    super.initState();
    selected = widget.index??0;
    pageController = PageController(
      initialPage: widget.index??0
    );
    addData();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    await FirebaseNotificationMethods().initNotification(context);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: PageView(
          controller: pageController,
          children: pages,
        ),
        bottomNavigationBar: StylishBottomBar(
          option: AnimatedBarOptions(
            padding: EdgeInsets.all(8),
            // iconSize: 32,
            barAnimation: BarAnimation.fade,
            iconStyle: IconStyle.animated,
            // opacity: 0.3,
          ),
          items: [
            BottomBarItem(
                icon: const Icon(
                  Icons.home_filled,
                ),
                unSelectedColor: black,
                // backgroundColor: Colors.amber,
                selectedColor: darkBlueAccent,
                title: const Text('Home')),
            BottomBarItem(
                icon: const Icon(
                  Icons.search,
                ),
                // backgroundColor: Colors.amber,
                selectedColor: darkBlueAccent,
                unSelectedColor: black,
                title: const Text('Explore')),
            BottomBarItem(
                icon: const Icon(
                  Icons.chat_bubble_rounded,
                ),
                selectedColor: darkBlueAccent,
                unSelectedColor: black,
                title: const Text('Chat')),
            BottomBarItem(
                icon: const Icon(
                  Icons.person,
                ),
                // backgroundColor: Colors.amber,
                selectedColor: darkBlueAccent,
                unSelectedColor: black,
                title: const Text('Profile')),

          ],
          backgroundColor: greenAccent,
          elevation: 200,
          fabLocation: StylishBarFabLocation.center,
          hasNotch: true,
          // iconStyle: IconStyle.animated,
          // iconSize: 32,
          currentIndex: selected,
          onTap: (index) {
            setState(() {
              selected = index!;
              pageController.jumpToPage(index);
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddPostScreen(),
              ),
            );
          },
          backgroundColor: blueAccent,
          child: const Icon(
            Icons.add_rounded,
            size: 35,
            color: black,
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}
