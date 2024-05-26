//doctor
import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorUser extends UserData {
  final String? hospitalId;
  String? hospitalAddress;
  String? hospitalName;
  final String? major;
  final List<WorkProgress>? workProgress;
  DoctorUser({
    String? userId,
    String? email,
    String? userName,
    String? photoUrl,
    String? role,
    String? password,
    Timestamp? createdAt,
    this.hospitalId,
    this.hospitalName,
    this.hospitalAddress,
    this.major,
    this.workProgress,
  }) : super(
          userId: userId,
          email: email,
          photoUrl: photoUrl,
          userName: userName,
          role: role,
          createdAt: createdAt,
        );
  DoctorUser copyWith({
    String? userName,
    String? photoUrl,
    String? major,
    List<WorkProgress>? workProgress,
    String? hospitalId,
    String? hospitalName,
    String? hospitalAddress,
  }) {
    return DoctorUser(
      userId: userId,
      email: email,
      role: role,
      createdAt: createdAt,
      userName: userName ?? this.userName,
      photoUrl: photoUrl ?? this.photoUrl,
      major: major ?? this.major,
      hospitalId: hospitalId ?? this.hospitalId,
      hospitalName: hospitalName ?? this.hospitalName,
      hospitalAddress: hospitalAddress ?? this.hospitalAddress,
      workProgress: workProgress ?? this.workProgress,
    );
  }

  factory DoctorUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    List<WorkProgress>? workProgressList;
    if (data?['work_progress'] != null) {
      workProgressList = [];
      for (var workProgressData in data?['work_progress']) {
        workProgressList.add(WorkProgress.fromJson(workProgressData));
      }
    }

    return DoctorUser(
      userId: data?['user_id'],
      email: data?['email'],
      userName: data?['user_name'],
      photoUrl: data?['photo_url'],
      role: data?['role'],
      major: data?['major'],
      hospitalId: data?['hospital_id'],
      password: data?['password'],
      createdAt: data?['created_at'],
      workProgress: workProgressList,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (userId != null) 'user_id': userId,
      if (email != null) 'email': email,
      if (userName != null) 'user_name': userName,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (role != null) 'role': role,
      if (hospitalId != null) 'hospital_id': hospitalId,
      if (major != null) 'major': major,
      if (workProgress != null)
        'work_progress': workProgress?.map((e) => e.toJson()),
      'created_at': Timestamp.now(),
    };
  }

  @override
  List<Object?> get props =>
      [userName, photoUrl, hospitalName, major, workProgress];
}

class WorkProgress {
  final String? yearOfWork;
  final String? workAt;
  WorkProgress({this.yearOfWork, this.workAt});

  factory WorkProgress.fromJson(Map<String, dynamic> json) {
    return WorkProgress(
      yearOfWork: json['year_of_work'],
      workAt: json['work_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year_of_work': yearOfWork,
      'work_at': workAt,
    };
  }
}
