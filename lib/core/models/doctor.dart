class DoctorsModel {
  String? id;
  String? user;
  int? experienceYears;
  String? timeSlots;
  String? reviewsCount;
  List<Clinics>? clinics;
  String? rating;
  String? patientCount;
  bool? isAvailable;
  String? city;

  DoctorsModel({
    this.id,
    this.user,
    this.experienceYears,
    this.timeSlots,
    this.reviewsCount,
    this.clinics,
    this.rating,
    this.patientCount,
    this.isAvailable,
    this.city,
  });

  DoctorsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    experienceYears = json['experience_years'];
    timeSlots = json['time_slots'];
    reviewsCount = json['reviews_count'];
    if (json['clinics'] != null) {
      clinics = <Clinics>[];
      json['clinics'].forEach((v) {
        clinics!.add(Clinics.fromJson(v));
      });
    }
    rating = json['rating'];
    patientCount = json['patient_count'];
    isAvailable = json['is_available'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['experience_years'] = experienceYears;
    data['time_slots'] = timeSlots;
    data['reviews_count'] = reviewsCount;
    if (clinics != null) {
      data['clinics'] = clinics!.map((v) => v.toJson()).toList();
    }
    data['rating'] = rating;
    data['patient_count'] = patientCount;
    data['is_available'] = isAvailable;
    data['city'] = city;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doctor'] = doctor;
    data['city'] = city;
    data['contact_phone'] = contactPhone;
    return data;
  }
}
