import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorSchedule {
  final String? doctorScheduleId;
  final String? doctorId;
  final List? daysOfWeek;
  DoctorSchedule({
    this.doctorScheduleId,
    this.doctorId,
    this.daysOfWeek,
  });

  DoctorSchedule copyWith({
    String? day,
    Timestamp? date,
    List? dayofWeek,
  }) {
    return DoctorSchedule(
      doctorScheduleId: doctorScheduleId,
      doctorId: doctorId,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
    );
  }

  factory DoctorSchedule.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> json,
    SnapshotOptions? options,
  ) {
    final data = json.data();
    // List<Calendar> calendars = [];
    // if (data?['calendars'] != null) {
    //   for (var calendar in data?['calendars']) {
    //     calendars.add(Calendar.fromJson(calendar));
    //   }
    // }
    return DoctorSchedule(
      doctorScheduleId: data?['doctor_schedule_id'],
      doctorId: data?['doctor_id'],
      daysOfWeek: data?['days_of_week'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'doctor_id': doctorId,
      'doctor_schedule_id': doctorScheduleId,
      // 'calendars': calendars?.map((e) => e.toJson()).toList(),
      'days_of_week': daysOfWeek,
    };
  }
}

class TimeSlots {
  final String? timeSlotId;
  String? time;
  List<BookingCount>? bookingCounts;
  TimeSlots({
    this.timeSlotId,
    this.time,
    this.bookingCounts,
  });
  factory TimeSlots.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    List<BookingCount> bookingCounts = [];
    if (data?['booking_counts'] != null) {
      for (var workTime in data?['booking_counts']) {
        bookingCounts.add(BookingCount.fromJson(workTime));
      }
    }
    return TimeSlots(
      timeSlotId: data?['time_slot_id'],
      time: data?['time'],
      bookingCounts: bookingCounts,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'time_slot_id': timeSlotId,
      'time': time,
      'booking_counts': bookingCounts?.map((e) => e.toJson()).toList(),
    };
  }
}

class BookingCount {
  String? date;
  int? limit;
  BookingCount({this.date, this.limit});

  factory BookingCount.fromJson(Map<String, dynamic> json) {
    return BookingCount(
      date: json['date'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'limit': limit,
    };
  }
}
