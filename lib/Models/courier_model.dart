class CourierModel{

  String id;
  String name;
  String email;
  String urlProfile;

  CourierModel({required this.id, required this.name, required this.email, required this.urlProfile});

  CourierModel.fromJson(Map<dynamic, dynamic> json) : // notice Map<dynamic, dynamic> here
        id = json['id'] ?? '',
        name = json['name'] ?? '',
        email = json['email'] ?? '',
        urlProfile = json['urlProfile'] ?? '';

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'urlProfile': urlProfile
  };
}