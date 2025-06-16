// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class TeachersAttendanceStruct extends FFFirebaseStruct {
  TeachersAttendanceStruct({
    int? id,
    DateTime? date,
    bool? ispresent,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    int? leaves,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _date = date,
        _ispresent = ispresent,
        _checkInTime = checkInTime,
        _checkOutTime = checkOutTime,
        _leaves = leaves,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "Date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "ispresent" field.
  bool? _ispresent;
  bool get ispresent => _ispresent ?? false;
  set ispresent(bool? val) => _ispresent = val;

  bool hasIspresent() => _ispresent != null;

  // "check_in_time" field.
  DateTime? _checkInTime;
  DateTime? get checkInTime => _checkInTime;
  set checkInTime(DateTime? val) => _checkInTime = val;

  bool hasCheckInTime() => _checkInTime != null;

  // "check_out_time" field.
  DateTime? _checkOutTime;
  DateTime? get checkOutTime => _checkOutTime;
  set checkOutTime(DateTime? val) => _checkOutTime = val;

  bool hasCheckOutTime() => _checkOutTime != null;

  // "leaves" field.
  int? _leaves;
  int get leaves => _leaves ?? 0;
  set leaves(int? val) => _leaves = val;

  void incrementLeaves(int amount) => leaves = leaves + amount;

  bool hasLeaves() => _leaves != null;

  static TeachersAttendanceStruct fromMap(Map<String, dynamic> data) =>
      TeachersAttendanceStruct(
        id: castToType<int>(data['id']),
        date: data['Date'] as DateTime?,
        ispresent: data['ispresent'] as bool?,
        checkInTime: data['check_in_time'] as DateTime?,
        checkOutTime: data['check_out_time'] as DateTime?,
        leaves: castToType<int>(data['leaves']),
      );

  static TeachersAttendanceStruct? maybeFromMap(dynamic data) => data is Map
      ? TeachersAttendanceStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'Date': _date,
        'ispresent': _ispresent,
        'check_in_time': _checkInTime,
        'check_out_time': _checkOutTime,
        'leaves': _leaves,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'Date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'ispresent': serializeParam(
          _ispresent,
          ParamType.bool,
        ),
        'check_in_time': serializeParam(
          _checkInTime,
          ParamType.DateTime,
        ),
        'check_out_time': serializeParam(
          _checkOutTime,
          ParamType.DateTime,
        ),
        'leaves': serializeParam(
          _leaves,
          ParamType.int,
        ),
      }.withoutNulls;

  static TeachersAttendanceStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      TeachersAttendanceStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        date: deserializeParam(
          data['Date'],
          ParamType.DateTime,
          false,
        ),
        ispresent: deserializeParam(
          data['ispresent'],
          ParamType.bool,
          false,
        ),
        checkInTime: deserializeParam(
          data['check_in_time'],
          ParamType.DateTime,
          false,
        ),
        checkOutTime: deserializeParam(
          data['check_out_time'],
          ParamType.DateTime,
          false,
        ),
        leaves: deserializeParam(
          data['leaves'],
          ParamType.int,
          false,
        ),
      );

  static TeachersAttendanceStruct fromAlgoliaData(Map<String, dynamic> data) =>
      TeachersAttendanceStruct(
        id: convertAlgoliaParam(
          data['id'],
          ParamType.int,
          false,
        ),
        date: convertAlgoliaParam(
          data['Date'],
          ParamType.DateTime,
          false,
        ),
        ispresent: convertAlgoliaParam(
          data['ispresent'],
          ParamType.bool,
          false,
        ),
        checkInTime: convertAlgoliaParam(
          data['check_in_time'],
          ParamType.DateTime,
          false,
        ),
        checkOutTime: convertAlgoliaParam(
          data['check_out_time'],
          ParamType.DateTime,
          false,
        ),
        leaves: convertAlgoliaParam(
          data['leaves'],
          ParamType.int,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'TeachersAttendanceStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TeachersAttendanceStruct &&
        id == other.id &&
        date == other.date &&
        ispresent == other.ispresent &&
        checkInTime == other.checkInTime &&
        checkOutTime == other.checkOutTime &&
        leaves == other.leaves;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, date, ispresent, checkInTime, checkOutTime, leaves]);
}

TeachersAttendanceStruct createTeachersAttendanceStruct({
  int? id,
  DateTime? date,
  bool? ispresent,
  DateTime? checkInTime,
  DateTime? checkOutTime,
  int? leaves,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TeachersAttendanceStruct(
      id: id,
      date: date,
      ispresent: ispresent,
      checkInTime: checkInTime,
      checkOutTime: checkOutTime,
      leaves: leaves,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TeachersAttendanceStruct? updateTeachersAttendanceStruct(
  TeachersAttendanceStruct? teachersAttendance, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    teachersAttendance
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTeachersAttendanceStructData(
  Map<String, dynamic> firestoreData,
  TeachersAttendanceStruct? teachersAttendance,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (teachersAttendance == null) {
    return;
  }
  if (teachersAttendance.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && teachersAttendance.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final teachersAttendanceData =
      getTeachersAttendanceFirestoreData(teachersAttendance, forFieldValue);
  final nestedData =
      teachersAttendanceData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      teachersAttendance.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTeachersAttendanceFirestoreData(
  TeachersAttendanceStruct? teachersAttendance, [
  bool forFieldValue = false,
]) {
  if (teachersAttendance == null) {
    return {};
  }
  final firestoreData = mapToFirestore(teachersAttendance.toMap());

  // Add any Firestore field values
  teachersAttendance.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTeachersAttendanceListFirestoreData(
  List<TeachersAttendanceStruct>? teachersAttendances,
) =>
    teachersAttendances
        ?.map((e) => getTeachersAttendanceFirestoreData(e, true))
        .toList() ??
    [];
