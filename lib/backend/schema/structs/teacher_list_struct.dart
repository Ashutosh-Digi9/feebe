// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class TeacherListStruct extends FFFirebaseStruct {
  TeacherListStruct({
    String? teacherName,
    String? phoneNumber,
    String? emailId,
    String? teacherImage,
    DocumentReference? teachersId,
    DocumentReference? userRef,
    bool? isemail,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _teacherName = teacherName,
        _phoneNumber = phoneNumber,
        _emailId = emailId,
        _teacherImage = teacherImage,
        _teachersId = teachersId,
        _userRef = userRef,
        _isemail = isemail,
        super(firestoreUtilData);

  // "teacher_name" field.
  String? _teacherName;
  String get teacherName => _teacherName ?? '';
  set teacherName(String? val) => _teacherName = val;

  bool hasTeacherName() => _teacherName != null;

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

  // "teacher_image" field.
  String? _teacherImage;
  String get teacherImage => _teacherImage ?? '';
  set teacherImage(String? val) => _teacherImage = val;

  bool hasTeacherImage() => _teacherImage != null;

  // "teachers_id" field.
  DocumentReference? _teachersId;
  DocumentReference? get teachersId => _teachersId;
  set teachersId(DocumentReference? val) => _teachersId = val;

  bool hasTeachersId() => _teachersId != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  set userRef(DocumentReference? val) => _userRef = val;

  bool hasUserRef() => _userRef != null;

  // "isemail" field.
  bool? _isemail;
  bool get isemail => _isemail ?? false;
  set isemail(bool? val) => _isemail = val;

  bool hasIsemail() => _isemail != null;

  static TeacherListStruct fromMap(Map<String, dynamic> data) =>
      TeacherListStruct(
        teacherName: data['teacher_name'] as String?,
        phoneNumber: data['phone_number'] as String?,
        emailId: data['email_id'] as String?,
        teacherImage: data['teacher_image'] as String?,
        teachersId: data['teachers_id'] as DocumentReference?,
        userRef: data['userRef'] as DocumentReference?,
        isemail: data['isemail'] as bool?,
      );

  static TeacherListStruct? maybeFromMap(dynamic data) => data is Map
      ? TeacherListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'teacher_name': _teacherName,
        'phone_number': _phoneNumber,
        'email_id': _emailId,
        'teacher_image': _teacherImage,
        'teachers_id': _teachersId,
        'userRef': _userRef,
        'isemail': _isemail,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'teacher_name': serializeParam(
          _teacherName,
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
        'teacher_image': serializeParam(
          _teacherImage,
          ParamType.String,
        ),
        'teachers_id': serializeParam(
          _teachersId,
          ParamType.DocumentReference,
        ),
        'userRef': serializeParam(
          _userRef,
          ParamType.DocumentReference,
        ),
        'isemail': serializeParam(
          _isemail,
          ParamType.bool,
        ),
      }.withoutNulls;

  static TeacherListStruct fromSerializableMap(Map<String, dynamic> data) =>
      TeacherListStruct(
        teacherName: deserializeParam(
          data['teacher_name'],
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
        teacherImage: deserializeParam(
          data['teacher_image'],
          ParamType.String,
          false,
        ),
        teachersId: deserializeParam(
          data['teachers_id'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Teachers'],
        ),
        userRef: deserializeParam(
          data['userRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Users'],
        ),
        isemail: deserializeParam(
          data['isemail'],
          ParamType.bool,
          false,
        ),
      );

  static TeacherListStruct fromAlgoliaData(Map<String, dynamic> data) =>
      TeacherListStruct(
        teacherName: convertAlgoliaParam(
          data['teacher_name'],
          ParamType.String,
          false,
        ),
        phoneNumber: convertAlgoliaParam(
          data['phone_number'],
          ParamType.String,
          false,
        ),
        emailId: convertAlgoliaParam(
          data['email_id'],
          ParamType.String,
          false,
        ),
        teacherImage: convertAlgoliaParam(
          data['teacher_image'],
          ParamType.String,
          false,
        ),
        teachersId: convertAlgoliaParam(
          data['teachers_id'],
          ParamType.DocumentReference,
          false,
        ),
        userRef: convertAlgoliaParam(
          data['userRef'],
          ParamType.DocumentReference,
          false,
        ),
        isemail: convertAlgoliaParam(
          data['isemail'],
          ParamType.bool,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'TeacherListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TeacherListStruct &&
        teacherName == other.teacherName &&
        phoneNumber == other.phoneNumber &&
        emailId == other.emailId &&
        teacherImage == other.teacherImage &&
        teachersId == other.teachersId &&
        userRef == other.userRef &&
        isemail == other.isemail;
  }

  @override
  int get hashCode => const ListEquality().hash([
        teacherName,
        phoneNumber,
        emailId,
        teacherImage,
        teachersId,
        userRef,
        isemail
      ]);
}

TeacherListStruct createTeacherListStruct({
  String? teacherName,
  String? phoneNumber,
  String? emailId,
  String? teacherImage,
  DocumentReference? teachersId,
  DocumentReference? userRef,
  bool? isemail,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TeacherListStruct(
      teacherName: teacherName,
      phoneNumber: phoneNumber,
      emailId: emailId,
      teacherImage: teacherImage,
      teachersId: teachersId,
      userRef: userRef,
      isemail: isemail,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TeacherListStruct? updateTeacherListStruct(
  TeacherListStruct? teacherList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    teacherList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTeacherListStructData(
  Map<String, dynamic> firestoreData,
  TeacherListStruct? teacherList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (teacherList == null) {
    return;
  }
  if (teacherList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && teacherList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final teacherListData =
      getTeacherListFirestoreData(teacherList, forFieldValue);
  final nestedData =
      teacherListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = teacherList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTeacherListFirestoreData(
  TeacherListStruct? teacherList, [
  bool forFieldValue = false,
]) {
  if (teacherList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(teacherList.toMap());

  // Add any Firestore field values
  teacherList.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTeacherListListFirestoreData(
  List<TeacherListStruct>? teacherLists,
) =>
    teacherLists?.map((e) => getTeacherListFirestoreData(e, true)).toList() ??
    [];
