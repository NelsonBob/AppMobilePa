import 'dart:convert';

DefaultResponse defaultResponseFromJson(String str) =>
    DefaultResponse.fromJson(json.decode(str));

String defaultResponseToJson(DefaultResponse data) =>
    json.encode(data.toJson());

class DefaultResponse {
  String message;

  DefaultResponse({
    required this.message,
  });

  factory DefaultResponse.fromJson(Map<String, dynamic> json) =>
      DefaultResponse(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
