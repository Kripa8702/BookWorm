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
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));
  List<PostModel> postList = [];
  final _controller = SidebarXController(selectedIndex: 0, extended: false);
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getAllPosts();
    super.initState();
  }

  getAllPosts() async {
    String? allPosts = await storage.read(key: 'allPosts');
    var posts = PostModel.decode(allPosts ?? "");
    print(posts);
    setState(() {
      postList = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
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
        drawer: SideBar(
          controller: _controller,
        ),
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: Row(
            children: [
              if (!isSmallScreen)
                SideBar(
                  controller: _controller,
                ),
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
                            });
                          },
                          child: Container(
                            height: 5.h,
                              width: 10.w,
                              margin: EdgeInsets.only(top: 1.h, left: 5.w),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.menu,
                                color: blueAccent,
                                size: 20.sp,
                              )),
                        ),
                        KimberLogo(fontSize: 28.sp)
                      ],
                    ),
                    Expanded(
                        child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: postList.length,
                      itemBuilder: (context, index) => PostCard(
                        postModel: postList[index],
                      ),
                    ))
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
