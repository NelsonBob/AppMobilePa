// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/domain/models/response/response_login.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    return isCacheKeyExist;
  }

  // ignore: body_might_complete_normally_nullable
  static Future<ResponseLogin?> loginDetails() async {
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    if (isCacheKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_details");

      return responseLoginFromJson(cacheData.syncData);
    }
  }

  static Future<void> setLoginDetails(
    ResponseLogin responseLogin,
  ) async {
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "login_details",
      syncData: jsonEncode(responseLogin.toJson()),
    );

    await APICacheManager().addCacheData(cacheModel);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("login_details");
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }
}
