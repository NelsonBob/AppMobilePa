import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/data/env/env.dart';
import 'package:flutter_application_1/data/storage/secure_storage.dart';
import 'package:flutter_application_1/domain/models/response/response_notifications.dart';

class NotificationsServices {
  Future<List<Notificationsdb>> getNotificationsByUser() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/notification/getNotificationsByUser'),
        headers: {'Accept': 'application/json', 'Authorization': token!});

    return ResponseNotifications.fromJson(jsonDecode(resp.body))
        .notificationsdb;
  }
}

final notificationServices = NotificationsServices();
