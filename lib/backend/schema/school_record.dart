import 'dart:async';

import '/backend/algolia/serialization_util.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SchoolRecord extends FirestoreRecord {
  SchoolRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
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

  // "schoolNameforSearch" field.
  String? _schoolNameforSearch;
  String get schoolNameforSearch => _schoolNameforSearch ?? '';
  bool hasSchoolNameforSearch() => _schoolNameforSearch != null;

  // "principalNameforSearch" field.
  String? _principalNameforSearch;
  String get principalNameforSearch => _principalNameforSearch ?? '';
  bool hasPrincipalNameforSearch() => _principalNameforSearch != null;

  // "listOfAdmin" field.
  List<DocumentReference>? _listOfAdmin;
  List<DocumentReference> get listOfAdmin => _listOfAdmin ?? const [];
  bool hasListOfAdmin() => _listOfAdmin != null;

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
    _schoolNameforSearch = snapshotData['schoolNameforSearch'] as String?;
    _principalNameforSearch = snapshotData['principalNameforSearch'] as String?;
    _listOfAdmin = getDataList(snapshotData['listOfAdmin']);
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

  static SchoolRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      SchoolRecord.getDocumentFromData(
        {
          'school_details': SchoolDetailsStruct.fromAlgoliaData(
                  snapshot.data['school_details'] ?? {})
              .toMap(),
          'principal_details': PrincipalDetailsStruct.fromAlgoliaData(
                  snapshot.data['principal_details'] ?? {})
              .toMap(),
          'school_status': convertAlgoliaParam(
            snapshot.data['school_status'],
            ParamType.int,
            false,
          ),
          'subscription_status': convertAlgoliaParam(
            snapshot.data['subscription_status'],
            ParamType.int,
            false,
          ),
          'subscription_details': SubscribtionDetailsStruct.fromAlgoliaData(
                  snapshot.data['subscription_details'] ?? {})
              .toMap(),
          'isBranch_present': snapshot.data['isBranch_present'],
          'branch_details': safeGet(
            () => (snapshot.data['branch_details'] as Iterable)
                .map((d) => SchoolDetailsStruct.fromAlgoliaData(d).toMap())
                .toList(),
          ),
          'Calendar_list': safeGet(
            () => (snapshot.data['Calendar_list'] as Iterable)
                .map((d) => EventsNoticeStruct.fromAlgoliaData(d).toMap())
                .toList(),
          ),
          'List_of_class': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['List_of_class'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'List_of_notice': safeGet(
            () => (snapshot.data['List_of_notice'] as Iterable)
                .map((d) => EventsNoticeStruct.fromAlgoliaData(d).toMap())
                .toList(),
          ),
          'List_of_students': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['List_of_students'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'List_of_teachers': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['List_of_teachers'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'created_at': convertAlgoliaParam(
            snapshot.data['created_at'],
            ParamType.DateTime,
            false,
          ),
          'updated_at': convertAlgoliaParam(
            snapshot.data['updated_at'],
            ParamType.DateTime,
            false,
          ),
          'teachers_data_list': safeGet(
            () => (snapshot.data['teachers_data_list'] as Iterable)
                .map((d) => TeacherListStruct.fromAlgoliaData(d).toMap())
                .toList(),
          ),
          'student_data_list': safeGet(
            () => (snapshot.data['student_data_list'] as Iterable)
                .map((d) => StudentListStruct.fromAlgoliaData(d).toMap())
                .toList(),
          ),
          'listOfteachersuser': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['listOfteachersuser'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'latlng': convertAlgoliaParam(
            snapshot.data,
            ParamType.LatLng,
            false,
          ),
          'popupdate': convertAlgoliaParam(
            snapshot.data['popupdate'],
            ParamType.DateTime,
            false,
          ),
          'schoolNameforSearch': snapshot.data['schoolNameforSearch'],
          'principalNameforSearch': snapshot.data['principalNameforSearch'],
          'listOfAdmin': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['listOfAdmin'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
        },
        SchoolRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<SchoolRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'School',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

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
  String? schoolNameforSearch,
  String? principalNameforSearch,
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
      'schoolNameforSearch': schoolNameforSearch,
      'principalNameforSearch': principalNameforSearch,
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
        e1?.popupdate == e2?.popupdate &&
        e1?.schoolNameforSearch == e2?.schoolNameforSearch &&
        e1?.principalNameforSearch == e2?.principalNameforSearch &&
        listEquality.equals(e1?.listOfAdmin, e2?.listOfAdmin);
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
        e?.popupdate,
        e?.schoolNameforSearch,
        e?.principalNameforSearch,
        e?.listOfAdmin
      ]);

  @override
  bool isValidKey(Object? o) => o is SchoolRecord;
}
