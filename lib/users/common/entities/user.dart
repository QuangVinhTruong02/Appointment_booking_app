import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserData with EquatableMixin {
  final String? userId;
  final String? email;
  final String? userName;
  final String? photoUrl;
  final String? role;
  final Timestamp? createdAt;
  UserData(
      {this.userId,
      this.email,
      this.userName,
      this.photoUrl,
      this.role,
      this.createdAt});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserLoginResponse {
  String? email;
  String? userId;
  String? photoUrl;
  String? userName;
  String? role;

  UserLoginResponse({
    this.email,
    this.userId,
    this.photoUrl,
    this.userName,
    this.role,
  });

  UserLoginResponse copyWith({
    String? userName,
    String? photoUrl,
  }) {
    return UserLoginResponse(
      userId: userId,
      email: email,
      userName: userName ?? this.userName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginResponse(
      email: json['email'],
      userId: json['user_id'],
      photoUrl: json['photo_url'],
      userName: json['user_name'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'user_id': userId,
        'photo_url': photoUrl,
        'user_name': userName,
        'role': role,
      };
}
