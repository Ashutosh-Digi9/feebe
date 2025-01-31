// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class SearchitemsStruct extends FFFirebaseStruct {
  SearchitemsStruct({
    String? searchterm,
    DateTime? createddate,
    int? type,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _searchterm = searchterm,
        _createddate = createddate,
        _type = type,
        super(firestoreUtilData);

  // "Searchterm" field.
  String? _searchterm;
  String get searchterm => _searchterm ?? '';
  set searchterm(String? val) => _searchterm = val;

  bool hasSearchterm() => _searchterm != null;

  // "createddate" field.
  DateTime? _createddate;
  DateTime? get createddate => _createddate;
  set createddate(DateTime? val) => _createddate = val;

  bool hasCreateddate() => _createddate != null;

  // "type" field.
  int? _type;
  int get type => _type ?? 0;
  set type(int? val) => _type = val;

  void incrementType(int amount) => type = type + amount;

  bool hasType() => _type != null;

  static SearchitemsStruct fromMap(Map<String, dynamic> data) =>
      SearchitemsStruct(
        searchterm: data['Searchterm'] as String?,
        createddate: data['createddate'] as DateTime?,
        type: castToType<int>(data['type']),
      );

  static SearchitemsStruct? maybeFromMap(dynamic data) => data is Map
      ? SearchitemsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Searchterm': _searchterm,
        'createddate': _createddate,
        'type': _type,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Searchterm': serializeParam(
          _searchterm,
          ParamType.String,
        ),
        'createddate': serializeParam(
          _createddate,
          ParamType.DateTime,
        ),
        'type': serializeParam(
          _type,
          ParamType.int,
        ),
      }.withoutNulls;

  static SearchitemsStruct fromSerializableMap(Map<String, dynamic> data) =>
      SearchitemsStruct(
        searchterm: deserializeParam(
          data['Searchterm'],
          ParamType.String,
          false,
        ),
        createddate: deserializeParam(
          data['createddate'],
          ParamType.DateTime,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.int,
          false,
        ),
      );

  static SearchitemsStruct fromAlgoliaData(Map<String, dynamic> data) =>
      SearchitemsStruct(
        searchterm: convertAlgoliaParam(
          data['Searchterm'],
          ParamType.String,
          false,
        ),
        createddate: convertAlgoliaParam(
          data['createddate'],
          ParamType.DateTime,
          false,
        ),
        type: convertAlgoliaParam(
          data['type'],
          ParamType.int,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'SearchitemsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SearchitemsStruct &&
        searchterm == other.searchterm &&
        createddate == other.createddate &&
        type == other.type;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([searchterm, createddate, type]);
}

SearchitemsStruct createSearchitemsStruct({
  String? searchterm,
  DateTime? createddate,
  int? type,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SearchitemsStruct(
      searchterm: searchterm,
      createddate: createddate,
      type: type,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SearchitemsStruct? updateSearchitemsStruct(
  SearchitemsStruct? searchitems, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    searchitems
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSearchitemsStructData(
  Map<String, dynamic> firestoreData,
  SearchitemsStruct? searchitems,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (searchitems == null) {
    return;
  }
  if (searchitems.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && searchitems.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final searchitemsData =
      getSearchitemsFirestoreData(searchitems, forFieldValue);
  final nestedData =
      searchitemsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = searchitems.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSearchitemsFirestoreData(
  SearchitemsStruct? searchitems, [
  bool forFieldValue = false,
]) {
  if (searchitems == null) {
    return {};
  }
  final firestoreData = mapToFirestore(searchitems.toMap());

  // Add any Firestore field values
  searchitems.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSearchitemsListFirestoreData(
  List<SearchitemsStruct>? searchitemss,
) =>
    searchitemss?.map((e) => getSearchitemsFirestoreData(e, true)).toList() ??
    [];
