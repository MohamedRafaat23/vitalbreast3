class User{
  String? id;
  String? name;
  String? email;
  String? phone;
  String? city;
  String? role;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.city,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    role = json['role'];
  }
}