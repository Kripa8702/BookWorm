import 'package:book_worm/firebaseResources/authMethods.dart';
import 'package:book_worm/firebaseResources/firebasePushNotificationMethods.dart';
import 'package:book_worm/models/userModel.dart';
import 'package:book_worm/providers/userProvider.dart';
import 'package:book_worm/screens/authentication/entryPointScreen.dart';
import 'package:book_worm/widgets/bookWormLogo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:book_worm/models/postModel.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:book_worm/widgets/postCard.dart';
import 'package:book_worm/widgets/sideBar.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _key = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    FocusScopeNode currentFocus = FocusScope.of(context);

    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          setState(() {
            _key.currentState?.openDrawer();
          });
        }
      },
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          backgroundColor: blueAccent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(20)),
          ),
          width: 65.w,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.symmetric(vertical: 3.h),
            children: [
              ListTile(
                title: Text('Change Location',
                    style: TextStyle(color: white, fontSize: 14.sp)),
                onTap: () async {

                },
              ),
              ListTile(
                title: Text('Sign Out',
                    style: TextStyle(color: white, fontSize: 14.sp)
              ),
                onTap: () async {
                  Provider. of<UserProvider>(context).dispose();

                  await AuthMethods().signOut();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EntryPointScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Image.asset(
                          'assets/icons/Logo.png',
                          height: 5.h,),
                        BookWormLogo(fontSize: 22.sp),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16,right: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: EdgeInsets.all(8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade100
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('posts')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          print("POSTS : ${snapshot.data!.docs.length}");
                          return Expanded(
                              child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => PostCard(
                              snap: snapshot.data!.docs[index]??"",
                            ),
                          ));
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
