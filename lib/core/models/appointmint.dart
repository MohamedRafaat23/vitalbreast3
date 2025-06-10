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
        json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    timeSlot = json['time_slot'] != null
        ? TimeSlot.fromJson(json['time_slot'])
        : null;
    status = json['status'];
    city = json['city'];
    desc = json['desc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    if (timeSlot != null) {
      data['time_slot'] = timeSlot!.toJson();
    }
    data['status'] = status;
    data['city'] = city;
    data['desc'] = desc;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
        clinics!.add(Clinics.fromJson(v));
      });
    }
    rating = json['rating'];
    patientCount = json['patient_count'];
    isAvailable = json['is_available'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['doctor'] = doctor;
    data['city'] = city;
    data['contact_phone'] = contactPhone;
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
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user'] = user;
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
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}
