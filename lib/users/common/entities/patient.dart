import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientUser extends UserData {
  final String? sexual;
  final String? DOB;
  final String? phoneNumber;

  PatientUser({
    String? userId,
    String? email,
    String? userName,
    String? photoUrl,
    String? role,
    Timestamp? createdAt,
    this.sexual,
    this.DOB,
    this.phoneNumber,
  }) : super(
          userId: userId,
          email: email,
          photoUrl: photoUrl,
          userName: userName,
          role: role,
          createdAt: createdAt,
        );

  PatientUser copyWith({
    String? userName,
    String? photoUrl,
    String? sexual,
    String? DOB,
    String? phoneNumber,
  }) {
    return PatientUser(
      userId: userId,
      email: email,
      role: role,
      createdAt: createdAt,
      userName: userName ?? this.userName,
      photoUrl: photoUrl ?? this.photoUrl,
      sexual: sexual ?? this.sexual,
      DOB: DOB ?? this.DOB,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory PatientUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return PatientUser(
      userId: data?['user_id'],
      email: data?['email'],
      userName: data?['user_name'],
      photoUrl: data?['photo_url'],
      sexual: data?['sexual'],
      DOB: data?['DOB'],
      phoneNumber: data?['phone_number'],
      role: data?['role'],
      createdAt: data?['created_at'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (userId != null) 'user_id': userId,
      if (email != null) 'email': email,
      if (userName != null) 'user_name': userName,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (sexual != null) 'sexual': sexual,
      if (DOB != null) 'DOB': DOB,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (role != null) 'role': role,
      'created_at': Timestamp.now(),
    };
  }

  @override
  List<Object?> get props => [userName, photoUrl, sexual, DOB, phoneNumber];
}
