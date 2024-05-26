import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String questionId;
  final String title;
  final String content;
  final List? images;
  final String avatar;
  final int age;
  final String sexual;
  final List likes;
  final int commentLength;
  final Timestamp createdAt;
  final String userId;
  final String? replierId;
  String? replierAvatar;
  String? replierName;

  Question({
    required this.questionId,
    required this.title,
    required this.content,
    required this.images,
    required this.avatar,
    required this.age,
    required this.sexual,
    required this.likes,
    required this.commentLength,
    required this.createdAt,
    required this.userId,
    required this.replierId,
    this.replierAvatar,
    this.replierName,
  });

  factory Question.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Question(
        questionId: data?['question_id'],
        title: data?['title'],
        content: data?['content'],
        images: data?['images'],
        avatar: data?['avatar'],
        age: data?['age'],
        sexual: data?['sexual'],
        likes: data?['likes'],
        commentLength: data?['commentLength'],
        createdAt: data?['created_at'],
        userId: data?['user_id'],
        replierId: data?['replier_id']);
  }
  Map<String, dynamic> toFirestore() => {
        'question_id': questionId,
        'title': title,
        'content': content,
        if (images != null) 'images': images,
        'avatar': avatar,
        'age': age,
        'sexual': sexual,
        'likes': likes,
        'commentLength': commentLength,
        'created_at': createdAt,
        'user_id': userId,
        if (replierId != null) 'replier_id': replierId,
      };
}
