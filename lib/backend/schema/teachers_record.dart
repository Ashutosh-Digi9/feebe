import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TeachersRecord extends FirestoreRecord {
  TeachersRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "teacher_name" field.
  String? _teacherName;
  String get teacherName => _teacherName ?? '';
  bool hasTeacherName() => _teacherName != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "email_id" field.
  String? _emailId;
  String get emailId => _emailId ?? '';
  bool hasEmailId() => _emailId != null;

  // "teacher_attendance" field.
  List<TeachersAttendanceStruct>? _teacherAttendance;
  List<TeachersAttendanceStruct> get teacherAttendance =>
      _teacherAttendance ?? const [];
  bool hasTeacherAttendance() => _teacherAttendance != null;

  // "teacher_timeline" field.
  List<TeachersTimelineStruct>? _teacherTimeline;
  List<TeachersTimelineStruct> get teacherTimeline =>
      _teacherTimeline ?? const [];
  bool hasTeacherTimeline() => _teacherTimeline != null;

  // "Uploaded_pictures" field.
  List<String>? _uploadedPictures;
  List<String> get uploadedPictures => _uploadedPictures ?? const [];
  bool hasUploadedPictures() => _uploadedPictures != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  void _initializeFields() {
    _teacherName = snapshotData['teacher_name'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _emailId = snapshotData['email_id'] as String?;
    _teacherAttendance = getStructList(
      snapshotData['teacher_attendance'],
      TeachersAttendanceStruct.fromMap,
    );
    _teacherTimeline = getStructList(
      snapshotData['teacher_timeline'],
      TeachersTimelineStruct.fromMap,
    );
    _uploadedPictures = getDataList(snapshotData['Uploaded_pictures']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Teachers');

  static Stream<TeachersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TeachersRecord.fromSnapshot(s));

  static Future<TeachersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TeachersRecord.fromSnapshot(s));

  static TeachersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TeachersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TeachersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TeachersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TeachersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TeachersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTeachersRecordData({
  String? teacherName,
  String? phoneNumber,
  String? emailId,
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'teacher_name': teacherName,
      'phone_number': phoneNumber,
      'email_id': emailId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class TeachersRecordDocumentEquality implements Equality<TeachersRecord> {
  const TeachersRecordDocumentEquality();

  @override
  bool equals(TeachersRecord? e1, TeachersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.teacherName == e2?.teacherName &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.emailId == e2?.emailId &&
        listEquality.equals(e1?.teacherAttendance, e2?.teacherAttendance) &&
        listEquality.equals(e1?.teacherTimeline, e2?.teacherTimeline) &&
        listEquality.equals(e1?.uploadedPictures, e2?.uploadedPictures) &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt;
  }

  @override
  int hash(TeachersRecord? e) => const ListEquality().hash([
        e?.teacherName,
        e?.phoneNumber,
        e?.emailId,
        e?.teacherAttendance,
        e?.teacherTimeline,
        e?.uploadedPictures,
        e?.createdAt,
        e?.updatedAt
      ]);

  @override
  bool isValidKey(Object? o) => o is TeachersRecord;
}
