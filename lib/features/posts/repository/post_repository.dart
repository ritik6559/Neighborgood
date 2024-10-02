import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neighborgood/models/post.dart';
import 'package:neighborgood/models/comments.dart';
import 'package:neighborgood/common/utils/show_snackbar.dart';

class PostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Post>> get postsStream {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Post.fromMap(
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Future<void> addPost(Post post, BuildContext context) async {
    try {
      await _firestore.collection('posts').doc(post.id).set(post.toMap());
    } on FirebaseException catch (e) {
      showSnackBar(
        context,
        e.message!,
        'Oh Snap!',
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
        'Oh Snap!',
      );
    }
  }

  Future<void> addComment(Comment comment, BuildContext context) async {
    try {
      await _firestore
          .collection('comments')
          .doc(comment.id)
          .set(comment.toMap());
      await _firestore
          .collection('posts')
          .doc(comment.postId)
          .update({'commentCount': FieldValue.increment(1)});
    } on FirebaseException catch (e) {
      showSnackBar(
        context,
        e.message!,
        'Oh Snap!',
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
        'Oh Snap!',
      );
    }
  }

  Stream<List<Comment>> getCommentsStream(String postId) {
    return _firestore
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Comment.fromMap(
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }
}
