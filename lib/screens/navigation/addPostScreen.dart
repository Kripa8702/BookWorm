import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:book_worm/firebaseResources/firestoreMethods.dart';
import 'package:book_worm/models/selectionModel.dart';
import 'package:book_worm/models/userModel.dart';
import 'package:book_worm/navigationBar.dart';
import 'package:book_worm/providers/userProvider.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:book_worm/utils/utils.dart';
import 'package:book_worm/widgets/gradientText.dart';
import 'package:book_worm/widgets/selectionWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? post;
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  bool loading = false;
  List<bool> selection = [false, false, false];
  String genre = "Fiction";

  postImage(String username, String uid, String genre) async {
    setState(() {
      loading = true;
    });

    try {
      String res = await FirestoreMethods().uploadImage(
        uid,
        post!,
        username,
        _descriptionController.text,
        _titleController.text,
        genre,
        selection[0],
        selection[1],
        selection[2],
      );

      setState(() {
        loading = false;
      });

      if (res == "success") {
        showSnackBar('Posted!', context);
      } else {
        showSnackBar(res, context);
      }

      setState(() {
        post = null;
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NavigationBarScreen(),
        ),
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  List<String> genreOptions = [
    "Fiction",
    "Non-fiction",
    "Thriller",
    "Mystery",
    "Romance",
    "Fantasy",
  ];
  int? _value = 0;

  String address = "null";
  String autocompletePlace = "null";

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  Widget button(BuildContext context, void Function()? onTap, String text) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 6.h,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 3.h, left: 8.w, right: 8.w),
        decoration: BoxDecoration(
            color: blueAccent, borderRadius: BorderRadius.circular(5)),
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
                    color: white, fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    return post == null
        ? Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: black,
                      // color: Colors.red,
                    ))),
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
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: GradientText('New Post',
                  gradient: gradient,
                  style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold)),
              centerTitle: false,
              actions: [
                IconButton(
                    onPressed: () => postImage(user.username, user.uid, genre),
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
                          height: 40.h,
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
                                  horizontal: 8, vertical: 10),
                              hintStyle: TextStyle(
                                  color: Colors.black26, fontSize: 12.sp),
                              fillColor: greyishWhite,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1.0,
                                  color: CupertinoColors.systemGrey4,
                                ), // BorderSide
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1.0,
                                  color: CupertinoColors.systemGrey4,
                                ), // BorderSide
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
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
                            style: TextStyle(color: black, fontSize: 13.sp),
                            decoration: InputDecoration(
                              hintText: 'Write your review...',
                              hintStyle: TextStyle(
                                  color: Colors.black26, fontSize: 12.sp),
                              fillColor: greyishWhite,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1.0,
                                  color: CupertinoColors.systemGrey4,
                                ), // BorderSide
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1.0,
                                  color: CupertinoColors.systemGrey4,
                                ), // BorderSide
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
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
                                backgroundColor: CupertinoColors.systemGrey5,
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
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                          height: 25.h,
                          width: 85.w,
                          child: AnimatedItemPicker(
                            axis: Axis.vertical,
                            multipleSelection: true,
                            itemCount: Selection.LIST.length,
                            maxItemSelectionCount: 3,
                            expandedItems: true,
                            onItemPicked: (index, selected) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              print(
                                  "Selection: ${Selection.LIST[index]}, selected: $selected");
                              setState(() {
                                selection[index] = !selection[index];
                              });
                              print(selection);
                            },
                            itemBuilder: (index, animValue) =>
                                SelectionItemWidget(
                              name: Selection.LIST[index],
                              textColor: black,
                              backgroundColor:
                                  selection[index] ? blueAccent : greyishWhite,
                            ),
                          ),
                        )
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
