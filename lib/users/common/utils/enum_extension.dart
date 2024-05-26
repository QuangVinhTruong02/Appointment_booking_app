enum Role { Patient, Doctor, Admin }

extension RoleExtension on Role {
  String get displayRole {
    switch (this) {
      case Role.Patient:
        return 'Patient';
      case Role.Doctor:
        return 'Doctor';
      case Role.Admin:
        return 'Admin';
    }
  }
}

enum AppointmentStatus { Completed, Canceled, Waiting }

extension AppointmentStatusExtension on AppointmentStatus {
  String get displayStatus {
    switch (this) {
      case AppointmentStatus.Completed:
        return 'Đã khám';
      case AppointmentStatus.Canceled:
        return 'Đã huỷ lịch hẹn';
      case AppointmentStatus.Waiting:
        return 'Chờ khám';
    }
  }
}

enum QuestionStatus { Cancel, Submit }
