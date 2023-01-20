import 'package:flutter/material.dart';
import 'package:kimber/screens/homeScreen.dart';
import 'package:kimber/utils/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  var selected = 0;
  late PageController pageController;
  var pages = [HomeScreen(), Text('home'), Text('home'), Text('home')];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
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
        items: [
          AnimatedBarItems(
                icon: const Icon(
                  Icons.home_filled,
                ),
                // backgroundColor: Colors.amber,
                selectedColor: yellowAccent,
                title: const Text('Home')),
          AnimatedBarItems(
              icon: const Icon(
                Icons.search,
              ),
              // backgroundColor: Colors.amber,
              selectedColor: yellowAccent,
              title: const Text('Search')),

          AnimatedBarItems(
              icon: const Icon(
                Icons.style,
              ),
              // backgroundColor: Colors.amber,
              selectedColor: yellowAccent,
              title: const Text('Home')),

            AnimatedBarItems(
              icon: const Icon(
                Icons.person,
              ),
              selectedColor: yellowAccent,
              title: const Text('Profile')),
        ],
        padding: EdgeInsets.only(top: 1.h),
        backgroundColor: black,
        unselectedIconColor: white,
        elevation: 200,
        fabLocation: StylishBarFabLocation.center,
        hasNotch: true,
        // iconStyle: IconStyle.animated,
        // iconSize: 32,
        barStyle: BubbleBarStyle.horizotnal,
        barAnimation: BarAnimation.liquid,
        bubbleFillStyle: BubbleFillStyle.fill,
        opacity: 0.3,
        currentIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index!;
            pageController.jumpToPage(index);
          });
        },
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_rounded,
          size: 35,
          color: black
            ,),
          backgroundColor: yellowAccent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
    );
  }
}
