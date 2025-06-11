import 'package:vitalbreast3/core/models/all.dart';

class Appointment {
  String? id;
  Doctor? doctor;
  Patient? patient;
  TimeSlot? timeSlot;
  String? status;
  String? city;
  String? desc;
  String? createdAt;
  String? updatedAt;

  Appointment({
    this.id,
    this.doctor,
    this.patient,
    this.timeSlot,
    this.status,
    this.city,
    this.desc,
    this.createdAt,
    this.updatedAt,
  });

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    timeSlot =
        json['time_slot'] != null ? TimeSlot.fromJson(json['time_slot']) : null;
    status = json['status'];
    city = json['city'];
    desc = json['desc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Clinics {
  String? id;
  String? doctor;
  String? city;
  String? contactPhone;

  Clinics({this.id, this.doctor, this.city, this.contactPhone});

  Clinics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctor = json['doctor'];
    city = json['city'];
    contactPhone = json['contact_phone'];
  }
}

class Patient {
  String? id;
  String? user;

  Patient({this.id, this.user});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
  }
}

class TimeSlot {
  String? id;
  String? date;
  String? startTime;
  String? endTime;

  TimeSlot({this.id, this.date, this.startTime, this.endTime});

  TimeSlot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }
}
