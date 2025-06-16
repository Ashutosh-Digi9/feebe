// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ParentsaddStruct extends FFFirebaseStruct {
  ParentsaddStruct({
    int? id,
    String? relation,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _relation = relation,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "relation" field.
  String? _relation;
  String get relation => _relation ?? '';
  set relation(String? val) => _relation = val;

  bool hasRelation() => _relation != null;

  static ParentsaddStruct fromMap(Map<String, dynamic> data) =>
      ParentsaddStruct(
        id: castToType<int>(data['id']),
        relation: data['relation'] as String?,
      );

  static ParentsaddStruct? maybeFromMap(dynamic data) => data is Map
      ? ParentsaddStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'relation': _relation,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'relation': serializeParam(
          _relation,
          ParamType.String,
        ),
      }.withoutNulls;

  static ParentsaddStruct fromSerializableMap(Map<String, dynamic> data) =>
      ParentsaddStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        relation: deserializeParam(
          data['relation'],
          ParamType.String,
          false,
        ),
      );

  static ParentsaddStruct fromAlgoliaData(Map<String, dynamic> data) =>
      ParentsaddStruct(
        id: convertAlgoliaParam(
          data['id'],
          ParamType.int,
          false,
        ),
        relation: convertAlgoliaParam(
          data['relation'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ParentsaddStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ParentsaddStruct &&
        id == other.id &&
        relation == other.relation;
  }

  @override
  int get hashCode => const ListEquality().hash([id, relation]);
}

ParentsaddStruct createParentsaddStruct({
  int? id,
  String? relation,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ParentsaddStruct(
      id: id,
      relation: relation,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ParentsaddStruct? updateParentsaddStruct(
  ParentsaddStruct? parentsadd, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    parentsadd
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addParentsaddStructData(
  Map<String, dynamic> firestoreData,
  ParentsaddStruct? parentsadd,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (parentsadd == null) {
    return;
  }
  if (parentsadd.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && parentsadd.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final parentsaddData = getParentsaddFirestoreData(parentsadd, forFieldValue);
  final nestedData = parentsaddData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = parentsadd.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getParentsaddFirestoreData(
  ParentsaddStruct? parentsadd, [
  bool forFieldValue = false,
]) {
  if (parentsadd == null) {
    return {};
  }
  final firestoreData = mapToFirestore(parentsadd.toMap());

  // Add any Firestore field values
  parentsadd.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getParentsaddListFirestoreData(
  List<ParentsaddStruct>? parentsadds,
) =>
    parentsadds?.map((e) => getParentsaddFirestoreData(e, true)).toList() ?? [];
