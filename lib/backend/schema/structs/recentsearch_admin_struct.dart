// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class RecentsearchAdminStruct extends FFFirebaseStruct {
  RecentsearchAdminStruct({
    DocumentReference? classref,
    String? name,
    DateTime? createdtime,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _classref = classref,
        _name = name,
        _createdtime = createdtime,
        super(firestoreUtilData);

  // "classref" field.
  DocumentReference? _classref;
  DocumentReference? get classref => _classref;
  set classref(DocumentReference? val) => _classref = val;

  bool hasClassref() => _classref != null;

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

  static RecentsearchAdminStruct fromMap(Map<String, dynamic> data) =>
      RecentsearchAdminStruct(
        classref: data['classref'] as DocumentReference?,
        name: data['name'] as String?,
        createdtime: data['createdtime'] as DateTime?,
      );

  static RecentsearchAdminStruct? maybeFromMap(dynamic data) => data is Map
      ? RecentsearchAdminStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'classref': _classref,
        'name': _name,
        'createdtime': _createdtime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'classref': serializeParam(
          _classref,
          ParamType.DocumentReference,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'createdtime': serializeParam(
          _createdtime,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static RecentsearchAdminStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RecentsearchAdminStruct(
        classref: deserializeParam(
          data['classref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['School_class'],
        ),
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
      );

  static RecentsearchAdminStruct fromAlgoliaData(Map<String, dynamic> data) =>
      RecentsearchAdminStruct(
        classref: convertAlgoliaParam(
          data['classref'],
          ParamType.DocumentReference,
          false,
        ),
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
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'RecentsearchAdminStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RecentsearchAdminStruct &&
        classref == other.classref &&
        name == other.name &&
        createdtime == other.createdtime;
  }

  @override
  int get hashCode => const ListEquality().hash([classref, name, createdtime]);
}

RecentsearchAdminStruct createRecentsearchAdminStruct({
  DocumentReference? classref,
  String? name,
  DateTime? createdtime,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RecentsearchAdminStruct(
      classref: classref,
      name: name,
      createdtime: createdtime,
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
