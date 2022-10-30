import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) =>
    ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  String message;
  String? token;

  ResponseLogin({
    required this.message,
    this.token,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
      };
}
