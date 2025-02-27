import 'dart:convert';
import 'dart:io';

import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/repositories/company_repository.dart';
import 'package:auspower_flutter/services/route/navigation.dart';
import 'package:auspower_flutter/services/storage/storage_constants.dart';
import 'package:auspower_flutter/view/homescreen/screen/company_screen.dart';
import 'package:auspower_flutter/view/homescreen/screen/plant_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auspower_flutter/models/auth_user.dart';
import 'package:auspower_flutter/models/response.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/services/api/api_services.dart';
import 'package:auspower_flutter/utilities/extensions/response_extension.dart';
import 'package:auspower_flutter/utilities/message.dart';

class AuthRepository {
  ///Prefix Url for the Authentication.
  final String _prefixUrl = '';

  ///Declare the [APIService] as [_api] with the [_prefixUrl] for the Authentication.
  APIService get _api => APIService(prefixUrl: _prefixUrl);

  Future<bool> login(BuildContext context, Map<String, dynamic> params) async {
    authProvider.isLoading = true;
    logger.e(params);
    ResponseData responseData =
        await _api.post(context, 'login/', body: params);
    authProvider.isLoading = false;
    logger.w(responseData.data);
    String message = responseData.data['message'] ?? '';

    showMessage(message);

    if (responseData.hasError) return false;

    saveCreds(context, responseData);
    return true;
  }

  Future<void> supscripeTopic(BuildContext context, String topic) async {
    if (!kIsWeb) {
      if (Platform.isIOS) {
        await FirebaseMessaging.instance.getAPNSToken().then((value) {
          // if (login[0].token != "") {
          FirebaseMessaging.instance.subscribeToTopic(topic);
          logger.i('subscribeToTopic ');
          // }
        });
      }

      if (Platform.isAndroid) {
        await FirebaseMessaging.instance.getToken().then((value) {
          FirebaseMessaging.instance.subscribeToTopic(topic);
        });
      }
    }
  }

  void saveCreds(BuildContext context, ResponseData responseData) {
    AuthUser user = AuthUser.fromJson(responseData.data['data'][0] ?? {});
    storage.write(key: StorageConstants.authCreds, value: jsonEncode(user));
    logger.e(user.notificationTopic);
    supscripeTopic(context, user.notificationTopic);

    authProvider.user = user;
    authProvider.token = responseData.data['access_token'] ?? '';
    logger.w(responseData.data['data'][0]);
    if (authProvider.user?.employeeType == 'Operator' ||
        authProvider.user?.employeeType == 'Plant') {
      Navigation().pushRemoveUntil(
          context,
          PlantScreen(
              campusId: authProvider.user?.campusId.toString() ?? "",
              companyId: authProvider.user?.companyId.toString() ?? "",
              buId: authProvider.user?.buId.toString() ?? ""));
    } else {
      Navigation().pushRemoveUntil(context, const CompanyScreen());
    }
    CompanyRepository()
        .getCompanyList(context, campusId: user.campusId.toString());
  }

  void clearCreds() {
    authProvider.user = null;
    authProvider.token = '';
  }
}
//  logger.e(currentUser.displayName);
//     logger.e(currentUser.email);
//     logger.e(currentUser.emailVerified);
//     logger.e(currentUser.phoneNumber);
//     logger.e(currentUser.photoURL);
//     logger.e(currentUser.providerData.first.displayName);
//     if (currentUser.uid != '')
