import 'package:cloud_firestore/cloud_firestore.dart';

class HealthRecord {
  final String? healthRecordId;
  final String? patientId;
  final String? userName;
  final String? DOB;
  final String? phoneNumber;
  final String? gender;
  final String? address;
  final String? IDCard;
  final Timestamp? createdAt;
  HealthRecord({
    required this.healthRecordId,
    required this.patientId,
    required this.userName,
    required this.DOB,
    required this.phoneNumber,
    required this.gender,
    required this.address,
    this.IDCard,
    this.createdAt,
  });

  HealthRecord copyWith({
    String? healthRecordId,
    String? patientId,
    String? userName,
    String? DOB,
    String? phoneNumber,
    String? gender,
    String? address,
  }) {
    return HealthRecord(
      healthRecordId: healthRecordId ?? this.healthRecordId,
      patientId: patientId ?? this.patientId,
      userName: userName ?? this.userName,
      DOB: DOB ?? this.DOB,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      address: address ?? this.address,
    );
  }

  factory HealthRecord.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> json, SnapshotOptions? options) {
    final data = json.data();
    return HealthRecord(
      healthRecordId: data?['health_record_id'] as String,
      patientId: data?['patient_id'] as String,
      userName: data?['user_name'] as String,
      DOB: data?['DOB'] as String,
      phoneNumber: data?['phone_number'] as String,
      gender: data?['gender'] as String,
      address: data?['address'] as String,
      createdAt: data?['created_at'] as Timestamp,
      IDCard: data?['ID_card'],
    );
  }

  Map<String, dynamic> toFiresotre() {
    return {
      'health_record_id': healthRecordId,
      'patient_id': patientId,
      'user_name': userName,
      'DOB': DOB,
      'phone_number': phoneNumber,
      'gender': gender,
      'address': address,
      'created_at': createdAt,
      'ID_card': IDCard,
    };
  }
}
