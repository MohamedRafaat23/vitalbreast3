// Shared model definitions for the app
class Doctor {
  final String id;
  final String name;
  final String email;
  final String phone;
  final int experienceYears;
  final List<TimeSlot> timeSlots;
  final String reviewsCount;
  final List<Clinic> clinics;
  final String rating;
  final String patientCount;
  final bool isAvailable;

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.experienceYears,
    required this.timeSlots,
    required this.reviewsCount,
    required this.clinics,
    required this.rating,
    required this.patientCount,
    required this.isAvailable,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      phone: json['user']['phone'],
      experienceYears: json['experience_years'],
      timeSlots: (json['time_slots'] as List)
          .map((slot) => TimeSlot.fromJson(slot))
          .toList(),
      reviewsCount: json['reviews_count'],
      clinics: (json['clinics'] as List)
          .map((clinic) => Clinic.fromJson(clinic))
          .toList(),
      rating: json['rating'],
      patientCount: json['patient_count'],
      isAvailable: json['is_available'],
    );
  }
}

class TimeSlot {
  final String id;
  final String date;
  final String startTime;
  final String endTime;

  TimeSlot({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['id'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}

class Clinic {
  final String id;
  final String doctor;
  final String city;
  final String contactPhone;

  Clinic({
    required this.id,
    required this.doctor,
    required this.city,
    required this.contactPhone,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      id: json['id'],
      doctor: json['doctor'],
      city: json['city'],
      contactPhone: json['contact_phone'],
    );
  }
}