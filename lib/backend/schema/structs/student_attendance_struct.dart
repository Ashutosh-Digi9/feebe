// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class StudentAttendanceStruct extends FFFirebaseStruct {
  StudentAttendanceStruct({
    int? id,
    DateTime? date,
    bool? ispresent,
    String? addedBy,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _date = date,
        _ispresent = ispresent,
        _addedBy = addedBy,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "ispresent" field.
  bool? _ispresent;
  bool get ispresent => _ispresent ?? false;
  set ispresent(bool? val) => _ispresent = val;

  bool hasIspresent() => _ispresent != null;

  // "added_by" field.
  String? _addedBy;
  String get addedBy => _addedBy ?? '';
  set addedBy(String? val) => _addedBy = val;

  bool hasAddedBy() => _addedBy != null;

  static StudentAttendanceStruct fromMap(Map<String, dynamic> data) =>
      StudentAttendanceStruct(
        id: castToType<int>(data['id']),
        date: data['date'] as DateTime?,
        ispresent: data['ispresent'] as bool?,
        addedBy: data['added_by'] as String?,
      );

  static StudentAttendanceStruct? maybeFromMap(dynamic data) => data is Map
      ? StudentAttendanceStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'date': _date,
        'ispresent': _ispresent,
        'added_by': _addedBy,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'ispresent': serializeParam(
          _ispresent,
          ParamType.bool,
        ),
        'added_by': serializeParam(
          _addedBy,
          ParamType.String,
        ),
      }.withoutNulls;

  static StudentAttendanceStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      StudentAttendanceStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        ispresent: deserializeParam(
          data['ispresent'],
          ParamType.bool,
          false,
        ),
        addedBy: deserializeParam(
          data['added_by'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'StudentAttendanceStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is StudentAttendanceStruct &&
        id == other.id &&
        date == other.date &&
        ispresent == other.ispresent &&
        addedBy == other.addedBy;
  }

  @override
  int get hashCode => const ListEquality().hash([id, date, ispresent, addedBy]);
}

StudentAttendanceStruct createStudentAttendanceStruct({
  int? id,
  DateTime? date,
  bool? ispresent,
  String? addedBy,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    StudentAttendanceStruct(
      id: id,
      date: date,
      ispresent: ispresent,
      addedBy: addedBy,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

StudentAttendanceStruct? updateStudentAttendanceStruct(
  StudentAttendanceStruct? studentAttendance, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    studentAttendance
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addStudentAttendanceStructData(
  Map<String, dynamic> firestoreData,
  StudentAttendanceStruct? studentAttendance,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (studentAttendance == null) {
    return;
  }
  if (studentAttendance.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && studentAttendance.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final studentAttendanceData =
      getStudentAttendanceFirestoreData(studentAttendance, forFieldValue);
  final nestedData =
      studentAttendanceData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = studentAttendance.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getStudentAttendanceFirestoreData(
  StudentAttendanceStruct? studentAttendance, [
  bool forFieldValue = false,
]) {
  if (studentAttendance == null) {
    return {};
  }
  final firestoreData = mapToFirestore(studentAttendance.toMap());

  // Add any Firestore field values
  studentAttendance.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getStudentAttendanceListFirestoreData(
  List<StudentAttendanceStruct>? studentAttendances,
) =>
    studentAttendances
        ?.map((e) => getStudentAttendanceFirestoreData(e, true))
        .toList() ??
    [];
