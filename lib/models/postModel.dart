import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String description;
  final String title;
  final String uid;
  final String username;
  final String postId;
  final String genre;
  final String postUrl;

  final bool exchange;
  final bool sell;
  final bool rent;

  const PostModel({
    required this.description,
    required this.title,
    required this.uid,
    required this.username,
    required this.postId,
    required this.genre,
    required this.postUrl,
    required this.exchange,
    required this.sell,
    required this.rent,
  });

  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
        description: snapshot["description"],
        title: snapshot["title"],
        uid: snapshot["uid"],
        postId: snapshot["postId"],
        genre: snapshot["genre"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        exchange: snapshot['exchange'],
        sell: snapshot['sell'],
        rent: snapshot['rent']);
  }


  Map<String, dynamic> toJson() => {
        "description": description,
        "title": title,
        "uid": uid,
        "username": username,
        "postId": postId,
        "genre": genre,
        'postUrl': postUrl,
        'exchange': exchange,
        'sell': sell,
        'rent': rent
      };

  factory PostModel.fromJson(Map<String, dynamic> jsonData) {
    return PostModel(
        description: jsonData["description"],
        title: jsonData["title"],
        uid: jsonData["uid"],
        postId: jsonData["postId"],
        genre: jsonData["genre"],
        username: jsonData["username"],
        postUrl: jsonData['postUrl'],
        exchange: jsonData['exchange'],
        sell: jsonData['sell'],
        rent: jsonData['rent']);
  }

}
