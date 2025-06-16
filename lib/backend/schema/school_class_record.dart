import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SchoolClassRecord extends FirestoreRecord {
  SchoolClassRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "class_name" field.
  String? _className;
  String get className => _className ?? '';
  bool hasClassName() => _className != null;

  // "teachers_list" field.
  List<DocumentReference>? _teachersList;
  List<DocumentReference> get teachersList => _teachersList ?? const [];
  bool hasTeachersList() => _teachersList != null;

  // "students_list" field.
  List<DocumentReference>? _studentsList;
  List<DocumentReference> get studentsList => _studentsList ?? const [];
  bool hasStudentsList() => _studentsList != null;

  // "attendance" field.
  List<ClassAttendanceStruct>? _attendance;
  List<ClassAttendanceStruct> get attendance => _attendance ?? const [];
  bool hasAttendance() => _attendance != null;

  // "calendar" field.
  List<EventsNoticeStruct>? _calendar;
  List<EventsNoticeStruct> get calendar => _calendar ?? const [];
  bool hasCalendar() => _calendar != null;

  // "notice" field.
  List<EventsNoticeStruct>? _notice;
  List<EventsNoticeStruct> get notice => _notice ?? const [];
  bool hasNotice() => _notice != null;

  // "classTeacher" field.
  DocumentReference? _classTeacher;
  DocumentReference? get classTeacher => _classTeacher;
  bool hasClassTeacher() => _classTeacher != null;

  // "listOfteachersUser" field.
  List<DocumentReference>? _listOfteachersUser;
  List<DocumentReference> get listOfteachersUser =>
      _listOfteachersUser ?? const [];
  bool hasListOfteachersUser() => _listOfteachersUser != null;

  // "student_data" field.
  List<StudentListStruct>? _studentData;
  List<StudentListStruct> get studentData => _studentData ?? const [];
  bool hasStudentData() => _studentData != null;

  // "ListOfteachers" field.
  List<TeacherListStruct>? _listOfteachers;
  List<TeacherListStruct> get listOfteachers => _listOfteachers ?? const [];
  bool hasListOfteachers() => _listOfteachers != null;

  void _initializeFields() {
    _className = snapshotData['class_name'] as String?;
    _teachersList = getDataList(snapshotData['teachers_list']);
    _studentsList = getDataList(snapshotData['students_list']);
    _attendance = getStructList(
      snapshotData['attendance'],
      ClassAttendanceStruct.fromMap,
    );
    _calendar = getStructList(
      snapshotData['calendar'],
      EventsNoticeStruct.fromMap,
    );
    _notice = getStructList(
      snapshotData['notice'],
      EventsNoticeStruct.fromMap,
    );
    _classTeacher = snapshotData['classTeacher'] as DocumentReference?;
    _listOfteachersUser = getDataList(snapshotData['listOfteachersUser']);
    _studentData = getStructList(
      snapshotData['student_data'],
      StudentListStruct.fromMap,
    );
    _listOfteachers = getStructList(
      snapshotData['ListOfteachers'],
      TeacherListStruct.fromMap,
    );
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('School_class');

  static Stream<SchoolClassRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SchoolClassRecord.fromSnapshot(s));

  static Future<SchoolClassRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SchoolClassRecord.fromSnapshot(s));

  static SchoolClassRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SchoolClassRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SchoolClassRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SchoolClassRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SchoolClassRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SchoolClassRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSchoolClassRecordData({
  String? className,
  DocumentReference? classTeacher,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'class_name': className,
      'classTeacher': classTeacher,
    }.withoutNulls,
  );

  return firestoreData;
}

class SchoolClassRecordDocumentEquality implements Equality<SchoolClassRecord> {
  const SchoolClassRecordDocumentEquality();

  @override
  bool equals(SchoolClassRecord? e1, SchoolClassRecord? e2) {
    const listEquality = ListEquality();
    return e1?.className == e2?.className &&
        listEquality.equals(e1?.teachersList, e2?.teachersList) &&
        listEquality.equals(e1?.studentsList, e2?.studentsList) &&
        listEquality.equals(e1?.attendance, e2?.attendance) &&
        listEquality.equals(e1?.calendar, e2?.calendar) &&
        listEquality.equals(e1?.notice, e2?.notice) &&
        e1?.classTeacher == e2?.classTeacher &&
        listEquality.equals(e1?.listOfteachersUser, e2?.listOfteachersUser) &&
        listEquality.equals(e1?.studentData, e2?.studentData) &&
        listEquality.equals(e1?.listOfteachers, e2?.listOfteachers);
  }

  @override
  int hash(SchoolClassRecord? e) => const ListEquality().hash([
        e?.className,
        e?.teachersList,
        e?.studentsList,
        e?.attendance,
        e?.calendar,
        e?.notice,
        e?.classTeacher,
        e?.listOfteachersUser,
        e?.studentData,
        e?.listOfteachers
      ]);

  @override
  bool isValidKey(Object? o) => o is SchoolClassRecord;
}
