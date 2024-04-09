import 'package:equatable/equatable.dart';

enum Role { Patient, Doctor }

extension RoleExtension on Role {
  String get displayRole {
    switch (this) {
      case Role.Patient:
        return 'Patient';
      case Role.Doctor:
        return 'Doctor';
    }
  }
}

class UserData with EquatableMixin {
  final String? userId;
  final String? email;
  final String? userName;
  final String? photoUrl;
  final String? role;
  UserData({
    this.userId,
    this.email,
    this.userName,
    this.photoUrl,
    this.role,
  });

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
  // String? sexual;
  // String? DOB;
  // String? phoneNumber;
  // String? workPlace;
  // String? major;
  // String? workExperience;

  UserLoginResponse({
    this.email,
    this.userId,
    this.photoUrl,
    this.userName,
    this.role,
    // this.sexual,
    // this.DOB,
    // this.phoneNumber,
    // this.workPlace,
    // this.major,
    // this.workExperience,
  });

  // UserLoginResponse.UserLoginPatientResponse({
  //   this.email,
  //   this.userId,
  //   this.photoUrl,
  //   this.userName,
  //   this.role,
  //   this.sexual,
  //   this.DOB,
  //   this.phoneNumber,
  // });

  // UserLoginResponse.UserLoginDoctorResponse({
  //   this.email,
  //   this.userId,
  //   this.photoUrl,
  //   this.userName,
  //   this.role,
  // });

  UserLoginResponse copyWith({
    String? userName,
    String? photoUrl,
    // String? sexual,
    // String? DOB,
    // String? phoneNumber,
  }) {
    return UserLoginResponse(
      userId: userId,
      email: email,
      userName: userName ?? this.userName,
      photoUrl: photoUrl ?? this.photoUrl,
      // sexual: sexual ?? this.sexual,
      // DOB: DOB ?? this.DOB,
      // phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  // UserLoginResponse copyDoctorWith({
  //   String? userName,
  //   String? photoUrl,
  // }) {
  //   return UserLoginResponse.UserLoginDoctorResponse(
  //     userId: userId,
  //     email: email,
  //     userName: userName ?? this.userName,
  //     photoUrl: photoUrl ?? this.photoUrl,
  //     // workPlace: workPlace ?? this.workPlace,
  //     // major: major ?? this.major,
  //     // workExperience: workExperience ?? this.workExperience,
  //   );
  // }

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginResponse(
      email: json['email'],
      userId: json['user_id'],
      photoUrl: json['photo_url'],
      userName: json['user_name'],
      role: json['role'],
      // sexual: json['sexual'],
      // DOB: json['DOB'],
      // phoneNumber: json['phone_number'],
      // major: json['major'],
      // workExperience: json['work_experience'],
      // workPlace: json['work_place'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'user_id': userId,
        'photo_url': photoUrl,
        'user_name': userName,
        'role': role,
        // 'sexual': sexual,
        // 'DOB': DOB,
        // 'phone_number': phoneNumber,
        // 'work_place': workPlace,
        // 'major': major,
        // 'work_experience': workExperience,
      };
}
