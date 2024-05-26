import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String commentId;
  final String content;
  final String userId;
  final String role;
  final Timestamp createdAt;

  Comment({
    required this.commentId,
    required this.content,
    required this.userId,
    required this.role,
    required this.createdAt,
  });

  factory Comment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Comment(
      commentId: data?['comment_id'],
      content: data?['content'],
      userId: data?['user_id'],
      role: data?['role'],
      createdAt: data?['created_at'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'comment_id': commentId,
        'content': content,
        'user_id': userId,
        'role': role,
        'created_at': createdAt,
      };
}
