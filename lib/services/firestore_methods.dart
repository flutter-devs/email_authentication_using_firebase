import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_email_authentication/services/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/post_model.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    String uid,
    Uint8List file,
    String username,
  ) async {
    String result = "Some error occurred";
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage(
        'posts',
        file,
        true,
      );
      String postId = Uuid().v1();
      PostModel postModel = PostModel(
        description: description,
        datePublished: DateTime.now(),
        username: username,
        uid: uid,
        postId: postId,
        postUrl: photoUrl,
        likes: [],
      );
      _firestore.collection('posts').doc(postId).set(
            postModel.toJson(),
          );
      result = "success";
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
