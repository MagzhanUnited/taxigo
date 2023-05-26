import 'dart:convert';

RegisterData registerDataFromJson(String str) =>
    RegisterData.fromJson(json.decode(str));

String registerDataToJson(RegisterData data) => json.encode(data.toJson());

class RegisterData {
  String message;
  String token;
  String username;
  String? status;

  RegisterData(
      {required this.message,
      required this.token,
      required this.username,
       this.status});

  factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
      message: json["message"],
      token: json["token"],
      username: json["username"],
      status: json["status"]);

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "username": username,
        "status": status
      };
}
