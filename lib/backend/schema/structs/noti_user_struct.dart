// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class NotiUserStruct extends FFFirebaseStruct {
  NotiUserStruct({
    DocumentReference? userref,
    bool? isread,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userref = userref,
        _isread = isread,
        super(firestoreUtilData);

  // "userref" field.
  DocumentReference? _userref;
  DocumentReference? get userref => _userref;
  set userref(DocumentReference? val) => _userref = val;

  bool hasUserref() => _userref != null;

  // "isread" field.
  bool? _isread;
  bool get isread => _isread ?? false;
  set isread(bool? val) => _isread = val;

  bool hasIsread() => _isread != null;

  static NotiUserStruct fromMap(Map<String, dynamic> data) => NotiUserStruct(
        userref: data['userref'] as DocumentReference?,
        isread: data['isread'] as bool?,
      );

  static NotiUserStruct? maybeFromMap(dynamic data) =>
      data is Map ? NotiUserStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'userref': _userref,
        'isread': _isread,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userref': serializeParam(
          _userref,
          ParamType.DocumentReference,
        ),
        'isread': serializeParam(
          _isread,
          ParamType.bool,
        ),
      }.withoutNulls;

  static NotiUserStruct fromSerializableMap(Map<String, dynamic> data) =>
      NotiUserStruct(
        userref: deserializeParam(
          data['userref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Users'],
        ),
        isread: deserializeParam(
          data['isread'],
          ParamType.bool,
          false,
        ),
      );

  static NotiUserStruct fromAlgoliaData(Map<String, dynamic> data) =>
      NotiUserStruct(
        userref: convertAlgoliaParam(
          data['userref'],
          ParamType.DocumentReference,
          false,
        ),
        isread: convertAlgoliaParam(
          data['isread'],
          ParamType.bool,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'NotiUserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NotiUserStruct &&
        userref == other.userref &&
        isread == other.isread;
  }

  @override
  int get hashCode => const ListEquality().hash([userref, isread]);
}

NotiUserStruct createNotiUserStruct({
  DocumentReference? userref,
  bool? isread,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NotiUserStruct(
      userref: userref,
      isread: isread,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NotiUserStruct? updateNotiUserStruct(
  NotiUserStruct? notiUser, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    notiUser
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNotiUserStructData(
  Map<String, dynamic> firestoreData,
  NotiUserStruct? notiUser,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (notiUser == null) {
    return;
  }
  if (notiUser.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && notiUser.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final notiUserData = getNotiUserFirestoreData(notiUser, forFieldValue);
  final nestedData = notiUserData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = notiUser.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNotiUserFirestoreData(
  NotiUserStruct? notiUser, [
  bool forFieldValue = false,
]) {
  if (notiUser == null) {
    return {};
  }
  final firestoreData = mapToFirestore(notiUser.toMap());

  // Add any Firestore field values
  notiUser.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNotiUserListFirestoreData(
  List<NotiUserStruct>? notiUsers,
) =>
    notiUsers?.map((e) => getNotiUserFirestoreData(e, true)).toList() ?? [];
