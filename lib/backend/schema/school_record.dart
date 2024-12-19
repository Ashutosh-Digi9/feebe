import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SchoolRecord extends FirestoreRecord {
  SchoolRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "school_details" field.
  SchoolDetailsStruct? _schoolDetails;
  SchoolDetailsStruct get schoolDetails =>
      _schoolDetails ?? SchoolDetailsStruct();
  bool hasSchoolDetails() => _schoolDetails != null;

  // "principal_details" field.
  PrincipalDetailsStruct? _principalDetails;
  PrincipalDetailsStruct get principalDetails =>
      _principalDetails ?? PrincipalDetailsStruct();
  bool hasPrincipalDetails() => _principalDetails != null;

  // "school_status" field.
  int? _schoolStatus;
  int get schoolStatus => _schoolStatus ?? 0;
  bool hasSchoolStatus() => _schoolStatus != null;

  // "subscription_status" field.
  int? _subscriptionStatus;
  int get subscriptionStatus => _subscriptionStatus ?? 0;
  bool hasSubscriptionStatus() => _subscriptionStatus != null;

  // "subscription_details" field.
  SubscribtionDetailsStruct? _subscriptionDetails;
  SubscribtionDetailsStruct get subscriptionDetails =>
      _subscriptionDetails ?? SubscribtionDetailsStruct();
  bool hasSubscriptionDetails() => _subscriptionDetails != null;

  // "isBranch_present" field.
  bool? _isBranchPresent;
  bool get isBranchPresent => _isBranchPresent ?? false;
  bool hasIsBranchPresent() => _isBranchPresent != null;

  // "branch_details" field.
  List<SchoolDetailsStruct>? _branchDetails;
  List<SchoolDetailsStruct> get branchDetails => _branchDetails ?? const [];
  bool hasBranchDetails() => _branchDetails != null;

  // "Calendar_list" field.
  List<EventsNoticeStruct>? _calendarList;
  List<EventsNoticeStruct> get calendarList => _calendarList ?? const [];
  bool hasCalendarList() => _calendarList != null;

  // "List_of_class" field.
  List<DocumentReference>? _listOfClass;
  List<DocumentReference> get listOfClass => _listOfClass ?? const [];
  bool hasListOfClass() => _listOfClass != null;

  // "List_of_notice" field.
  List<EventsNoticeStruct>? _listOfNotice;
  List<EventsNoticeStruct> get listOfNotice => _listOfNotice ?? const [];
  bool hasListOfNotice() => _listOfNotice != null;

  // "List_of_students" field.
  List<DocumentReference>? _listOfStudents;
  List<DocumentReference> get listOfStudents => _listOfStudents ?? const [];
  bool hasListOfStudents() => _listOfStudents != null;

  // "List_of_teachers" field.
  List<DocumentReference>? _listOfTeachers;
  List<DocumentReference> get listOfTeachers => _listOfTeachers ?? const [];
  bool hasListOfTeachers() => _listOfTeachers != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "teachers_data_list" field.
  List<TeacherListStruct>? _teachersDataList;
  List<TeacherListStruct> get teachersDataList => _teachersDataList ?? const [];
  bool hasTeachersDataList() => _teachersDataList != null;

  // "student_data_list" field.
  List<StudentListStruct>? _studentDataList;
  List<StudentListStruct> get studentDataList => _studentDataList ?? const [];
  bool hasStudentDataList() => _studentDataList != null;

  // "listOfteachersuser" field.
  List<DocumentReference>? _listOfteachersuser;
  List<DocumentReference> get listOfteachersuser =>
      _listOfteachersuser ?? const [];
  bool hasListOfteachersuser() => _listOfteachersuser != null;

  // "latlng" field.
  LatLng? _latlng;
  LatLng? get latlng => _latlng;
  bool hasLatlng() => _latlng != null;

  // "popupdate" field.
  DateTime? _popupdate;
  DateTime? get popupdate => _popupdate;
  bool hasPopupdate() => _popupdate != null;

  void _initializeFields() {
    _schoolDetails = snapshotData['school_details'] is SchoolDetailsStruct
        ? snapshotData['school_details']
        : SchoolDetailsStruct.maybeFromMap(snapshotData['school_details']);
    _principalDetails =
        snapshotData['principal_details'] is PrincipalDetailsStruct
            ? snapshotData['principal_details']
            : PrincipalDetailsStruct.maybeFromMap(
                snapshotData['principal_details']);
    _schoolStatus = castToType<int>(snapshotData['school_status']);
    _subscriptionStatus = castToType<int>(snapshotData['subscription_status']);
    _subscriptionDetails =
        snapshotData['subscription_details'] is SubscribtionDetailsStruct
            ? snapshotData['subscription_details']
            : SubscribtionDetailsStruct.maybeFromMap(
                snapshotData['subscription_details']);
    _isBranchPresent = snapshotData['isBranch_present'] as bool?;
    _branchDetails = getStructList(
      snapshotData['branch_details'],
      SchoolDetailsStruct.fromMap,
    );
    _calendarList = getStructList(
      snapshotData['Calendar_list'],
      EventsNoticeStruct.fromMap,
    );
    _listOfClass = getDataList(snapshotData['List_of_class']);
    _listOfNotice = getStructList(
      snapshotData['List_of_notice'],
      EventsNoticeStruct.fromMap,
    );
    _listOfStudents = getDataList(snapshotData['List_of_students']);
    _listOfTeachers = getDataList(snapshotData['List_of_teachers']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _teachersDataList = getStructList(
      snapshotData['teachers_data_list'],
      TeacherListStruct.fromMap,
    );
    _studentDataList = getStructList(
      snapshotData['student_data_list'],
      StudentListStruct.fromMap,
    );
    _listOfteachersuser = getDataList(snapshotData['listOfteachersuser']);
    _latlng = snapshotData['latlng'] as LatLng?;
    _popupdate = snapshotData['popupdate'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('School');

  static Stream<SchoolRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SchoolRecord.fromSnapshot(s));

  static Future<SchoolRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SchoolRecord.fromSnapshot(s));

  static SchoolRecord fromSnapshot(DocumentSnapshot snapshot) => SchoolRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SchoolRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SchoolRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SchoolRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SchoolRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSchoolRecordData({
  SchoolDetailsStruct? schoolDetails,
  PrincipalDetailsStruct? principalDetails,
  int? schoolStatus,
  int? subscriptionStatus,
  SubscribtionDetailsStruct? subscriptionDetails,
  bool? isBranchPresent,
  DateTime? createdAt,
  DateTime? updatedAt,
  LatLng? latlng,
  DateTime? popupdate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'school_details': SchoolDetailsStruct().toMap(),
      'principal_details': PrincipalDetailsStruct().toMap(),
      'school_status': schoolStatus,
      'subscription_status': subscriptionStatus,
      'subscription_details': SubscribtionDetailsStruct().toMap(),
      'isBranch_present': isBranchPresent,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'latlng': latlng,
      'popupdate': popupdate,
    }.withoutNulls,
  );

  // Handle nested data for "school_details" field.
  addSchoolDetailsStructData(firestoreData, schoolDetails, 'school_details');

  // Handle nested data for "principal_details" field.
  addPrincipalDetailsStructData(
      firestoreData, principalDetails, 'principal_details');

  // Handle nested data for "subscription_details" field.
  addSubscribtionDetailsStructData(
      firestoreData, subscriptionDetails, 'subscription_details');

  return firestoreData;
}

class SchoolRecordDocumentEquality implements Equality<SchoolRecord> {
  const SchoolRecordDocumentEquality();

  @override
  bool equals(SchoolRecord? e1, SchoolRecord? e2) {
    const listEquality = ListEquality();
    return e1?.schoolDetails == e2?.schoolDetails &&
        e1?.principalDetails == e2?.principalDetails &&
        e1?.schoolStatus == e2?.schoolStatus &&
        e1?.subscriptionStatus == e2?.subscriptionStatus &&
        e1?.subscriptionDetails == e2?.subscriptionDetails &&
        e1?.isBranchPresent == e2?.isBranchPresent &&
        listEquality.equals(e1?.branchDetails, e2?.branchDetails) &&
        listEquality.equals(e1?.calendarList, e2?.calendarList) &&
        listEquality.equals(e1?.listOfClass, e2?.listOfClass) &&
        listEquality.equals(e1?.listOfNotice, e2?.listOfNotice) &&
        listEquality.equals(e1?.listOfStudents, e2?.listOfStudents) &&
        listEquality.equals(e1?.listOfTeachers, e2?.listOfTeachers) &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        listEquality.equals(e1?.teachersDataList, e2?.teachersDataList) &&
        listEquality.equals(e1?.studentDataList, e2?.studentDataList) &&
        listEquality.equals(e1?.listOfteachersuser, e2?.listOfteachersuser) &&
        e1?.latlng == e2?.latlng &&
        e1?.popupdate == e2?.popupdate;
  }

  @override
  int hash(SchoolRecord? e) => const ListEquality().hash([
        e?.schoolDetails,
        e?.principalDetails,
        e?.schoolStatus,
        e?.subscriptionStatus,
        e?.subscriptionDetails,
        e?.isBranchPresent,
        e?.branchDetails,
        e?.calendarList,
        e?.listOfClass,
        e?.listOfNotice,
        e?.listOfStudents,
        e?.listOfTeachers,
        e?.createdAt,
        e?.updatedAt,
        e?.teachersDataList,
        e?.studentDataList,
        e?.listOfteachersuser,
        e?.latlng,
        e?.popupdate
      ]);

  @override
  bool isValidKey(Object? o) => o is SchoolRecord;
}
