import 'dart:convert';

ResponseLike responseCommentsFromJson(String str) =>
    ResponseLike.fromJson(json.decode(str));

String responseLikeToJson(ResponseLike data) => json.encode(data.toJson());

class ResponseLike {
  IsLike? isLike;

  ResponseLike({this.isLike});

  ResponseLike.fromJson(Map<String, dynamic> json) {
    isLike =
        json['isLike'] != null ? new IsLike.fromJson(json['isLike']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.isLike != null) {
      data['isLike'] = this.isLike!.toJson();
    }
    return data;
  }
}

class IsLike {
  int? uidLikes;

  IsLike({this.uidLikes});

  IsLike.fromJson(Map<String, dynamic> json) {
    uidLikes = json['uid_likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid_likes'] = uidLikes;
    return data;
  }
}
