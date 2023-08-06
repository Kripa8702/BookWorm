import 'package:book_worm/functions/chatFunctions.dart';
import 'package:book_worm/models/userModel.dart';
import 'package:book_worm/providers/userProvider.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:book_worm/widgets/inputField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  const ChatScreen(
      {super.key, required this.receiverId, required this.receiverName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatFunctions chatFunctions = ChatFunctions();

  getCurrentUser() {}

  sendMessage(BuildContext context) async {
    final UserModel user =
        Provider.of<UserProvider>(context, listen: false).getUser;
    print("DONE");

    if (_messageController.text.isNotEmpty) {
      await chatFunctions.sendMessage(
          user.uid, user.username, widget.receiverId, _messageController.text);

      _messageController.clear();
    }
  }

  //
  // @override
  // void initState() {
  //   getCurrentUser();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        title: Text(widget.receiverName,
            style: TextStyle(
                color: black, fontSize: 16.sp, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    final UserModel user =
        Provider.of<UserProvider>(context, listen: false).getUser;

    return StreamBuilder<QuerySnapshot>(
        stream: chatFunctions.getMessages(user.uid, widget.receiverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: blueAccent,
              ),
            );
          }
          print("Chats : ${snapshot.data!.docs.length}");
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot snapshot) {
    final UserModel user =
        Provider.of<UserProvider>(context, listen: false).getUser;
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == user.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    bool sender = (data['senderId'] == user.uid) ? true : false;

    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: alignment,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:
                  sender ? greenAccent.withOpacity(0.5) : Colors.grey.shade200),
          padding: EdgeInsets.all(16),
          child: Text(
            data['message'],
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Expanded(
              child: InputField(
            controller: _messageController,
            fieldType: 'Message',
            hint: 'Enter Message',
            textCapitalization: TextCapitalization.sentences,
            isChat: true,
          )),
          IconButton(
            onPressed: () async {
              await sendMessage(context);
            },
            icon: const Icon(
              Icons.send_rounded,
              size: 24,
              color: blueAccent,
            ),
          )
        ],
      ),
    );
  }
}
