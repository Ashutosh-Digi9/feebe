import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class CreateAccountCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? displayName = '',
    int? userRole,
    String? phoneNumber = '',
    String? password = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "${email}",
  "password": "${password}",
  "displayName": "${displayName}",
  "user_role": ${userRole},
  "phone_number": "${phoneNumber}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Create Account',
      apiUrl: 'feebecreate-account.vercel.app/createUser',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? userref(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.userRef''',
      ));
}

class SendMailCall {
  static Future<ApiCallResponse> call({
    String? toEmail = '',
    String? userName = '',
    String? password = '',
    String? message = '',
  }) async {
    final ffApiRequestBody = '''
{
  "toEmail": "${escapeStringForJson(toEmail)}",
  "userName": "${escapeStringForJson(userName)}",
  "password": "${escapeStringForJson(password)}",
  "message": "${escapeStringForJson(message)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Send Mail ',
      apiUrl: 'https://feebecreate-account.vercel.app/send-email',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteAccountSendMailCall {
  static Future<ApiCallResponse> call({
    String? parentName = '',
    String? parentDescription = '',
    String? schoolName = '',
    String? staffName = '',
    String? staffDescription = '',
    String? toEmailParent = '',
    String? toEmailStaff = '',
  }) async {
    final ffApiRequestBody = '''
{
  "parentName": "${escapeStringForJson(parentName)}",
  "parentDescription": "${escapeStringForJson(parentDescription)}",
  "schoolName": "${escapeStringForJson(schoolName)}",
  "staffName": "${escapeStringForJson(staffName)}",
  "staffDescription": "${escapeStringForJson(staffDescription)}",
  "toEmailParent": "${escapeStringForJson(toEmailParent)}",
  "toEmailStaff": "${escapeStringForJson(toEmailStaff)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Delete account Send Mail ',
      apiUrl:
          'https://feebecreate-account.vercel.app/send-email/accountRemoved',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetcityandstateCall {
  static Future<ApiCallResponse> call({
    String? postalcode = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getcityandstate',
      apiUrl: 'https://api.postalpincode.in/pincode/${postalcode}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? state(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].PostOffice[0].State''',
      ));
  static String? placeName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].PostOffice[0].Name''',
      ));
  static String? city(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].PostOffice[0].Block''',
      ));
}

class DeleteUserCall {
  static Future<ApiCallResponse> call({
    String? uid = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'deleteUser',
      apiUrl: 'feebecreate-account.vercel.app/deleteUser/${uid}',
      callType: ApiCallType.DELETE,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CheckCrediantialsCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "${escapeStringForJson(email)}",
  "password": "${escapeStringForJson(password)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CheckCrediantials',
      apiUrl: 'feebecreate-account.vercel.app/login',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

class SearchSchoolCall {
  static Future<ApiCallResponse> call({
    String? schoolName = '',
    String? adminName = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'SearchSchool',
      apiUrl: 'feebecreate-account.vercel.app/search',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'school_name': schoolName,
        'admin_name': adminName,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

class ApppversionCall {
  static Future<ApiCallResponse> call({
    String? appId = '',
    String? platform = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'apppversion',
      apiUrl: 'https://get-appversion.vercel.app/app-version',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'appId': appId,
        'platform': platform,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? version(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.version''',
      ));
}

class DeleteParentCall {
  static Future<ApiCallResponse> call({
    String? name = '',
    String? description = '',
    String? schoolName = '',
    String? toEmail = '',
  }) async {
    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "Description": "${escapeStringForJson(description)}",
  "schoolName": "${escapeStringForJson(schoolName)}",
  "toEmail": "${escapeStringForJson(toEmail)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'DeleteParent',
      apiUrl:
          'https://feebecreate-account.vercel.app/send-email/accountRemovedParent',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeletestaffCall {
  static Future<ApiCallResponse> call({
    String? name = '',
    String? description = '',
    String? schoolName = '',
    String? toEmail = '',
  }) async {
    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "Description": "${escapeStringForJson(description)}",
  "schoolName": "${escapeStringForJson(schoolName)}",
  "toEmail": "${escapeStringForJson(toEmail)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Deletestaff',
      apiUrl:
          'https://feebecreate-account.vercel.app/send-email/accountRemovedStaff',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SendsmsCall {
  static Future<ApiCallResponse> call({
    int? toPhoneNumber,
    String? userName = '',
    String? userPassword = '',
  }) async {
    final ffApiRequestBody = '''
{
  "toPhoneNumber": ${toPhoneNumber},
  "userName": "${escapeStringForJson(userName)}",
  "userPassword": "${escapeStringForJson(userPassword)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'sendsms',
      apiUrl: 'https://feebecreate-account.vercel.app/send-sms',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SendsmsteacherCall {
  static Future<ApiCallResponse> call({
    int? toPhoneNumber,
    String? userName = '',
    String? userPassword = '',
  }) async {
    final ffApiRequestBody = '''
{
  "toPhoneNumber": "${toPhoneNumber}",
  "userName": "${escapeStringForJson(userName)}",
  "userPassword": "${escapeStringForJson(userPassword)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'sendsmsteacher',
      apiUrl:
          'https://feebecreate-account.vercel.app/send-sms/teacher-onboarding',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class AdminsmsCall {
  static Future<ApiCallResponse> call({
    int? toPhoneNumber,
    String? userName = '',
    String? userPassword = '',
  }) async {
    final ffApiRequestBody = '''
{
  "toPhoneNumber": "${toPhoneNumber}",
  "userName": "${escapeStringForJson(userName)}",
  "userPassword": "${escapeStringForJson(userPassword)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'adminsms',
      apiUrl:
          'https://feebecreate-account.vercel.app/send-sms/admin-onboarding',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class SmsschoolCall {
  static Future<ApiCallResponse> call({
    int? toPhoneNumber,
    String? userName = '',
    String? userPassword = '',
  }) async {
    final ffApiRequestBody = '''
{
  "toPhoneNumber": "${toPhoneNumber}",
  "userName": "${escapeStringForJson(userName)}",
  "userPassword": "${escapeStringForJson(userPassword)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'smsschool',
      apiUrl:
          'https://feebecreate-account.vercel.app/send-sms/Preschool-onboarding-message',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class RemoveParentCall {
  static Future<ApiCallResponse> call({
    int? toPhoneNumber,
  }) async {
    final ffApiRequestBody = '''
{
  "toPhoneNumber": "${toPhoneNumber}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'remove parent',
      apiUrl: 'https://feebecreate-account.vercel.app/send-sms/removing-parent',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class RemoveSchoolCall {
  static Future<ApiCallResponse> call({
    int? toPhoneNumber,
  }) async {
    final ffApiRequestBody = '''
{
  "toPhoneNumber": "${toPhoneNumber}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'remove school',
      apiUrl:
          'https://feebecreate-account.vercel.app/send-sms/removing-preschool',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class RemoveTeacherCall {
  static Future<ApiCallResponse> call({
    int? toPhoneNumber,
  }) async {
    final ffApiRequestBody = '''
{
  "toPhoneNumber": "${toPhoneNumber}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'remove teacher',
      apiUrl:
          'https://feebecreate-account.vercel.app/send-sms/removing-teacher',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class RemoveAdminCall {
  static Future<ApiCallResponse> call({
    int? toPhoneNumber,
  }) async {
    final ffApiRequestBody = '''
{
  "toPhoneNumber": "${toPhoneNumber}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'remove admin',
      apiUrl: 'https://feebecreate-account.vercel.app/send-sms/removing-admin',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class ForgotpasswordCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? toPhoneNumber = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'forgotpassword',
      apiUrl: 'https://feebecreate-account.vercel.app/send-sms/forgot-password',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
