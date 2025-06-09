class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? city;
  String? role;
  String? token;
  String? profileImage;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.city,
    this.role,
    this.token,
    this.profileImage,
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
  }
}
