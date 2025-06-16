// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class StudentAttendanceStruct extends FFFirebaseStruct {
  StudentAttendanceStruct({
    int? id,
    DateTime? date,
    bool? ispresent,
    String? addedBy,
    DocumentReference? studentref,
    bool? checkIn,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _date = date,
        _ispresent = ispresent,
        _addedBy = addedBy,
        _studentref = studentref,
        _checkIn = checkIn,
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

  // "studentref" field.
  DocumentReference? _studentref;
  DocumentReference? get studentref => _studentref;
  set studentref(DocumentReference? val) => _studentref = val;

  bool hasStudentref() => _studentref != null;

  // "checkIn" field.
  bool? _checkIn;
  bool get checkIn => _checkIn ?? false;
  set checkIn(bool? val) => _checkIn = val;

  bool hasCheckIn() => _checkIn != null;

  static StudentAttendanceStruct fromMap(Map<String, dynamic> data) =>
      StudentAttendanceStruct(
        id: castToType<int>(data['id']),
        date: data['date'] as DateTime?,
        ispresent: data['ispresent'] as bool?,
        addedBy: data['added_by'] as String?,
        studentref: data['studentref'] as DocumentReference?,
        checkIn: data['checkIn'] as bool?,
      );

  static StudentAttendanceStruct? maybeFromMap(dynamic data) => data is Map
      ? StudentAttendanceStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'date': _date,
        'ispresent': _ispresent,
        'added_by': _addedBy,
        'studentref': _studentref,
        'checkIn': _checkIn,
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
        'studentref': serializeParam(
          _studentref,
          ParamType.DocumentReference,
        ),
        'checkIn': serializeParam(
          _checkIn,
          ParamType.bool,
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
        studentref: deserializeParam(
          data['studentref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Students'],
        ),
        checkIn: deserializeParam(
          data['checkIn'],
          ParamType.bool,
          false,
        ),
      );

  static StudentAttendanceStruct fromAlgoliaData(Map<String, dynamic> data) =>
      StudentAttendanceStruct(
        id: convertAlgoliaParam(
          data['id'],
          ParamType.int,
          false,
        ),
        date: convertAlgoliaParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        ispresent: convertAlgoliaParam(
          data['ispresent'],
          ParamType.bool,
          false,
        ),
        addedBy: convertAlgoliaParam(
          data['added_by'],
          ParamType.String,
          false,
        ),
        studentref: convertAlgoliaParam(
          data['studentref'],
          ParamType.DocumentReference,
          false,
        ),
        checkIn: convertAlgoliaParam(
          data['checkIn'],
          ParamType.bool,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
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
        addedBy == other.addedBy &&
        studentref == other.studentref &&
        checkIn == other.checkIn;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, date, ispresent, addedBy, studentref, checkIn]);
}

StudentAttendanceStruct createStudentAttendanceStruct({
  int? id,
  DateTime? date,
  bool? ispresent,
  String? addedBy,
  DocumentReference? studentref,
  bool? checkIn,
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
      studentref: studentref,
      checkIn: checkIn,
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
