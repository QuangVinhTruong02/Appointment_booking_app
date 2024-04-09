//doctor
import 'package:booking_doctor/common/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorUser extends UserData {
  final String? workPlace;
  final String? major;
  final List? workExperience;
  final List<WorkProgress>? workProgress;
  DoctorUser({
    String? userId,
    String? email,
    String? userName,
    String? photoUrl,
    String? role,
    this.workPlace,
    this.major,
    this.workExperience,
    this.workProgress,
  }) : super(
          userId: userId,
          email: email,
          photoUrl: photoUrl,
          userName: userName,
          role: role,
        );
  DoctorUser copyWith({
    String? userName,
    String? photoUrl,
    String? workPlace,
    String? major,
    List? workExperience,
    List<WorkProgress>? workProgress,
  }) {
    return DoctorUser(
      userId: userId,
      email: email,
      role: role,
      userName: userName ?? this.userName,
      photoUrl: photoUrl ?? this.photoUrl,
      major: major ?? this.major,
      workExperience: workExperience ?? this.workExperience,
      workPlace: workPlace ?? this.workPlace,
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
      workExperience: data?['work_experience'],
      workPlace: data?['work_place'],
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
      if (workPlace != null) 'work_place': workPlace,
      if (major != null) 'major': major,
      if (workExperience != null) 'work_experience': workExperience,
      if (workProgress != null)
        'work_progress': workProgress?.map((e) => e.toJson()),
    };
  }

  @override
  List<Object?> get props =>
      [userName, photoUrl, workPlace, major, workExperience, workProgress];
}

class WorkProgress {
  final String? fromYear;
  final String? toYear;
  final String? workAt;
  WorkProgress({this.fromYear, this.toYear, this.workAt});

  factory WorkProgress.fromJson(Map<String, dynamic> json) {
    return WorkProgress(
      fromYear: json['from_year'],
      toYear: json['to_year'],
      workAt: json['work_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from_year': fromYear,
      'to_year': toYear,
      'work_at': workAt,
    };
  }
}
