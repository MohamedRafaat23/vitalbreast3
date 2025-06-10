class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? city;
  String? role;
  String? token;
  String? profileImage;
  String? gender;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.city,
    this.role,
    this.token,
    this.profileImage,
    this.gender,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    token = json['auth_token'];
    role = json['role'];
    profileImage = json['profile_img'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['city'] = city;
    data['auth_token'] = token;
    data['role'] = role;
    data['profile_img'] = profileImage;
    data['gender'] = gender;
    return data;
  }
}
