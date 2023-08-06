import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String senderName;
  final String receiverId;
  final Timestamp timestamp;
  final String message;

  const MessageModel({
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.timestamp,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': this.senderId,
      'senderName': this.senderName,
      'receiverId': this.receiverId,
      'timestamp': this.timestamp,
      'message': this.message,
    };
  }

  factory MessageModel.fromDocument(DocumentSnapshot doc) {
    String senderId = doc.get('senderId');
    String senderName = doc.get('senderName');
    String receiverId = doc.get('receiverId');
    Timestamp timestamp = doc.get('timestamp');
    String message = doc.get('message');
    return MessageModel(
        senderId: senderId,
        senderName: senderName,
        receiverId: receiverId,
        timestamp: timestamp,
        message: message);
  }
}
