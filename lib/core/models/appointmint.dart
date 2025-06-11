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

  Appointment(
      {this.id,
      this.doctor,
      this.patient,
      this.timeSlot,
      this.status,
      this.city,
      this.desc,
      this.createdAt,
      this.updatedAt});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    timeSlot = json['time_slot'] != null
        ? new TimeSlot.fromJson(json['time_slot'])
        : null;
    status = json['status'];
    city = json['city'];
    desc = json['desc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.timeSlot != null) {
      data['time_slot'] = this.timeSlot!.toJson();
    }
    data['status'] = this.status;
    data['city'] = this.city;
    data['desc'] = this.desc;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Doctor {
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

  Doctor(
      {this.id,
      this.user,
      this.experienceYears,
      this.timeSlots,
      this.reviewsCount,
      this.clinics,
      this.rating,
      this.patientCount,
      this.isAvailable,
      this.city});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    experienceYears = json['experience_years'];
    timeSlots = json['time_slots'];
    reviewsCount = json['reviews_count'];
    if (json['clinics'] != null) {
      clinics = <Clinics>[];
      json['clinics'].forEach((v) {
        clinics!.add(new Clinics.fromJson(v));
      });
    }
    rating = json['rating'];
    patientCount = json['patient_count'];
    isAvailable = json['is_available'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['experience_years'] = this.experienceYears;
    data['time_slots'] = this.timeSlots;
    data['reviews_count'] = this.reviewsCount;
    if (this.clinics != null) {
      data['clinics'] = this.clinics!.map((v) => v.toJson()).toList();
    }
    data['rating'] = this.rating;
    data['patient_count'] = this.patientCount;
    data['is_available'] = this.isAvailable;
    data['city'] = this.city;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor'] = this.doctor;
    data['city'] = this.city;
    data['contact_phone'] = this.contactPhone;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}
