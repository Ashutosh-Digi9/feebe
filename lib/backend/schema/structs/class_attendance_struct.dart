// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClassAttendanceStruct extends FFFirebaseStruct {
  ClassAttendanceStruct({
    int? id,
    int? totalStudents,
    List<DocumentReference>? studentPresentList,
    int? totalPresent,
    int? totalAbsent,
    DateTime? date,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _totalStudents = totalStudents,
        _studentPresentList = studentPresentList,
        _totalPresent = totalPresent,
        _totalAbsent = totalAbsent,
        _date = date,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "Total_students" field.
  int? _totalStudents;
  int get totalStudents => _totalStudents ?? 0;
  set totalStudents(int? val) => _totalStudents = val;

  void incrementTotalStudents(int amount) =>
      totalStudents = totalStudents + amount;

  bool hasTotalStudents() => _totalStudents != null;

  // "student_present_list" field.
  List<DocumentReference>? _studentPresentList;
  List<DocumentReference> get studentPresentList =>
      _studentPresentList ?? const [];
  set studentPresentList(List<DocumentReference>? val) =>
      _studentPresentList = val;

  void updateStudentPresentList(Function(List<DocumentReference>) updateFn) {
    updateFn(_studentPresentList ??= []);
  }

  bool hasStudentPresentList() => _studentPresentList != null;

  // "Total_present" field.
  int? _totalPresent;
  int get totalPresent => _totalPresent ?? 0;
  set totalPresent(int? val) => _totalPresent = val;

  void incrementTotalPresent(int amount) =>
      totalPresent = totalPresent + amount;

  bool hasTotalPresent() => _totalPresent != null;

  // "Total_absent" field.
  int? _totalAbsent;
  int get totalAbsent => _totalAbsent ?? 0;
  set totalAbsent(int? val) => _totalAbsent = val;

  void incrementTotalAbsent(int amount) => totalAbsent = totalAbsent + amount;

  bool hasTotalAbsent() => _totalAbsent != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  static ClassAttendanceStruct fromMap(Map<String, dynamic> data) =>
      ClassAttendanceStruct(
        id: castToType<int>(data['id']),
        totalStudents: castToType<int>(data['Total_students']),
        studentPresentList: getDataList(data['student_present_list']),
        totalPresent: castToType<int>(data['Total_present']),
        totalAbsent: castToType<int>(data['Total_absent']),
        date: data['date'] as DateTime?,
      );

  static ClassAttendanceStruct? maybeFromMap(dynamic data) => data is Map
      ? ClassAttendanceStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'Total_students': _totalStudents,
        'student_present_list': _studentPresentList,
        'Total_present': _totalPresent,
        'Total_absent': _totalAbsent,
        'date': _date,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'Total_students': serializeParam(
          _totalStudents,
          ParamType.int,
        ),
        'student_present_list': serializeParam(
          _studentPresentList,
          ParamType.DocumentReference,
          isList: true,
        ),
        'Total_present': serializeParam(
          _totalPresent,
          ParamType.int,
        ),
        'Total_absent': serializeParam(
          _totalAbsent,
          ParamType.int,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static ClassAttendanceStruct fromSerializableMap(Map<String, dynamic> data) =>
      ClassAttendanceStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        totalStudents: deserializeParam(
          data['Total_students'],
          ParamType.int,
          false,
        ),
        studentPresentList: deserializeParam<DocumentReference>(
          data['student_present_list'],
          ParamType.DocumentReference,
          true,
          collectionNamePath: ['Students'],
        ),
        totalPresent: deserializeParam(
          data['Total_present'],
          ParamType.int,
          false,
        ),
        totalAbsent: deserializeParam(
          data['Total_absent'],
          ParamType.int,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'ClassAttendanceStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ClassAttendanceStruct &&
        id == other.id &&
        totalStudents == other.totalStudents &&
        listEquality.equals(studentPresentList, other.studentPresentList) &&
        totalPresent == other.totalPresent &&
        totalAbsent == other.totalAbsent &&
        date == other.date;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [id, totalStudents, studentPresentList, totalPresent, totalAbsent, date]);
}

ClassAttendanceStruct createClassAttendanceStruct({
  int? id,
  int? totalStudents,
  int? totalPresent,
  int? totalAbsent,
  DateTime? date,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ClassAttendanceStruct(
      id: id,
      totalStudents: totalStudents,
      totalPresent: totalPresent,
      totalAbsent: totalAbsent,
      date: date,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ClassAttendanceStruct? updateClassAttendanceStruct(
  ClassAttendanceStruct? classAttendance, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    classAttendance
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addClassAttendanceStructData(
  Map<String, dynamic> firestoreData,
  ClassAttendanceStruct? classAttendance,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (classAttendance == null) {
    return;
  }
  if (classAttendance.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && classAttendance.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final classAttendanceData =
      getClassAttendanceFirestoreData(classAttendance, forFieldValue);
  final nestedData =
      classAttendanceData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = classAttendance.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getClassAttendanceFirestoreData(
  ClassAttendanceStruct? classAttendance, [
  bool forFieldValue = false,
]) {
  if (classAttendance == null) {
    return {};
  }
  final firestoreData = mapToFirestore(classAttendance.toMap());

  // Add any Firestore field values
  classAttendance.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getClassAttendanceListFirestoreData(
  List<ClassAttendanceStruct>? classAttendances,
) =>
    classAttendances
        ?.map((e) => getClassAttendanceFirestoreData(e, true))
        .toList() ??
    [];
