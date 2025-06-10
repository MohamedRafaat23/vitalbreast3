class DoctorsModel {
  String? id;
  User? user;
  int? experienceYears;
  List<TimeSlot>? timeSlots;
  String? reviewsCount;
  List<Clinics>? clinics;
  String? rating;
  String? patientCount;
  bool? isAvailable;
  String? city;
  int? salary;

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
    this.salary,
  });

  DoctorsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    experienceYears = json['experience_years'];
    if (json['time_slots'] != null) {
      timeSlots = <TimeSlot>[];
      json['time_slots'].forEach((v) {
        timeSlots!.add(TimeSlot.fromJson(v));
      });
    }
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
    salary = json['salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['experience_years'] = experienceYears;
    if (timeSlots != null) {
      data['time_slots'] = timeSlots!.map((v) => v.toJson()).toList();
    }
    data['reviews_count'] = reviewsCount;
    if (clinics != null) {
      data['clinics'] = clinics!.map((v) => v.toJson()).toList();
    }
    data['rating'] = rating;
    data['patient_count'] = patientCount;
    data['is_available'] = isAvailable;
    data['city'] = city;
    data['salary'] = salary;
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? phone;

  User({this.name, this.email, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
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
