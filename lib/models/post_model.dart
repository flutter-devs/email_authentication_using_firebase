import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String description;
  final String postId;
  final String uid;
  final String username;
  final datePublished;
  final String postUrl;
  final likes;

  PostModel({
    required this.description,
    required this.datePublished,
    required this.username,
    required this.uid,
    required this.postId,
    required this.postUrl,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "postId": postId,
        "username": username,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "likes": likes,
      };

  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostModel(
      username: snapshot['username'],
      uid: snapshot['uid'],
      postUrl: snapshot['postUrl'],
      postId: snapshot['postId'],
      likes: snapshot['likes'],
      datePublished: snapshot['datePublished'],
      description: snapshot['description'],
    );
  }
}
