import 'dart:convert';

class PostModel {
  String userId;
  String postId;
  String picUrl;
  String? label;
  String? description;
  String datePublished;
  List<String>? likes;
  List<String>? tags;

  PostModel({
    required this.userId,
    required this.postId,
    required this.picUrl,
    required this.datePublished,
    this.label,
    this.description,
    this.likes,
    this.tags,
  });

  factory PostModel.fromJson(Map<String, dynamic> jsonData) {
    return PostModel(
      userId: jsonData["userId"] != null ? jsonData["userId"] : "NA",
      postId: jsonData["postId"] != null ? jsonData["postId"] : "NA",
      picUrl: jsonData["picUrl"] != null ? jsonData["picUrl"] : "NA",
      datePublished:
          jsonData["datePublished"] != null ? jsonData["datePublished"] : "NA",
      label: jsonData["label"] != null ? jsonData["label"] : "NA",
      description:
          jsonData["description"] != null ? jsonData["description"] : "NA",
      likes: List<String>.from(jsonData["likes"]??[]) ,
      tags: List<String>.from(jsonData["tags"]??[]) ,
    );
  }

  static Map<String, dynamic> toMap(PostModel postModel) => {
    'userId': postModel.userId,
    'postId': postModel.postId,
    'picUrl': postModel.picUrl,
    'datePublished': postModel.datePublished,
    'label': postModel.label,
    'description': postModel.description,
    'likes': postModel.likes,
    'tags': postModel.tags,
  };

  static String encode(var posts) => json.encode(
    posts
        .map<Map<String, dynamic>>((post) => PostModel.toMap(post))
        .toList(),
  );

  static List<PostModel> decode(String posts) =>
      (json.decode(posts) as List<dynamic>)
          .map<PostModel>((post) => PostModel.fromJson(post))
          .toList();
}
