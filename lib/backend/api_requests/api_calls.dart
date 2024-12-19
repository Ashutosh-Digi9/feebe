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
  "email": "$email",
  "password": "$password",
  "displayName": "$displayName",
  "user_role": $userRole,
  "phone_number": "$phoneNumber"
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
  }) async {
    final ffApiRequestBody = '''
{
  "toEmail": "${escapeStringForJson(toEmail)}",
  "userName": "${escapeStringForJson(userName)}",
  "password": "${escapeStringForJson(password)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Send Mail ',
      apiUrl: 'https://feebe-nodemailer.vercel.app/send-email',
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
      apiUrl: 'https://api.postalpincode.in/pincode/$postalcode',
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
      apiUrl: 'feebecreate-account.vercel.app/deleteUser/$uid',
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
