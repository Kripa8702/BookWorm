import 'package:book_worm/models/messageChatModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFunctions {
  final _firestoreInstance = FirebaseFirestore.instance;

  Future<void> sendMessage(String senderId, String senderName,
      String receiverId, String message) async {
    final timestamp = Timestamp.now();

    MessageModel messageModel = MessageModel(
        senderId: senderId,
        senderName: senderName,
        receiverId: receiverId,
        timestamp: timestamp,
        message: message);

    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _firestoreInstance
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(messageModel.toMap());
  }

  Stream<QuerySnapshot> getMessages(String uid1, uid2) {
    List<String> ids = [uid1, uid2];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestoreInstance
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
