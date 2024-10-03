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
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Future<void> addPost(Post post, BuildContext context) async {
    try {
      await _firestore.collection('posts').doc(post.id).set(post.toMap());

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(post.uid).get();

      if (userDoc.exists) {
        Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;
        List<Post> userPosts = [];
        if (userData != null && userData['posts'] is List) {
          userPosts = (userData['posts'] as List)
              .map((postData) => Post.fromMap(postData as Map<String, dynamic>))
              .toList();
        }

        userPosts.add(post);

        await _firestore.collection('users').doc(post.uid).update({
          'posts': userPosts.map((p) => p.toMap()).toList(),
        });
      } else {
        throw Exception('User not found');
      }
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

  Stream<List<Comment>> getCommentsStream(String postId, BuildContext context) {
    try {
      return _firestore
          .collection('comments')
          .where('postId', isEqualTo: postId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Comment.fromMap(
                    doc.data(),
                  ),
                )
                .toList(),
          );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString(), 'Oh Snap!');
      return Stream.value([]);
    }
  }

  Stream<List<Post>> getUserPostsStream(String userId, BuildContext context) {
    try {
      return _firestore
          .collection('posts')
          .where('uid', isEqualTo: userId)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Post.fromMap(
                    doc.data(),
                  ),
                )
                .toList(),
          );
    } catch (e) {
      showSnackBar(context, e.toString(), 'Oh Snap!');
      return Stream.value([]);
    }
  }

  Future<void> likePost(Post post, String userId) async {
    DocumentReference postRef = _firestore.collection('posts').doc(post.id);

    if (post.likedBy.contains(userId)) {
      await postRef.update({
        'likedBy': FieldValue.arrayRemove([userId]),
      });
    } else {
      await postRef.update({
        'likedBy': FieldValue.arrayUnion([userId]),
      });
    }
  }

  Future<void> savePost(Post post, String userId) async {
    DocumentReference postRef = _firestore.collection('posts').doc(post.id);

    if (post.savedBy.contains(userId)) {
      await postRef.update({
        'savedBy': FieldValue.arrayRemove([userId]),
      });
    } else {
      await postRef.update({
        'savedBy': FieldValue.arrayUnion([userId]),
      });
    }
  }

  Stream<List<Post>> getSavedPostsStream(String userId, BuildContext context) {
    try {
      return _firestore
          .collection('posts')
          .where('savedBy', arrayContains: userId)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map(
                (doc) => Post.fromMap(
                  doc.data(),
                ),
              )
              .toList());
    } catch (e) {
      showSnackBar(context, e.toString(), 'Oh Snap!');
      return Stream.value([]);
    }
  }
}
