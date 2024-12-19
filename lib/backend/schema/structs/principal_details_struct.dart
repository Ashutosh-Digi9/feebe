// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class PrincipalDetailsStruct extends FFFirebaseStruct {
  PrincipalDetailsStruct({
    DocumentReference? principalId,
    String? principalName,
    String? phoneNumber,
    String? emailId,
    String? principalImage,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _principalId = principalId,
        _principalName = principalName,
        _phoneNumber = phoneNumber,
        _emailId = emailId,
        _principalImage = principalImage,
        super(firestoreUtilData);

  // "principal_id" field.
  DocumentReference? _principalId;
  DocumentReference? get principalId => _principalId;
  set principalId(DocumentReference? val) => _principalId = val;

  bool hasPrincipalId() => _principalId != null;

  // "principal_name" field.
  String? _principalName;
  String get principalName => _principalName ?? '';
  set principalName(String? val) => _principalName = val;

  bool hasPrincipalName() => _principalName != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  set phoneNumber(String? val) => _phoneNumber = val;

  bool hasPhoneNumber() => _phoneNumber != null;

  // "email_id" field.
  String? _emailId;
  String get emailId => _emailId ?? '';
  set emailId(String? val) => _emailId = val;

  bool hasEmailId() => _emailId != null;

  // "principal_image" field.
  String? _principalImage;
  String get principalImage => _principalImage ?? '';
  set principalImage(String? val) => _principalImage = val;

  bool hasPrincipalImage() => _principalImage != null;

  static PrincipalDetailsStruct fromMap(Map<String, dynamic> data) =>
      PrincipalDetailsStruct(
        principalId: data['principal_id'] as DocumentReference?,
        principalName: data['principal_name'] as String?,
        phoneNumber: data['phone_number'] as String?,
        emailId: data['email_id'] as String?,
        principalImage: data['principal_image'] as String?,
      );

  static PrincipalDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? PrincipalDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'principal_id': _principalId,
        'principal_name': _principalName,
        'phone_number': _phoneNumber,
        'email_id': _emailId,
        'principal_image': _principalImage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'principal_id': serializeParam(
          _principalId,
          ParamType.DocumentReference,
        ),
        'principal_name': serializeParam(
          _principalName,
          ParamType.String,
        ),
        'phone_number': serializeParam(
          _phoneNumber,
          ParamType.String,
        ),
        'email_id': serializeParam(
          _emailId,
          ParamType.String,
        ),
        'principal_image': serializeParam(
          _principalImage,
          ParamType.String,
        ),
      }.withoutNulls;

  static PrincipalDetailsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PrincipalDetailsStruct(
        principalId: deserializeParam(
          data['principal_id'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Users'],
        ),
        principalName: deserializeParam(
          data['principal_name'],
          ParamType.String,
          false,
        ),
        phoneNumber: deserializeParam(
          data['phone_number'],
          ParamType.String,
          false,
        ),
        emailId: deserializeParam(
          data['email_id'],
          ParamType.String,
          false,
        ),
        principalImage: deserializeParam(
          data['principal_image'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PrincipalDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PrincipalDetailsStruct &&
        principalId == other.principalId &&
        principalName == other.principalName &&
        phoneNumber == other.phoneNumber &&
        emailId == other.emailId &&
        principalImage == other.principalImage;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([principalId, principalName, phoneNumber, emailId, principalImage]);
}

PrincipalDetailsStruct createPrincipalDetailsStruct({
  DocumentReference? principalId,
  String? principalName,
  String? phoneNumber,
  String? emailId,
  String? principalImage,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PrincipalDetailsStruct(
      principalId: principalId,
      principalName: principalName,
      phoneNumber: phoneNumber,
      emailId: emailId,
      principalImage: principalImage,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PrincipalDetailsStruct? updatePrincipalDetailsStruct(
  PrincipalDetailsStruct? principalDetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    principalDetails
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPrincipalDetailsStructData(
  Map<String, dynamic> firestoreData,
  PrincipalDetailsStruct? principalDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (principalDetails == null) {
    return;
  }
  if (principalDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && principalDetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final principalDetailsData =
      getPrincipalDetailsFirestoreData(principalDetails, forFieldValue);
  final nestedData =
      principalDetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = principalDetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPrincipalDetailsFirestoreData(
  PrincipalDetailsStruct? principalDetails, [
  bool forFieldValue = false,
]) {
  if (principalDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(principalDetails.toMap());

  // Add any Firestore field values
  principalDetails.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPrincipalDetailsListFirestoreData(
  List<PrincipalDetailsStruct>? principalDetailss,
) =>
    principalDetailss
        ?.map((e) => getPrincipalDetailsFirestoreData(e, true))
        .toList() ??
    [];
