import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StudentsRecord extends FirestoreRecord {
  StudentsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "student_name" field.
  String? _studentName;
  String get studentName => _studentName ?? '';
  bool hasStudentName() => _studentName != null;

  // "student_gender" field.
  String? _studentGender;
  String get studentGender => _studentGender ?? '';
  bool hasStudentGender() => _studentGender != null;

  // "student_address" field.
  String? _studentAddress;
  String get studentAddress => _studentAddress ?? '';
  bool hasStudentAddress() => _studentAddress != null;

  // "date_of_birth" field.
  DateTime? _dateOfBirth;
  DateTime? get dateOfBirth => _dateOfBirth;
  bool hasDateOfBirth() => _dateOfBirth != null;

  // "blood_group" field.
  String? _bloodGroup;
  String get bloodGroup => _bloodGroup ?? '';
  bool hasBloodGroup() => _bloodGroup != null;

  // "school_name" field.
  String? _schoolName;
  String get schoolName => _schoolName ?? '';
  bool hasSchoolName() => _schoolName != null;

  // "Allergies_others" field.
  String? _allergiesOthers;
  String get allergiesOthers => _allergiesOthers ?? '';
  bool hasAllergiesOthers() => _allergiesOthers != null;

  // "Parents_list" field.
  List<DocumentReference>? _parentsList;
  List<DocumentReference> get parentsList => _parentsList ?? const [];
  bool hasParentsList() => _parentsList != null;

  // "timeline" field.
  List<StudentTimelineStruct>? _timeline;
  List<StudentTimelineStruct> get timeline => _timeline ?? const [];
  bool hasTimeline() => _timeline != null;

  // "attendance_percentage" field.
  int? _attendancePercentage;
  int get attendancePercentage => _attendancePercentage ?? 0;
  bool hasAttendancePercentage() => _attendancePercentage != null;

  // "attendance_details" field.
  List<StudentAttendanceStruct>? _attendanceDetails;
  List<StudentAttendanceStruct> get attendanceDetails =>
      _attendanceDetails ?? const [];
  bool hasAttendanceDetails() => _attendanceDetails != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "parents_details" field.
  List<ParentsDetailsStruct>? _parentsDetails;
  List<ParentsDetailsStruct> get parentsDetails => _parentsDetails ?? const [];
  bool hasParentsDetails() => _parentsDetails != null;

  // "class_name" field.
  String? _className;
  String get className => _className ?? '';
  bool hasClassName() => _className != null;

  // "student_image" field.
  String? _studentImage;
  String get studentImage => _studentImage ?? '';
  bool hasStudentImage() => _studentImage != null;

  // "schoolref" field.
  DocumentReference? _schoolref;
  DocumentReference? get schoolref => _schoolref;
  bool hasSchoolref() => _schoolref != null;

  // "imageslist" field.
  List<String>? _imageslist;
  List<String> get imageslist => _imageslist ?? const [];
  bool hasImageslist() => _imageslist != null;

  // "classref" field.
  List<DocumentReference>? _classref;
  List<DocumentReference> get classref => _classref ?? const [];
  bool hasClassref() => _classref != null;

  // "document" field.
  String? _document;
  String get document => _document ?? '';
  bool hasDocument() => _document != null;

  // "isDraft" field.
  bool? _isDraft;
  bool get isDraft => _isDraft ?? false;
  bool hasIsDraft() => _isDraft != null;

  // "video" field.
  String? _video;
  String get video => _video ?? '';
  bool hasVideo() => _video != null;

  // "timelineVideo" field.
  List<String>? _timelineVideo;
  List<String> get timelineVideo => _timelineVideo ?? const [];
  bool hasTimelineVideo() => _timelineVideo != null;

  // "path" field.
  String? _path;
  String get path => _path ?? '';
  bool hasPath() => _path != null;

  void _initializeFields() {
    _studentName = snapshotData['student_name'] as String?;
    _studentGender = snapshotData['student_gender'] as String?;
    _studentAddress = snapshotData['student_address'] as String?;
    _dateOfBirth = snapshotData['date_of_birth'] as DateTime?;
    _bloodGroup = snapshotData['blood_group'] as String?;
    _schoolName = snapshotData['school_name'] as String?;
    _allergiesOthers = snapshotData['Allergies_others'] as String?;
    _parentsList = getDataList(snapshotData['Parents_list']);
    _timeline = getStructList(
      snapshotData['timeline'],
      StudentTimelineStruct.fromMap,
    );
    _attendancePercentage =
        castToType<int>(snapshotData['attendance_percentage']);
    _attendanceDetails = getStructList(
      snapshotData['attendance_details'],
      StudentAttendanceStruct.fromMap,
    );
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _parentsDetails = getStructList(
      snapshotData['parents_details'],
      ParentsDetailsStruct.fromMap,
    );
    _className = snapshotData['class_name'] as String?;
    _studentImage = snapshotData['student_image'] as String?;
    _schoolref = snapshotData['schoolref'] as DocumentReference?;
    _imageslist = getDataList(snapshotData['imageslist']);
    _classref = getDataList(snapshotData['classref']);
    _document = snapshotData['document'] as String?;
    _isDraft = snapshotData['isDraft'] as bool?;
    _video = snapshotData['video'] as String?;
    _timelineVideo = getDataList(snapshotData['timelineVideo']);
    _path = snapshotData['path'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Students');

  static Stream<StudentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StudentsRecord.fromSnapshot(s));

  static Future<StudentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StudentsRecord.fromSnapshot(s));

  static StudentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      StudentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StudentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StudentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StudentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StudentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStudentsRecordData({
  String? studentName,
  String? studentGender,
  String? studentAddress,
  DateTime? dateOfBirth,
  String? bloodGroup,
  String? schoolName,
  String? allergiesOthers,
  int? attendancePercentage,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? className,
  String? studentImage,
  DocumentReference? schoolref,
  String? document,
  bool? isDraft,
  String? video,
  String? path,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'student_name': studentName,
      'student_gender': studentGender,
      'student_address': studentAddress,
      'date_of_birth': dateOfBirth,
      'blood_group': bloodGroup,
      'school_name': schoolName,
      'Allergies_others': allergiesOthers,
      'attendance_percentage': attendancePercentage,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'class_name': className,
      'student_image': studentImage,
      'schoolref': schoolref,
      'document': document,
      'isDraft': isDraft,
      'video': video,
      'path': path,
    }.withoutNulls,
  );

  return firestoreData;
}

class StudentsRecordDocumentEquality implements Equality<StudentsRecord> {
  const StudentsRecordDocumentEquality();

  @override
  bool equals(StudentsRecord? e1, StudentsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.studentName == e2?.studentName &&
        e1?.studentGender == e2?.studentGender &&
        e1?.studentAddress == e2?.studentAddress &&
        e1?.dateOfBirth == e2?.dateOfBirth &&
        e1?.bloodGroup == e2?.bloodGroup &&
        e1?.schoolName == e2?.schoolName &&
        e1?.allergiesOthers == e2?.allergiesOthers &&
        listEquality.equals(e1?.parentsList, e2?.parentsList) &&
        listEquality.equals(e1?.timeline, e2?.timeline) &&
        e1?.attendancePercentage == e2?.attendancePercentage &&
        listEquality.equals(e1?.attendanceDetails, e2?.attendanceDetails) &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        listEquality.equals(e1?.parentsDetails, e2?.parentsDetails) &&
        e1?.className == e2?.className &&
        e1?.studentImage == e2?.studentImage &&
        e1?.schoolref == e2?.schoolref &&
        listEquality.equals(e1?.imageslist, e2?.imageslist) &&
        listEquality.equals(e1?.classref, e2?.classref) &&
        e1?.document == e2?.document &&
        e1?.isDraft == e2?.isDraft &&
        e1?.video == e2?.video &&
        listEquality.equals(e1?.timelineVideo, e2?.timelineVideo) &&
        e1?.path == e2?.path;
  }

  @override
  int hash(StudentsRecord? e) => const ListEquality().hash([
        e?.studentName,
        e?.studentGender,
        e?.studentAddress,
        e?.dateOfBirth,
        e?.bloodGroup,
        e?.schoolName,
        e?.allergiesOthers,
        e?.parentsList,
        e?.timeline,
        e?.attendancePercentage,
        e?.attendanceDetails,
        e?.createdAt,
        e?.updatedAt,
        e?.parentsDetails,
        e?.className,
        e?.studentImage,
        e?.schoolref,
        e?.imageslist,
        e?.classref,
        e?.document,
        e?.isDraft,
        e?.video,
        e?.timelineVideo,
        e?.path
      ]);

  @override
  bool isValidKey(Object? o) => o is StudentsRecord;
}
