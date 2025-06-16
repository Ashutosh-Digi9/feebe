// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class RecentsearchAdminStruct extends FFFirebaseStruct {
  RecentsearchAdminStruct({
    String? name,
    DateTime? createdtime,
    DocumentReference? studentref,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _createdtime = createdtime,
        _studentref = studentref,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "createdtime" field.
  DateTime? _createdtime;
  DateTime? get createdtime => _createdtime;
  set createdtime(DateTime? val) => _createdtime = val;

  bool hasCreatedtime() => _createdtime != null;

  // "studentref" field.
  DocumentReference? _studentref;
  DocumentReference? get studentref => _studentref;
  set studentref(DocumentReference? val) => _studentref = val;

  bool hasStudentref() => _studentref != null;

  static RecentsearchAdminStruct fromMap(Map<String, dynamic> data) =>
      RecentsearchAdminStruct(
        name: data['name'] as String?,
        createdtime: data['createdtime'] as DateTime?,
        studentref: data['studentref'] as DocumentReference?,
      );

  static RecentsearchAdminStruct? maybeFromMap(dynamic data) => data is Map
      ? RecentsearchAdminStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'createdtime': _createdtime,
        'studentref': _studentref,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'createdtime': serializeParam(
          _createdtime,
          ParamType.DateTime,
        ),
        'studentref': serializeParam(
          _studentref,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static RecentsearchAdminStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RecentsearchAdminStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        createdtime: deserializeParam(
          data['createdtime'],
          ParamType.DateTime,
          false,
        ),
        studentref: deserializeParam(
          data['studentref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Students'],
        ),
      );

  static RecentsearchAdminStruct fromAlgoliaData(Map<String, dynamic> data) =>
      RecentsearchAdminStruct(
        name: convertAlgoliaParam(
          data['name'],
          ParamType.String,
          false,
        ),
        createdtime: convertAlgoliaParam(
          data['createdtime'],
          ParamType.DateTime,
          false,
        ),
        studentref: convertAlgoliaParam(
          data['studentref'],
          ParamType.DocumentReference,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'RecentsearchAdminStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RecentsearchAdminStruct &&
        name == other.name &&
        createdtime == other.createdtime &&
        studentref == other.studentref;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([name, createdtime, studentref]);
}

RecentsearchAdminStruct createRecentsearchAdminStruct({
  String? name,
  DateTime? createdtime,
  DocumentReference? studentref,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RecentsearchAdminStruct(
      name: name,
      createdtime: createdtime,
      studentref: studentref,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RecentsearchAdminStruct? updateRecentsearchAdminStruct(
  RecentsearchAdminStruct? recentsearchAdmin, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    recentsearchAdmin
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRecentsearchAdminStructData(
  Map<String, dynamic> firestoreData,
  RecentsearchAdminStruct? recentsearchAdmin,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (recentsearchAdmin == null) {
    return;
  }
  if (recentsearchAdmin.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && recentsearchAdmin.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final recentsearchAdminData =
      getRecentsearchAdminFirestoreData(recentsearchAdmin, forFieldValue);
  final nestedData =
      recentsearchAdminData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = recentsearchAdmin.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRecentsearchAdminFirestoreData(
  RecentsearchAdminStruct? recentsearchAdmin, [
  bool forFieldValue = false,
]) {
  if (recentsearchAdmin == null) {
    return {};
  }
  final firestoreData = mapToFirestore(recentsearchAdmin.toMap());

  // Add any Firestore field values
  recentsearchAdmin.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRecentsearchAdminListFirestoreData(
  List<RecentsearchAdminStruct>? recentsearchAdmins,
) =>
    recentsearchAdmins
        ?.map((e) => getRecentsearchAdminFirestoreData(e, true))
        .toList() ??
    [];
