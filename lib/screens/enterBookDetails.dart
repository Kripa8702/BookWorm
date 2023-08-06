import 'package:book_worm/firebaseResources/firebasePushNotificationMethods.dart';
import 'package:book_worm/firebaseResources/firestoreMethods.dart';
import 'package:book_worm/models/postModel.dart';
import 'package:book_worm/models/userModel.dart';
import 'package:book_worm/navigationBar.dart';
import 'package:book_worm/providers/userProvider.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:book_worm/utils/utils.dart';
import 'package:book_worm/widgets/gradientText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EnterBookDetailsForExchange extends StatefulWidget {
  final PostModel postModel;

  const EnterBookDetailsForExchange({
    super.key,
    required this.postModel,
  });

  @override
  State<EnterBookDetailsForExchange> createState() =>
      _EnterBookDetailsForExchangeState();
}

class _EnterBookDetailsForExchangeState
    extends State<EnterBookDetailsForExchange> {
  Uint8List? post;
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  bool loading = false;

  String genre = "Fiction";
  int? _value = 0;

  List<String> genreOptions = [
    "Fiction",
    "Non-fiction",
    "Thriller",
    "Mystery",
    "Romance",
    "Fantasy",
  ];

  Widget button(BuildContext context, void Function()? onTap, String text) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 6.h,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 3.h, left: 8.w, right: 8.w),
        decoration: BoxDecoration(
            color: blueAccent, borderRadius: BorderRadius.circular(10)),
        child: loading
            ? Container(
                height: 2.2.h,
                width: 2.2.h,
                child: const CircularProgressIndicator(
                  color: white,
                  strokeWidth: 3.0,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                    color: white, fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  sendRequest(String username, String uid, String genre) async {
    setState(() {
      loading = true;
    });
    try {
      String res = "";
      String exchangeId = await FirestoreMethods().postExchangeRequest(
          widget.postModel,
          uid,
          post!,
          username,
          _descriptionController.text,
          _titleController.text,
          genre,
          true,
          false,
          false);

      await sendNotification(username, exchangeId);

      setState(() {
        loading = false;
      });

      res = "success";
      if (res == "success") {
        showSnackBar('Exchange request sent!', context);
      } else {
        showSnackBar(res, context);
      }

      setState(() {
        post = null;
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const NavigationBarScreen(),
        ),
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  //SEND NOTIFICATION--------
  sendNotification(String username, String exchangeId) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('userTokens')
        .doc(widget.postModel.uid)
        .get();

    print(snap);

    String token = snap['token'] ?? "";
    print(token);

    String title = "Book Exchange Request";
    String body =
        "$username wants to exchange a book with you. Tap to know more";

    await FirebaseNotificationMethods()
        .sendPushMessage(body, title, exchangeId, "/notification", token);

    print("SENTT");
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;

    return post == null
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              title: GradientText('Upload Image of Book',
                  gradient: gradient,
                  style: TextStyle(color: white, fontSize: 16.sp)),
              centerTitle: false,
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(context, () async {
                  Uint8List file = await pickImage(ImageSource.camera);

                  setState(() {
                    post = file;
                  });
                }, "Take a photo"),
                button(context, () async {
                  Uint8List file = await pickImage(ImageSource.gallery);

                  setState(() {
                    post = file;
                  });
                }, "Choose from gallery"),
              ],
            )
                // IconButton(
                //     icon: const Icon(Icons.upload_rounded, color: blueAccent,),
                //     onPressed: () => _selectImage(context),
                // ),
                ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              title: GradientText('Book Details for Exchange',
                  gradient: gradient,
                  style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold)),
              centerTitle: false,
              actions: [
                IconButton(
                    onPressed: () async {
                      await sendRequest(user.username, user.uid, genre);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NavigationBarScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.check,
                      color: blueAccent,
                      size: 22.sp,
                    )),
                SizedBox(
                  width: 4.w,
                )
              ],
            ),
            body: Column(
              children: [
                loading
                    ? LinearProgressIndicator(
                        color: blueAccent,
                        backgroundColor: greenAccent.withOpacity(0.5),
                      )
                    : const Padding(padding: EdgeInsets.only(top: 0.0)),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // //Profile pic
                        // CircleAvatar(
                        //   backgroundImage: NetworkImage(user.photoUrl ?? ""),
                        // ),
                        // Post
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          height: 30.h,
                          width: 50.w,
                          child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: MemoryImage(post!),
                                    fit: BoxFit.fitHeight,
                                    alignment: FractionalOffset.center),
                              )),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        //Caption
                        SizedBox(
                          width: 85.w,
                          child: TextField(
                            textCapitalization: TextCapitalization.words,
                            controller: _titleController,
                            cursorColor: blueAccent,
                            style: TextStyle(color: black, fontSize: 12.sp),
                            decoration: InputDecoration(
                              hintText: 'Book title...',
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              hintStyle: TextStyle(
                                  color: Colors.black26, fontSize: 12.sp),
                              fillColor: greyishWhite,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: CupertinoColors.systemGrey4,
                                ), // BorderSide
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: CupertinoColors.systemGrey4,
                                ), // BorderSide
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 2.0,
                                  color: blueAccent,
                                ), // BorderSide
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                          width: 85.w,
                          child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: 8,
                            controller: _descriptionController,
                            cursorColor: blueAccent,
                            style: TextStyle(color: black, fontSize: 12.sp),
                            decoration: InputDecoration(
                              hintText: 'Write your review...',
                              hintStyle: TextStyle(
                                  color: Colors.black26, fontSize: 12.sp),
                              fillColor: greyishWhite,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 2.0,
                                  color: CupertinoColors.systemGrey4,
                                ), // BorderSide
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 2.0,
                                  color: CupertinoColors.systemGrey4,
                                ), // BorderSide
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 2.0,
                                  color: blueAccent,
                                ), // BorderSide
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Wrap(
                          spacing: 5.0,
                          children: List<Widget>.generate(
                            genreOptions.length,
                            (int index) {
                              return ChoiceChip(
                                label: Text(genreOptions[index]),
                                labelStyle: _value == index
                                    ? TextStyle(color: white, fontSize: 12.sp)
                                    : TextStyle(color: black, fontSize: 12.sp),
                                backgroundColor: greyishWhite,
                                selectedColor: blueAccent,
                                selected: _value == index,
                                onSelected: (bool selected) {
                                  setState(() {
                                    _value = selected ? index : null;
                                    genre = genreOptions[index];
                                  });
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider()
              ],
            ),
          );
  }
}
