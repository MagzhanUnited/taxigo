import 'dart:convert';

PersonModule personModuleFromJson(String str) =>
    PersonModule.fromJson(json.decode(str));

String personModuleToJson(PersonModule data) => json.encode(data.toJson());

class PersonModule {
  String number;
  String password;
  String? username;

  PersonModule({required this.number, required this.password, this.username});

  factory PersonModule.fromJson(Map<String, dynamic> json) => PersonModule(
      number: json["number"],
      password: json["password"],
      username: json["username"]);

  Map<String, dynamic> toJson() =>
      {"number": number, "password": password, "username": username};
}
