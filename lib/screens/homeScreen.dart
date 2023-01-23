import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kimber/models/postModel.dart';
import 'package:kimber/utils/colors.dart';
import 'package:kimber/widgets/kimberLogo.dart';
import 'package:kimber/widgets/postCard.dart';
import 'package:kimber/widgets/sideBar.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions:  AndroidOptions(
        encryptedSharedPreferences: true,
      )
  );
  List<PostModel> postList = [];
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getAllPosts();
    super.initState();
  }

  getAllPosts() async{
    String? allPosts = await storage.read(key: 'allPosts');
    var posts = PostModel.decode(allPosts??"");
    print(posts);
    setState(() {
      postList = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      key: _key,
      drawer: SideBar(controller: _controller,),
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Row(
          children: [
            if (!isSmallScreen) SideBar(controller: _controller,),
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _key.currentState?.openDrawer();
                            // _key.currentState?;
                          });
                        },
                        child: Container(
                            height: 4.h,
                            width: 10.w,
                            margin: EdgeInsets.only(top: 1.h, left: 5.w),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // color: Color(0xFF00f7a7),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.1, 0.9],
                                  colors: [
                                    blue,
                                    yellowAccent2,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: yellowAccent2.withAlpha(60),
                                //     blurRadius: 6.0,
                                //     spreadRadius: 2.0,
                                //     // offset: Offset(
                                //     //   0.0,
                                //     //   3.0,
                                //     // ),
                                //   ),
                                // ]
                            ),
                            child: const Icon(
                              Icons.menu,
                            )),
                      ),

                      KimberLogo()
                    ],
                  ),
                  Expanded(
                    // margin: EdgeInsets.only(top: 5.h, left: 6.w),
                    // height: 200,

                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: postList.length,
                        itemBuilder: (context, index) => PostCard(
                           postModel: postList[index],
                    ),
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
