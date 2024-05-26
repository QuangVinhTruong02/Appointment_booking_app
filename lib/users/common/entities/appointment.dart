import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String? appointmentId;
  final Timestamp? appointmentTime;
  final int? price;
  final String? doctorId;
  final String? timeSlotId;
  final String? patientId;
  String? patientName;
  String? healthRecordId;
  final String? symptoms;
  String? appointmentStatus;
  final String? hospitalId;
  final String? major;
  String? hospitalName;
  String? hospitalAddress;
  Appointment({
    required this.appointmentId,
    required this.appointmentTime,
    required this.price,
    required this.timeSlotId,
    required this.doctorId,
    required this.patientId,
    required this.hospitalId,
    required this.symptoms,
    required this.appointmentStatus,
    required this.major,
    required this.healthRecordId,
    this.patientName,
    this.hospitalName,
    this.hospitalAddress,
  });

  factory Appointment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> json,
    SnapshotOptions? options,
  ) {
    final data = json.data();
    return Appointment(
      appointmentId: data?['appointment_id'],
      appointmentTime: data?['appointment_time'],
      timeSlotId: data?['time_slot_id'],
      price: data?['price'],
      doctorId: data?['doctor_id'],
      patientId: data?['patient_id'],
      hospitalId: data?['hospital_id'],
      major: data?['major'],
      symptoms: data?['symptoms'],
      appointmentStatus: data?['appointment_status'],
      healthRecordId: data?['health_record_id'],
    );
  }
  Map<String, dynamic> toFirestore() => {
        'appointment_id': appointmentId,
        'price': price,
        'doctor_id': doctorId,
        'patient_id': patientId,
        'symptoms': symptoms,
        'major': major,
        'time_slot_id': timeSlotId,
        'appointment_status': appointmentStatus,
        'hospital_id': hospitalId,
        'appointment_time': appointmentTime,
        'health_record_id': healthRecordId,
        'created_at': Timestamp.now(),
      };
}
