import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/data/env/env.dart';
import 'package:flutter_application_1/data/storage/secure_storage.dart';
import 'package:flutter_application_1/domain/models/response/default_response.dart';
import 'package:flutter_application_1/domain/models/response/response_comments.dart';
import 'package:flutter_application_1/domain/models/response/response_post.dart';
import 'package:flutter_application_1/domain/models/response/response_post_by_user.dart';
import 'package:flutter_application_1/domain/models/response/response_post_profile.dart';
import 'package:flutter_application_1/domain/models/response/response_post_saved.dart';

class PostServices {
  Future<DefaultResponse> addNewPost(
      String comment, String typePrivacy, List<File> images) async {
    final token = await secureStorage.readToken();

    var request = http.MultipartRequest(
        'POST', Uri.parse('${Environment.urlApi}/post/createNewPost'))
      ..headers['Accept'] = 'application/json'
      ..headers['Authorization'] = token!
      ..fields['comment'] = comment
      ..fields['type_privacy'] = typePrivacy;
    for (var image in images) {
      request.files
          .add(await http.MultipartFile.fromPath('imagePosts', image.path));
    }

    final response = await request.send();
    var data = await http.Response.fromStream(response);

    return DefaultResponse.fromJson(jsonDecode(data.body));
  }

  Future<List<Post>> getAllPostHome() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/post/getAllPosts'),
        headers: {'Accept': 'application/json'});

    return ResponsePost.fromJson(jsonDecode(resp.body)).posts;
  }

  Future<List<PostProfile>> getPostProfiles() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/post/getPostByIdPerson'),
        headers: {'Accept': 'application/json', 'Authorization': token!});

    return ResponsePostProfile.fromJson(jsonDecode(resp.body)).post;
  }

  Future<DefaultResponse> savePostByUser(String uidPost) async {
    final token = await secureStorage.readToken();

    final resp = await http.post(
        Uri.parse('${Environment.urlApi}/post/savePostByUser'),
        headers: {'Accept': 'application/json', 'Authorization': token!},
        body: {'post_uid': uidPost});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<List<ListSavedPost>> getListPostSavedByUser() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/post/getListSavedPostsByUser'),
        headers: {'Accept': 'application/json', 'Authorization': token!});

    return ResponsePostSaved.fromJson(jsonDecode(resp.body)).listSavedPost;
  }

  Future<List<Post>> getAllPostsForSearch() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/post/getAllPostsForSearch'),
        headers: {'Accept': 'application/json', 'Authorization': token!});

    return ResponsePost.fromJson(jsonDecode(resp.body)).posts;
  }

  Future<DefaultResponse> likeOrUnlikePost(
      String uidPost, String uidPerson) async {
    final token = await secureStorage.readToken();

    final resp = await http.post(
        Uri.parse('${Environment.urlApi}/post/likeOrUnLikePost'),
        headers: {'Accept': 'application/json', 'Authorization': token!},
        body: {'uidPost': uidPost, 'uidPerson': uidPerson});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<List<Comment>> getCommentsByUidPost(String uidPost) async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
      Uri.parse('${Environment.urlApi}/post/getCommentByIdPost/$uidPost'),
      headers: {'Accept': 'application/json', 'Authorization': token!},
    );

    return ResponseComments.fromJson(jsonDecode(resp.body)).comments;
  }

  Future<DefaultResponse> addNewComment(String uidPost, String comment) async {
    final token = await secureStorage.readToken();

    final resp = await http.post(
        Uri.parse('${Environment.urlApi}/post/addNewComment'),
        headers: {'Accept': 'application/json', 'Authorization': token!},
        body: {'uidPost': uidPost, 'comment': comment});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<DefaultResponse> likeOrUnlikeComment(String uidComment) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
        Uri.parse('${Environment.urlApi}/post/likeOrUnLikeComment'),
        headers: {'Accept': 'application/json', 'Authorization': token!},
        body: {'uidComment': uidComment});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<List<PostUser>> listPostByUser() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/post/getAllPostByUserID'),
        headers: {'Accept': 'application/json', 'Authorization': token!});

    return ResponsePostByUser.fromJson(jsonDecode(resp.body)).postUser;
  }

  Future<String> ProgramationService(
      String nomLanguage, String uidPost, String uidPerson) async {
    final resp = await http.get(
        Uri.parse(
            'https://outofmemoryerror-code-executer-container.azurewebsites.net/$nomLanguage/$uidPost/$uidPerson'),
        headers: {'Accept': 'application/json'});

    String str = jsonDecode(resp.body);
    return str;
  }

  String createExecutorMessage(
      String nomLanguage, String uidPost, String uidPerson) {
    var order = ProgramationService(nomLanguage, uidPost, uidPerson);
    return order.toString();
  }
}

final postService = PostServices();
