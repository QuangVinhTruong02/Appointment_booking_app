import 'package:cloud_firestore/cloud_firestore.dart';

class Hospital {
  final String hospitalId;
  final String? hospitalImg;
  final String hospitalName;
  final String hospitalAddress;
  final List<WorkingDay> workingDays;
  final Timestamp? createdAt;

  Hospital({
    required this.hospitalId,
    this.hospitalImg,
    required this.hospitalName,
    required this.hospitalAddress,
    required this.workingDays,
    this.createdAt,
  });

  factory Hospital.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    List<WorkingDay> workingDayList = [];
    final data = snapshot.data();
    if (data?['working_days'] != null) {
      for (var workingDayData in data?['working_days']) {
        workingDayList.add(
          WorkingDay.fromJson(workingDayData),
        );
      }
    }
    return Hospital(
      hospitalId: data?['hospital_id'],
      hospitalImg: data?['hospital_img'],
      hospitalName: data?['hospital_name'],
      hospitalAddress: data?['hospital_address'],
      workingDays: workingDayList,
      createdAt: data?['created_at'],
    );
  }
  Map<String, dynamic> toFirestore() => {
        'hospital_id': hospitalId,
        'hospital_name': hospitalName,
        'hospital_img': hospitalImg,
        'hospital_address': hospitalAddress,
        'working_days': workingDays.map((e) => e.toJson()),
        'created_at': createdAt,
      };
}

class WorkingDay {
  final String day;
  final String startTime;
  final String endTime;
  WorkingDay({
    required this.startTime,
    required this.endTime,
    required this.day,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) => WorkingDay(
        startTime: json['start_time'],
        endTime: json['end_time'],
        day: json['day'],
      );

  Map<String, String> toJson() => {
        'day': day,
        'start_time': startTime,
        'end_time': endTime,
      };
}
